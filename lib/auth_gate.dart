import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foreign_emp_scam_checker/app_shell.dart';
import 'package:foreign_emp_scam_checker/core/cubit/app_user_cubit.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/screens/login_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isLoggedIn) {
        return isLoggedIn ? const AppShell() : const LoginScreen();
      },
    );
  }
}
