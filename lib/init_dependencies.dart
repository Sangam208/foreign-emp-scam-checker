import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foreign_emp_scam_checker/core/config/app_config.dart';
import 'package:foreign_emp_scam_checker/core/cubit/app_user_cubit.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/repositories/auth_repository.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/current_user.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_out.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';
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
    ..registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());

  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
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
