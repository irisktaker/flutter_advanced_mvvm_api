import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/forget_password/forget_password_view.dart';
import 'package:advanced_flutter/presentation/store_details/store_details_view.dart';
import 'package:advanced_flutter/presentation/onboarding/view/onboarding_view.dart';
import 'package:advanced_flutter/presentation/register/register_view.dart';
import 'package:advanced_flutter/presentation/splash/splash_view.dart';
import 'package:advanced_flutter/presentation/login/view/login_view.dart';
import 'package:advanced_flutter/presentation/main/main_view.dart';

import '/presentation/resources/all_resources.dart';

import 'package:flutter/material.dart';

class RoutesManager{
  static const String splashRoute = "/";
  static const String mainRoute = "/main";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String onboardingRoute = "/onboarding";
  static const String storeDetailsRoute = "/storeDetails";
  static const String forgetPasswordRoute = "/forgetPassword";
} 

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch(settings.name) {
      case RoutesManager.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      
      case RoutesManager.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case RoutesManager.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case RoutesManager.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      
      case RoutesManager.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      
      case RoutesManager.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      
      case RoutesManager.onboardingRoute: 
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      default: 
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(builder: (_) => Scaffold(
     body: Center(child: Text(StringManager.unDefinedRoute, style: getMediumStyle(ColorManager.darkGrey, FontSize.f16))), 
    ));
  }
}