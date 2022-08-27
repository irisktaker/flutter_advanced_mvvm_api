import 'package:flutter/material.dart';

import 'all_resources.dart';

ThemeData getApplicationTheme() => ThemeData(

  //? main colors
  primaryColor: ColorManager.primary,
  primaryColorLight: ColorManager.lightPrimary,
  primaryColorDark: ColorManager.darkPrimary,
  splashColor: ColorManager.lightPrimary, //? ripple effect color
  disabledColor: ColorManager.grey1,
  errorColor: ColorManager.error,

  //! card_view theme
  cardTheme: CardTheme(color: ColorManager.white, shadowColor: ColorManager.grey, elevation: AppSize.s4),

  //? app_bar theme
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: AppSize.s4,
    color: ColorManager.primary,
    shadowColor: ColorManager.lightPrimary,
    titleTextStyle: getRegularStyle(ColorManager.white, FontSize.f16),
  ),

  //! button theme
  buttonTheme: ButtonThemeData(
    shape: const StadiumBorder(),
    buttonColor: ColorManager.primary,
    splashColor: ColorManager.lightPrimary,
    disabledColor: ColorManager.grey1,
  ),

  //? elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: getRegularStyle(ColorManager.white, FontSize.f17),
      backgroundColor: ColorManager.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(FontSize.f12)),
    ),
  ),

  //! text theme
  textTheme: TextTheme(
    // cannot mix theme 2021 with 2018
    titleLarge: getBoldStyle(ColorManager.white, FontSize.f20),
    titleMedium: getSemiBoldStyle(ColorManager.darkGrey, FontSize.f16),
    titleSmall: getMediumStyle(ColorManager.lightGrey, FontSize.f14),
    labelMedium: getRegularStyle(ColorManager.primary, FontSize.f16),
    labelSmall: getRegularStyle(ColorManager.grey1),
    bodyMedium: getRegularStyle(ColorManager.grey, FontSize.f14),
    bodySmall: getRegularStyle(ColorManager.grey),
  ),

  //? input decoration theme (text_form_field)
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(AppPadding.p8),
    hintStyle: getRegularStyle(ColorManager.grey, FontSize.f14),
    labelStyle: getMediumStyle(ColorManager.grey, FontSize.f14),
    errorStyle: getRegularStyle(ColorManager.error, FontSize.f14),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1), borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.primary, width: AppSize.s1),borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
  ),


);
