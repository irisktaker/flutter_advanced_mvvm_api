import 'dart:async';

import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/resources/logger.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{

  // final StreamController _usernameStreamController = StreamController<String>(); //! only one listener
  final StreamController _usernameStreamController = StreamController<String>.broadcast(); //? has many listeners (broadcast())
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _areAllInputValidStreamController = StreamController<void>.broadcast(); // return nothing
  final StreamController isUserLoggedInSuccessfullyStreamController = StreamController<bool>(); // one listener

  var loginObject = LoginObject("","");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  // ******************************************
  //? INPUTS 
  // ******************************************

  @override
  void dispose() {
    super.dispose(); // -> call the dispose in the base_viewmodel.dart first
    _usernameStreamController.close();
    _passwordStreamController.close();
    _areAllInputValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell the view please show the content state
    inputState.add(ContentState()); // when screen load -> show the content of the screen first
  }
  
  @override
  Sink get inputPassword => _passwordStreamController.sink;
  
  @override
  Sink get inputUsername => _usernameStreamController.sink;

  @override 
  Sink get inputAreAllInputValid => _areAllInputValidStreamController.sink;
  
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputValid.add(null);
  }
  
  @override
  setUsername(String username) {
    inputUsername.add(username);
    loginObject = loginObject.copyWith(username: username);
    inputAreAllInputValid.add(null);
  }

  @override
  login() async {
    inputState.add(LoadingState(StateRendererType.POPUP_LOADING_STATE));

    LoggerDebug.loggerInformationMessage("username: ${loginObject.username} password: ${loginObject.password}");

    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.username, loginObject.password))
      ).fold(
        (failure) {
          //! l-> left - failure

          LoggerDebug.loggerErrorMessage(failure.message); // only for debug
          inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));

        }, //t@test.com

        (data) {
          //? r-> right - data (success)

          LoggerDebug.loggerInformationMessage(data.customer?.name); // only for debug
          inputState.add(ContentState());

          // navigate to main screen
          isUserLoggedInSuccessfullyStreamController.add(true);
        });
  }

  // ******************************************
  //? OUTPUTS 
  // ******************************************
  
  @override // changed the type from string to bool
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) => _isPasswordValid(password));
  
  @override
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));

  @override 
  Stream<bool> get outAreAllInputValid => _areAllInputValidStreamController.stream.map((_) => _areAllInputValid());

  bool _isPasswordValid(String password) => password.isNotEmpty;
  bool _isUsernameValid(String username) => username.isNotEmpty;
  bool _areAllInputValid() => _isPasswordValid(loginObject.password) && _isUsernameValid(loginObject.username);
}

abstract class LoginViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputAreAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputValid;
}