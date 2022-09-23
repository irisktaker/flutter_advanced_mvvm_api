import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameTextEditingController = TextEditingController();
  final TextEditingController _mobileNumberTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();

  _bind() {
    _viewModel.start();
    _usernameTextEditingController.addListener(() => _viewModel.setUsername(_usernameTextEditingController.text));
    _mobileNumberTextEditingController.addListener(() => _viewModel.setMobileNumber(_mobileNumberTextEditingController.text));
    _emailTextEditingController.addListener(() => _viewModel.setEmail(_emailTextEditingController.text));
    _passwordTextEditingController.addListener(() => _viewModel.setPassword(_passwordTextEditingController.text));
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
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (BuildContext context, AsyncSnapshot<FlowState> snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){}) ?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container();
  }
}