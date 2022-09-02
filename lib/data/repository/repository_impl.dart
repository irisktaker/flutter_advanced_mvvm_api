import 'package:advanced_flutter/data/data_source/remote_data_source.dart';
import 'package:advanced_flutter/data/mapper/mapper.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/data/network/requests.dart';
import 'package:advanced_flutter/data/network/failure.dart';
import 'package:advanced_flutter/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected) {
      // internet connected, safe to call the API

      final response = await _remoteDataSource.login(loginRequest);
      if(response.status == 0) { // we define status 0 as success in mocLab server
        //? success -- return data -- return either right
        return Right(response.toDomain());

      } else {
        //! failure -- business error -- return either left
        return Left(Failure(409, response.message ?? "Business Error."));

      }

    } else {
      // no internet connected, show internet not connected error message
      //! return either left
      return Left(Failure(501, "Please check your internet connection."));
    }
  }
}