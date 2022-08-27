import 'package:flutter/material.dart';

import 'all_resources.dart';


TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color, [String? fontFamily = FontConstants.fontFamily]) 
  => TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color, fontFamily: fontFamily);

// light style
TextStyle getLightStyle(Color color, [double fontSize = FontSize.f12]) => _getTextStyle(fontSize, FontWeightManager.light, color);

// regular style
TextStyle getRegularStyle(Color color, [double fontSize = FontSize.f12]) => _getTextStyle(fontSize, FontWeightManager.regular, color);

// medium style
TextStyle getMediumStyle(Color color, [double fontSize = FontSize.f12]) => _getTextStyle(fontSize, FontWeightManager.medium, color);

// semi bold style
TextStyle getSemiBoldStyle(Color color, [double fontSize = FontSize.f12]) => _getTextStyle(fontSize, FontWeightManager.semiBold, color);

// bold style
TextStyle getBoldStyle(Color color, [double fontSize = FontSize.f12]) => _getTextStyle(fontSize, FontWeightManager.bold, color);
