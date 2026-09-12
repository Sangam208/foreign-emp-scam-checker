import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foreign_emp_scam_checker/core/config/app_config.dart';
import 'package:foreign_emp_scam_checker/core/cubit/app_user_cubit.dart';
import 'package:foreign_emp_scam_checker/core/storage/secure_storage.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/repositories/auth_repository.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/current_user.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:foreign_emp_scam_checker/features/checker/data/datasources/agency_remote_data_source.dart';
import 'package:foreign_emp_scam_checker/features/checker/data/repositories/agency_repository_impl.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/repositories/agency_repository.dart';
import 'package:foreign_emp_scam_checker/features/checker/domain/usecases/fetch_agencies.dart';
import 'package:foreign_emp_scam_checker/features/checker/presentation/bloc/agency_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await GoogleSignIn.instance.initialize(
    clientId: dotenv.env['CLIENT_ID'],
    serverClientId: googleServerClientId,
  );

  serviceLocator
    ..registerLazySingleton<GoogleSignIn>(
      () => GoogleSignIn.instance,
    )
    ..registerLazySingleton(
      () => AppUserCubit(),
    )
    ..registerLazySingleton<Dio>(() => Dio())
    ..registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage())
    ..registerFactory<SecureStorage>(
      () => SecureStorageImpl(
        serviceLocator(),
      ),
    );

  _initAuth();
  _initAgency();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignOut(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignIn: serviceLocator(),
        appUserCubit: serviceLocator(),
        currentUser: serviceLocator(),
        userSignOut: serviceLocator(),
      ),
    );
}

void _initAgency() {
  serviceLocator
    ..registerFactory<AgencyRemoteDataSource>(
      () => AgencyRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AgencyRepository>(
      () => AgencyRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchAgencies(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AgencyBloc(
        agenciesFetch: serviceLocator(),
      ),
    );
}
