import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foreign_emp_scam_checker/core/config/app_config.dart';
import 'package:foreign_emp_scam_checker/core/errors/exceptions.dart';
import 'package:foreign_emp_scam_checker/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GoogleSignIn _googleSignIn;
  final Dio _client;

  AuthRemoteDataSourceImpl(this._googleSignIn, this._client) {
    _client.options.headers['User-Agent'] = 'JobGuard/1.0 - (Flutter) - Academic Project - sangam.dhital72@gmail.com';
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final userAcc = await _googleSignIn.authenticate();
      final idToken = userAcc.authentication.idToken!;
      final user = UserModel(
        name: userAcc.displayName ?? 'Unknown',
        email: userAcc.email,
        profilePic: userAcc.photoUrl ?? '',
        uid: '',
        token: '',
        idToken: idToken,
      );

      var response = await _client.post(
        '$host/api/signup',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: idToken,
      );

      if (response.data == null) {
        throw ServerException('Server returned an empty response');
      }

      final newUser = user.copyWith(
        uid: jsonDecode(response.data)['user']['_id'],
        token: jsonDecode(response.data)['token'],
      );
      return UserModel.fromJson(newUser.toJson());
    } on GoogleSignInException catch (e) {
      throw ServerException("Google sign in failed: ${e.description}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ServerException(
          "Network error, please check your connection",
        );
      }
      final statusCode = e.response?.statusCode;
      throw ServerException("Sign in Failed $statusCode");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
