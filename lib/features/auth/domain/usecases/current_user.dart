import 'package:foreign_emp_scam_checker/core/entities/user.dart';
import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:foreign_emp_scam_checker/core/usecases/usecase.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/repositories/auth_repository.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository _authRepository;
  const CurrentUser(this._authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.getCurrentUserData();
  }
}
