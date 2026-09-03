import 'package:dio/dio.dart';
import 'package:foreign_emp_scam_checker/core/config/app_config.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/repositories/auth_repository.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await GoogleSignIn.instance.initialize(serverClientId: googleServerClientId);

  serviceLocator
    ..registerLazySingleton<GoogleSignIn>(
      () => GoogleSignIn.instance,
    )
    ..registerLazySingleton<Dio>(() => Dio());

  _initAuth();
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
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignIn: serviceLocator(),
      ),
    );
}
