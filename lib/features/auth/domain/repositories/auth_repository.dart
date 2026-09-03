import 'package:foreign_emp_scam_checker/core/entities/user.dart';
import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signInWithGoogle();
}
