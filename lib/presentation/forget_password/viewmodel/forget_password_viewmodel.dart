
import 'dart:async';

import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/resources/logger.dart';

class ForgotPasswordViewModel extends BaseViewModel with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {

  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController = StreamController<void>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  String email = "";

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  forgotPassword() async {
    inputState.add(LoadingState(StateRendererType.POPUP_LOADING_STATE));
    LoggerDebug.loggerInformationMessage("email: $email");

    (await _forgotPasswordUseCase.execute(email)).fold(
          (failure) {
            LoggerDebug.loggerErrorMessage(failure.message); // only for debug
            inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
          },
          (success) {
            LoggerDebug.loggerInformationMessage(success); // only for debug
            inputState.add(ContentState());
          }
    );
  }

  // ******************************************
  //? INPUTS
  // ******************************************

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;


  // ******************************************
  //? OUTPUTS
  // ******************************************

  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map((_) => _isAllInputValid());

  _isAllInputValid() => isEmailValid(email);

  _validate() {
    inputIsAllInputsValid.add(null);
  }
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  forgotPassword();

  Sink get inputEmail;
  Sink get inputIsAllInputsValid;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputsValid;
}