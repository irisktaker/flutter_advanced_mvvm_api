import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{
  
  // ******************************************
  //? INPUTS 
  // ******************************************

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }
  
  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();
  
  @override
  // TODO: implement inputUsername
  Sink get inputUsername => throw UnimplementedError();
  
  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }
  
  @override
  setUsername(String setUsername) {
    // TODO: implement setUsername
    throw UnimplementedError();
  }
  
  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  // ******************************************
  //? OUTPUTS 
  // ******************************************
  
  @override
  // TODO: implement outIsPasswordValid
  Stream<bool> get outIsPasswordValid => throw UnimplementedError();
  
  @override
  // TODO: implement outIsUsernameValid
  Stream<bool> get outIsUsernameValid => throw UnimplementedError();
  
  
}

abstract class LoginViewModelInputs {
  setUsername(String setUsername);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
}