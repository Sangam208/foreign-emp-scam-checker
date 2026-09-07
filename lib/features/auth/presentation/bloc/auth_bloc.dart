import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foreign_emp_scam_checker/core/cubit/app_user_cubit.dart';
import 'package:foreign_emp_scam_checker/core/entities/user.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/current_user.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_in.dart';
import 'package:foreign_emp_scam_checker/features/auth/domain/usecases/user_sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserSignOut _userSignOut;

  AuthBloc({
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignOut,
  }) : _userSignIn = userSignIn,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       _userSignOut = userSignOut,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthCurrentUser>(_isUserLoggedIn);
    on<AuthSignOut>(_onAuthSignOut);
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        _appUserCubit.updateUserStatus(r);
        emit(AuthSuccess(r));
      },
    );
  }

  void _isUserLoggedIn(
    AuthCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        _appUserCubit.updateUserStatus(r);
        emit(AuthSuccess(r));
      },
    );
  }

  void _onAuthSignOut(
    AuthSignOut event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignOut(NoParams());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) {
        _appUserCubit.updateUserStatus(null);
        emit(AuthInitial());
      },
    );
  }
}
