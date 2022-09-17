import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  // <Left, Right> <Failure, Success>
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
}