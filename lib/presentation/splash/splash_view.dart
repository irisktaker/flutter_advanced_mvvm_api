import 'dart:async';

import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _preferences = instance<AppPreferences>();

  void _startDelay() =>_timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);

  void _goNext() async {
    _preferences.getUserLoggedIn().then((isUserLoggedIn) => {
      if (isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, RoutesManager.mainRoute)
      } else  {
        _preferences.getOnBoardingViewed().then((isOnBoardingViewed) => {
          if (isOnBoardingViewed){
              Navigator.pushReplacementNamed(context, RoutesManager.loginRoute)
            }
          else {
              Navigator.pushReplacementNamed(context, RoutesManager.onboardingRoute)
            }
          })
        }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}