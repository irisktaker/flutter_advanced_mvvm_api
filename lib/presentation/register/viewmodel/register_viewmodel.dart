
import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:flutter/cupertino.dart';

class RegisterViewModel extends BaseViewModel with RegisterViewModelInput, RegisterViewModelOutput{
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();
  final StreamController _areAllInputValidStreamController = StreamController<File>.broadcast();

  RegisterObject registerObject = RegisterObject("", "", "", "", "", "");

  final RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _usernameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    _areAllInputValidStreamController.close();
    super.dispose();
  }

  // ******************************************
  //? INPUTS
  // ******************************************

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _usernameStreamController.sink;

  @override
  Sink get inputAllInputsValid => _areAllInputValidStreamController.sink;

  @override
  setUsername(String username) {
    inputUserName.add(username);
    if(_isUserNameValid(username)) {
      // update register view object
      registerObject = registerObject.copyWith(username: username);
    } else {
      // reset user value in register view object
      registerObject = registerObject.copyWith(username: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if(isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if(_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if(_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if(profilePicture.path.isNotEmpty) {
      registerObject = registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    if(countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    validate();
  }


  @override
  register() async {
    inputState.add(LoadingState(StateRendererType.POPUP_LOADING_STATE));
    LoggerDebug.loggerInformationMessage(
        "username: ${registerObject.username} password: ${registerObject.password}"
            "email: ${registerObject.email} countryMobileCode: ${registerObject.countryMobileCode} mobileNumber: ${registerObject.mobileNumber} "
            "profilePicture: ${registerObject.profilePicture}");

    (await _registerUseCase.execute(RegisterUseCaseInput(registerObject.username, registerObject.countryMobileCode,
        registerObject.mobileNumber, registerObject.email, registerObject.password, registerObject.profilePicture))
    ).fold(
            (failure) {
              LoggerDebug.loggerErrorMessage(failure.message);
              inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
            },

            (success) {
              LoggerDebug.loggerInformationMessage(success.customer?.name);
              inputState.add(ContentState());

              // navigate to main screen
              // isUserLoggedInSuccessfullyStreamController.add(true);
            });
  }


  // ******************************************
  //? OUTPUTS
  // ******************************************

  // -------------------------------------------------------------------------
  // ERRORS
  @override
  Stream<String?> get outputErrorEmailValid => outputIsEmailValid.map((isEmailValid) => isEmailValid ? null : StringManager.invalidEmail);

  @override
  Stream<String?> get outputErrorMobileNumberValid => outputIsMobileNumberValid.map((mobileNumber) => mobileNumber ? null : StringManager.invalidMobileNumber);

  @override
  Stream<String?> get outputErrorPasswordValid => outputIsPasswordValid.map((password) => password ? null : StringManager.invalidPassword);

  @override
  Stream<String?> get outputErrorUserNameValid => outputIsUserNameValid.map((isUsernameValid) => isUsernameValid ? null : StringManager.invalidUsername);

  // -------------------------------------------------------------------------
  // OUTPUTS VALUES
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream.map((event) => _isMobileNumberValid(event));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((event) => _isPasswordValid(event));

  @override
  Stream<File> get outputProfilePicture => _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsUserNameValid => _usernameStreamController.stream.map((event) => _isUserNameValid(event));

  @override
  Stream<bool> get outputIsAllInputsValid => _areAllInputValidStreamController.stream.map((_) => _isAllInputValid());

  // ******************************************
  //? PRIVATE FUNCTION
  // ******************************************
  bool _isUserNameValid(String username) {
    return username.length >= 8;
  }
  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }
  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isAllInputValid() {
    return registerObject.countryMobileCode.isNotEmpty
        && registerObject.mobileNumber.isNotEmpty
        && registerObject.username.isNotEmpty
        && registerObject.profilePicture.isNotEmpty
        && registerObject.email.isNotEmpty
        && registerObject.password.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }

}

abstract class RegisterViewModelInput
{
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;

  Sink get inputAllInputsValid;

  setUsername(String username);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
  setCountryCode(String countryCode);

  register();
}

abstract class RegisterViewModelOutput
{
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsPasswordValid;
  
  Stream<File> get outputProfilePicture;

  // another idea ( same result in login but in another way )
  Stream<String?> get outputErrorUserNameValid;
  Stream<String?> get outputErrorMobileNumberValid;
  Stream<String?> get outputErrorEmailValid;
  Stream<String?> get outputErrorPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}