
import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
factory AppServiceClient(Dio dio,{String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthenticationResponse> login(@Field('email') String email, @Field('password') String password);

  @POST('/customers/forgot_password')
  Future<ForgotPasswordResponse> forgotPassword(@Field('email') String email);

  @POST('/customers/register')
  Future<AuthenticationResponse> register(
    @Field('username') String username,
    @Field('country_mobile_code') String countryMobileCode,
    @Field('mobile_number') String mobileNumber,
    @Field('email') String email,
    @Field('password') String password,
    @Field('profile_picture') String profilePicture,
  );
}