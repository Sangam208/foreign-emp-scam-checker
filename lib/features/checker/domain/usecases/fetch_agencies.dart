import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:foreign_emp_scam_checker/core/usecases/usecase.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/entities/agency.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/repositories/agency_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchAgencies implements Usecase<List<Agency>, NoParams> {
  final AgencyRepository _agencyRepository;
  FetchAgencies(this._agencyRepository);

  @override
  Future<Either<Failure, List<Agency>>> call(params) async {
    return await _agencyRepository.getAgenciesData();
  }
}
