
import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  final StreamController _usernameStreamController = StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController = StreamController<String>.broadcast();
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController = StreamController<File>.broadcast();
  final StreamController _areAllInputValidStreamController = StreamController<File>.broadcast();

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
  Stream<bool> get outputIsProfilePictureValid;

  // another idea ( same result in login but in another way )
  Stream<String> get outputErrorUserNameValid;
  Stream<String> get outputErrorMobileNumberValid;
  Stream<String> get outputErrorEmailValid;
  Stream<String> get outputErrorPasswordValid;
  Stream<String> get outputErrorProfilePictureValid;
}