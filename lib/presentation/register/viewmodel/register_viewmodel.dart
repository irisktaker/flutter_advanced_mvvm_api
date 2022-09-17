
import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';

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
    // TODO: implement start
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



  // ******************************************
  //? OUTPUTS
  // ******************************************

  // -------------------------------------------------------------------------
  // ERRORS
  @override
  Stream<String?> get outputErrorEmailValid => outputErrorEmailValid.map((isEmailValid) => isEmailValid != null ? null : StringManager.invalidEmail);

  @override
  Stream<String?> get outputErrorMobileNumberValid => outputIsMobileNumberValid.map((mobileNumber) => mobileNumber ? null : StringManager.invalidMobileNumber);

  @override
  Stream<String?> get outputErrorPasswordValid => outputIsPasswordValid.map((password) => password ? null : StringManager.invalidPassword);

  @override
  Stream<String?> get outputErrorUserNameValid => outputIsUserNameValid.map((isUsernameValid) => isUsernameValid ? null : StringManager.invalidUsername);

  // -------------------------------------------------------------------------
  // OUTPUTS VALUES
  @override
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((event) => isEmailValid(event));

  @override
  Stream<bool> get outputIsMobileNumberValid => _mobileNumberStreamController.stream.map((event) => _isMobileNumberValid(event));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream.map((event) => _isPasswordValid(event));

  @override
  // TODO: implement outputIsProfilePictureValid
  Stream<File> get outputIsProfilePictureValid => _profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputIsUserNameValid => _usernameStreamController.stream.map((event) => _isUserNameValid(event));

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

}

abstract class RegisterViewModelInput
{
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
}

abstract class RegisterViewModelOutput
{
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsMobileNumberValid;
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsPasswordValid;
  
  Stream<File> get outputIsProfilePictureValid;

  // another idea ( same result in login but in another way )
  Stream<String?> get outputErrorUserNameValid;
  Stream<String?> get outputErrorMobileNumberValid;
  Stream<String?> get outputErrorEmailValid;
  Stream<String?> get outputErrorPasswordValid;
}