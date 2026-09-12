import 'package:foreign_emp_scam_checker/core/errors/exceptions.dart';
import 'package:foreign_emp_scam_checker/core/errors/failure.dart';
import 'package:foreign_emp_scam_checker/core/storage/secure_storage.dart';
import 'package:foreign_emp_scam_checker/features/checker/data/datasources/agency_remote_data_source.dart';
import 'package:foreign_emp_scam_checker/features/checker/data/models/agency_model.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/repositories/agency_repository.dart';
import 'package:fpdart/fpdart.dart';

class AgencyRepositoryImpl implements AgencyRepository {
  final AgencyRemoteDataSource _agencyRemoteDataSource;
  final SecureStorage _secureStorage;
  AgencyRepositoryImpl(this._agencyRemoteDataSource, this._secureStorage);

  @override
  Future<Either<Failure, List<AgencyModel>>> getAgenciesData() async {
    try {
      final token = await _secureStorage.getToken();

      if (token == null || token.isEmpty) {
        return left(Failure("Authorization failed"));
      }

      final agenciesList = await _agencyRemoteDataSource.getAgenciesData(token);

      return right(agenciesList);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
