import 'package:foreign_emp_scam_checker/core/entities/user.dart';
import 'package:foreign_emp_scam_checker/core/errors/exceptions.dart';
import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:foreign_emp_scam_checker/core/storage/secure_storage.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SecureStorage _authLocalDataSource;
  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final user = await _authRemoteDataSource.signInWithGoogle();
      _authLocalDataSource.setToken(user.token);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUserData() async {
    try {
      final token = await _authLocalDataSource.getToken();
      if (token == null || token.isEmpty) {
        return left(Failure("Token is empty"));
      }
      final user = await _authRemoteDataSource.getCurrentUserData(token);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authLocalDataSource.deleteToken();
      await _authRemoteDataSource.logout();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
