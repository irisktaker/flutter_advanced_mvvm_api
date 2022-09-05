import 'dart:async';

import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter/presentation/resources/logger.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs{

  // final StreamController _usernameStreamController = StreamController<String>(); //! only one listener
  final StreamController _usernameStreamController = StreamController<String>.broadcast(); //? has many listeners (broadcast())
  final StreamController _passwordStreamController = StreamController<String>.broadcast();

  var loginObject = LoginObject("","");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

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
    loginObject = loginObject.copyWith(password: password);
  }
  
  @override
  setUsername(String username) {
    _usernameStreamController.add(username);
    loginObject = loginObject.copyWith(username: username);
  }
  
  @override
  login() async {
    (await _loginUseCase.execute(LoginUseCaseInput(loginObject.username, loginObject.password))
      ).fold(
        (failure) => {
          //! l-> left - failure
          LoggerDebug.loggerErrorMessage(failure.resMessage)
        },
        (data) => {
          //? r-> right - data (success)
          LoggerDebug.loggerInformationMessage(data.customer?.name)
        });
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