import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/entities/agency.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AgencyRepository {
  Future<Either<Failure, List<Agency>>> getAgenciesData();
}
