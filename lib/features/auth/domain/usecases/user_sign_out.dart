import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:foreign_emp_scam_checker/core/usecases/usecase.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/repositories/auth_repository.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements Usecase<void, NoParams> {
  final AuthRepository _authRepository;
  const UserSignOut(this._authRepository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _authRepository.logout();
  }
}
