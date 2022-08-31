
import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';

extension NonNullableString on String? {
  String orEmpty() {
    if(this == null) {
      return Constants.empty;
    } else {
      return this!; // ! means the value never will be null (be careful using it through the app)
    }
  }
}

extension NonNullableInteger on int? {
  int orZero() {
    if(this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}

extension NonNullableDouble on double? {
  double orZero() {
    if(this == null) {
      return Constants.zeroDouble;
    } else {
      return this!;
    }
  }
}

extension NonNullableBoolean on bool? {
  bool orBoolNull() {
    if(this == null) {
      return Constants.emptyBool;
    } else {
      return this!;
    }
  }
}

extension NonNullableList on List? {
  List orListEmpty() {
    if(this == null) {
      return Constants.emptyList;
    } else {
      return this!;
    }
  }
}

extension NonNullableMap on Map? {
  Map orMapEmpty() {
    if(this == null) {
      return Constants.emptyMap;
    } else {
      return this!;
    }
  }
}

extension NonNullableSet on Set? {
  Set oeSetEmpty() {
    if(this == null) {
      return Constants.emptySet;
    } else {
      return this!;
    }
  }
}

//? can be used for all data types (we create a new extension for the Data Type Class Methods)

//! For test
void testMethod() {
  String? data1;
  int? number1;
  String? data2 = 'test';
  int? number2 = 10;

  LoggerDebug.loggerDebugMessage("loggerDebugMessage: ${data1.orEmpty()}"); //! >> ""
  LoggerDebug.loggerDebugMessage("loggerDebugMessage: ${number1.orZero()}"); //! >> 0

  LoggerDebug.loggerDebugMessage("loggerDebugMessage: ${data2.orEmpty()}"); //! >> test
  LoggerDebug.loggerDebugMessage("loggerDebugMessage: ${number2.orZero()}"); //! >> 10
}