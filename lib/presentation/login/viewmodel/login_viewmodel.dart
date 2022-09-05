import 'dart:async';

import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{

  // final StreamController _usernameStreamController = StreamController<String>(); //! only one listener
  final StreamController _usernameStreamController = StreamController<String>.broadcast(); //? has many listeners (broadcast())
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  // ******************************************
  //? INPUTS 
  // ******************************************

  @override
  void dispose() {
    _usernameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }
  
  @override
  Sink get inputPassword => _passwordStreamController.sink;
  
  @override
  Sink get inputUsername => _usernameStreamController.sink;
  
  @override
  setPassword(String password) {
    _passwordStreamController.add(password);
  }
  
  @override
  setUsername(String username) {
    _usernameStreamController.add(username);
  }
  
  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  // ******************************************
  //? OUTPUTS 
  // ******************************************
  
  @override // changed the type from string to bool
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((pass) => _isPassValid(pass));
  
  @override
  Stream<bool> get outIsUsernameValid => _usernameStreamController.stream.map((username) => _isUsernameValid(username));

  bool _isPassValid(String password) => password.isNotEmpty;
  bool _isUsernameValid(String username) => username.isNotEmpty;
}

abstract class LoginViewModelInputs {
  setUsername(String username);
  setPassword(String password);
  login();

  Sink get inputUsername;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUsernameValid;
  Stream<bool> get outIsPasswordValid;
}