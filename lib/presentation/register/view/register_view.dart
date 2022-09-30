import 'dart:io';

import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced_flutter/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker _imagePicker = instance<ImagePicker>();

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
          return snapshot.data?.getScreenWidget(context, _getContentWidget(), (){
            _viewModel.register();
          }) ?? _getContentWidget();
        },
      ),
    );
  }

  Widget _getMediaWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(child: Text(StringManager.profilePicture)),
        Flexible(
            child: StreamBuilder<File>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapshot) {
                return _imagePicketByUser(snapshot.data);
              },
            )),
        Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
      ],
    );
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return SafeArea(
        child:  Wrap(
          children: [
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera),
              title: const Text(StringManager.photoGallery),
              onTap: () {
                _imageFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text(StringManager.photoCamera),
              onTap: () {
                _imageFromCamera();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          Expanded(flex:30, child: Container(padding: const EdgeInsets.only(top: AppPadding.p20, bottom: AppPadding.p20),child: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))))),
          Expanded(flex:70, child: Container(
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      /// Username Field
                      StreamBuilder<String?>(
                        stream: _viewModel.outputErrorUserNameValid,
                        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _usernameTextEditingController,
                            decoration: InputDecoration(
                              hintText: StringManager.username,
                              labelText: StringManager.username,
                              errorText: snapshot.data,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: AppSize.s10),

                      /// Country Field
                      Center(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: CountryCodePicker(
                                  onChanged: (country) {
                                    // update view model with code
                                    _viewModel.setCountryCode(
                                        country.code ?? Constants.token);
                                  },
                                  initialSelection: '+02',
                                  favorite: const ['+39', 'FR', "+966"],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: true,
                                  hideMainText: true,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: true,
                                )),
                            Expanded(
                                flex: 4,
                                child: StreamBuilder<String?>(
                                    stream: _viewModel.outputErrorMobileNumberValid,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                        keyboardType: TextInputType.phone,
                                        controller: _mobileNumberTextEditingController,
                                        decoration: InputDecoration(
                                            hintText: StringManager.mobileNumber,
                                            labelText: StringManager.mobileNumber,
                                            errorText: snapshot.data),
                                      );
                                    }))
                          ],
                        ),
                      ),

                      const SizedBox(height: AppSize.s10),

                      /// Email Field
                      StreamBuilder<String?>(
                          stream: _viewModel.outputErrorEmailValid,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextEditingController,
                              decoration: InputDecoration(
                                  hintText: StringManager.emailHint,
                                  labelText: StringManager.emailHint,
                                  errorText: snapshot.data),
                            );
                        }),

                      const SizedBox(height: AppSize.s10),

                      /// Password Field
                      StreamBuilder<String?>(
                        stream: _viewModel.outputErrorPasswordValid,
                        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordTextEditingController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: StringManager.password,
                              labelText: StringManager.password,
                              errorText: snapshot.data,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: AppSize.s10),

                      /// Profile Picture
                      Container(
                        height: AppSize.s40,
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.grey),
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                        child: GestureDetector(
                          child: _getMediaWidget(),
                          onTap: () {
                            _showPicker(context);
                          },
                        ),
                      ),

                      const SizedBox(height: AppSize.s20),

                      /// Button Action
                      StreamBuilder<bool>(
                        stream: _viewModel.outputIsAllInputsValid,
                        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: AppSize.s48,
                            child: ElevatedButton(
                                onPressed: (snapshot.data ?? false)
                                    ? () {
                                  _viewModel.register();
                                }
                                    : null,
                                child: const Text(StringManager.register)),
                          );
                        },
                      ),

                      const SizedBox(height: AppSize.s10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              StringManager.alreadyHaveAccount,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                )),
          )),
        ],
      ),
    );
  }
}