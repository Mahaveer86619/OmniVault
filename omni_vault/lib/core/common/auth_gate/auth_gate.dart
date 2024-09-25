import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_vault/core/common/app_user/app_user_cubit.dart';
import 'package:omni_vault/core/common/widgets/dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AppUserAuthenticated) {
          return const Placeholder();
        } else {
          return const Dashboard();
        }
      },
    );
  }
}