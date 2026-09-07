import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foreign_emp_scam_checker/core/common/widgets/loader.dart';
import 'package:foreign_emp_scam_checker/core/utils/show_toast.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) showToast(state.message);
          },
          builder: (context, state) {
            return state is AuthLoading
                ? const Loader()
                : ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignIn());
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                    label: Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(170, 50),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
