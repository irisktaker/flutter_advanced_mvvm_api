import 'package:logger/logger.dart';

class LoggerDebug {
  static final Logger logger = Logger();

  static void loggerDebugMessage(String? msg) => logger.d(msg);
  static void loggerWarningMessage(String? msg) => logger.w(msg);
  static void loggerErrorMessage(String? msg) => logger.e(msg);
  static void loggerInformationMessage(String? msg) => logger.i(msg);
  static void loggerWTFMessage(String? msg) => logger.wtf(msg);
}