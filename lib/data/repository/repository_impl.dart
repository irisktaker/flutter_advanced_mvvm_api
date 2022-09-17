import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/error_handler.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  // ******************************************
  //? LOGIN REPOSITORY IMPL
  // ******************************************

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected) 
    {
      // internet connected, safe to call the API

      LoggerDebug.loggerInformationMessage("networkInfo isConnected ${_networkInfo.isConnected}");

      try {
        final response = await _remoteDataSource.login(loginRequest);

        if(response.status == APIsInternalStatus.SUCCESS) { // we define status 0 as success in mocLab server
          //? success -- return data -- return either right
          LoggerDebug.loggerInformationMessage("response success ${response.toDomain()}");
          return Right(response.toDomain());

        } else {
          // failure -- business error -- return either left
          LoggerDebug.loggerErrorMessage("response failure ${APIsInternalStatus.FAILURE} , ${response.message}");
          return Left(Failure(APIsInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        LoggerDebug.loggerErrorMessage("Catch an error $error");
        return Left(ErrorHandler.errorHandler(error).failure);
      }
    } 
    else 
    {
      // no internet connected, show internet not connected error message
      // return either left
      LoggerDebug.loggerErrorMessage("Error ${DataSource.NO_INTERNET_CONNECTION.getFailure()}");
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  // ******************************************
  //? FORGOT PASSWORD REPOSITORY IMPL
  // ******************************************

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if(await _networkInfo.isConnected)
    {
      final response = await _remoteDataSource.forgotPassword(email);
      try {

        if(response.status == APIsInternalStatus.SUCCESS) {
          LoggerDebug.loggerInformationMessage("response success ${response.toDomain()}");
          return Right(response.toDomain());
        } else {
          LoggerDebug.loggerErrorMessage("response failure ${APIsInternalStatus.FAILURE} , ${response.message}");
          return Left(Failure(APIsInternalStatus.FAILURE, response.message ?? ResponseMessage.DEFAULT));
        }

      } catch (error) {
        LoggerDebug.loggerErrorMessage("Catch an error $error");
        return Left(ErrorHandler.errorHandler(error).failure);
      }


    } else
    {
      LoggerDebug.loggerErrorMessage("Error ${DataSource.NO_INTERNET_CONNECTION.getFailure()}");
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}