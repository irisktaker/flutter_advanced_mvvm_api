// ignore_for_file: constant_identifier_names

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNET_SERVER_ERROR,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
}

class ResponseCode {
  
  static const String SUCCESS = "Success."; //200. success, with data
  static const String NO_CONTENT = "Success."; //201. success, with no data (no content)
  static const String BAD_REQUEST = "Bad request, Try again later."; // 400. failure, API rejected request
  static const String FORBIDDEN = "Forbidden request, Try again later."; //403. failure, API rejected request
  static const String UNAUTHORIZED = "User is unauthorized, Try again later."; //401. failure, user is not authorized
  static const String NOT_FOUND = "Page not found."; //404. failure, page not found
  static const String INTERNET_SERVER_ERROR = "Some thing went wrong, Try again later."; //500. failure, crash in server side

  //? local status code
  static const String CONNECTION_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "Request was cancelled, Try again later";
  static const String RECEIVE_TIMEOUT = "Time out error, Try again later";
  static const String SEND_TIMEOUT = "Time out error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your internet connection";
  static const String UNKNOWN = "Some thing went wrong, Try again later";
}