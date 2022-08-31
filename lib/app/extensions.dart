import 'package:advanced_flutter/presentation/resources/logger.dart';

extension NonNullableString on String? {
  String orEmpty() {
    if(this == null) {
      return '';
    } else {
      return this!; // ! means the value never will be null (be careful using it through the app)
    }
  }
}

extension NonNullableInteger on int? {
  int orZero() {
    if(this == null) {
      return 0;
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

  LoggerDebug.loggerDebugMessage(data1.orEmpty()); //! >> ""
  LoggerDebug.loggerDebugMessage(number1.orZero().toString()); //! >> 0

  LoggerDebug.loggerDebugMessage(data2.orEmpty()); //! >> test
  LoggerDebug.loggerDebugMessage(number2.orZero().toString()); //! >> 10
}