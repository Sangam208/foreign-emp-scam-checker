import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foreign_emp_scam_checker/core/cubit/app_user_cubit.dart';
import 'package:foreign_emp_scam_checker/core/utils/show_toast.dart';
import 'package:foreign_emp_scam_checker/features/auth/presentation/bloc/auth_bloc.dart';

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showToast('Logging out...');
            Future.delayed(
              Duration(seconds: 2),
              () {
                if (!context.mounted) return;
                context.read<AuthBloc>().add(AuthSignOut());
              },
            );
          },
          child: Center(
            child: Container(
              height: 90,
              width: double.infinity / 4,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Click here to logout',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
