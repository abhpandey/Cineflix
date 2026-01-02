import 'package:ceniflix/core/error/failures.dart';
import 'package:ceniflix/features/auth/data/datasources/auth_datasource.dart';
import 'package:ceniflix/features/auth/data/datasources/local/auth_local_datasourse.dart';
import 'package:ceniflix/features/auth/data/models/auth_hive_model.dart';
import 'package:ceniflix/features/auth/domain/entities/auth_entity.dart';
import 'package:ceniflix/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IauthRepository>((ref){
  return AuthRepository(authDatasource:ref.read (authLocalDatasourceProvider));
});


class AuthRepository implements IauthRepository{
  final IAuthDatasource _authDatasource;

  AuthRepository({required IAuthDatasource authDatasource})
  : _authDatasource = authDatasource;

 @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async{
    try{
      final user = await _authDatasource.getCurrentUser();
      if(user!=null){
        final entity = user.toEntity();
        return Right(entity);
      }
      return Left(LocalDatabaseFailure(message: 'No user logged in'));
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login(String email, String password) async{
   try{
    final user = await _authDatasource.login(email, password);
    if(user != null){
      final entity = user.toEntity();
      return Right(entity);
    }
    return Left(LocalDatabaseFailure(message: 'Invalid email or password'));
   }catch(e){
    return Left(LocalDatabaseFailure(message: e.toString()));
   }
  }

  @override
  Future<Either<Failure, bool>> logout()async {
    try{
      await _authDatasource.logout();
      return Right(true);
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> register(AuthEntity entity)async {
    try{
      //model ma convert gara
        final model = AuthHiveModel.fromEntity(entity);
        final result = await _authDatasource.register(model);
        if(result){
          return Right(true);
        }
        return Left(LocalDatabaseFailure(message: 'Failed to register user'));
    }catch(e){
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}