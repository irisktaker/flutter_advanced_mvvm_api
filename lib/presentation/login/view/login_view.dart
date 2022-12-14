import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppPreferences _preferences = instance<AppPreferences>();
  final GlobalKey _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start(); // tell the viewModel to start it's job
    _usernameController.addListener(() => _viewModel.setUsername(_usernameController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream.listen((isLoggedIn) {
      if(isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _preferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(RoutesManager.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context,AsyncSnapshot<FlowState> snapshot) {
          return snapshot.data
          ?.getScreenWidget(
            context, _getContentWidget(), 
            () {
              _viewModel.login();
            }
          ) ?? _getContentWidget();
        },
      ),
    );
  }

  // as default widget (main widget for each screen) - better code
  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          Expanded(flex:45, child: Container(padding: const EdgeInsets.only(top: AppPadding.p20, bottom: AppPadding.p20),child: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))))),
          Expanded(flex:45, child: Container(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // Login Field
                    StreamBuilder<bool>(
                      stream: _viewModel.outIsUsernameValid,
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: StringManager.username,
                            labelText: StringManager.username,
                            errorText: (snapshot.data ?? true ? null : StringManager.usernameError),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppSize.s10),

                    // Password Field
                    StreamBuilder<bool>(
                      stream: _viewModel.outIsPasswordValid,
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: StringManager.password,
                            labelText: StringManager.password,
                            errorText: (snapshot.data ?? true ? null : StringManager.passwordError),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppSize.s20),

                    // Button Action
                    StreamBuilder(
                      stream: _viewModel.outAreAllInputValid,
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: AppSize.s48,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                            ? () {
                              _viewModel.login();
                            }
                            : null,
                            child: const Text(StringManager.login)),
                        );
                      },
                    ),

                    const SizedBox(height: AppSize.s10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, RoutesManager.forgetPasswordRoute);
                          },
                          child: Text(
                            StringManager.forgotPassword,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                        TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, RoutesManager.registerRoute);
                          },
                          child: Text(
                            StringManager.registerText,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              )),
          )),
          Expanded(flex:10, child: Container()),
        ],
      ),
    );
  }
}