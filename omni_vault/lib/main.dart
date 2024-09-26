import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:omni_vault/common/app_constants/app_constants.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';
import 'package:omni_vault/common/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:omni_vault/core/app_routes/app_routes.dart';
import 'package:omni_vault/core/notifications/notifications.dart';
import 'package:omni_vault/core/theme/app_theme.dart';
import 'package:omni_vault/core/theme/pallete.dart';
import 'package:omni_vault/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:omni_vault/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:omni_vault/features/secrets/presentation/bloc/secrets_bloc.dart';
import 'package:omni_vault/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:omni_vault/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:omni_vault/injection_container.dart' as di;

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await di.registerDependencies();

  await setupNotificationChannels();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Pallete.transparentColor,
  ));

  debugPrint(welcomeString);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppUserCubit>(
          create: (context) => di.sl<AppUserCubit>(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => di.sl<NavigationBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<NotesBloc>(
          create: (context) => di.sl<NotesBloc>(),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => di.sl<TasksBloc>(),
        ),
        BlocProvider<SecretsBloc>(
          create: (context) => di.sl<SecretsBloc>(),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => di.sl<SettingsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'OmniVault',
        theme: darkMode,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
