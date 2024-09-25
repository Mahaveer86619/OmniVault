import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';
import 'package:omni_vault/common/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:omni_vault/core/app_routes/app_routes.dart';
import 'package:omni_vault/common/endpoints/app_endpoints.dart';
import 'package:omni_vault/core/notifications/notifications.dart';
import 'package:omni_vault/core/theme/app_theme.dart';
import 'package:omni_vault/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:omni_vault/features/secrets/presentation/bloc/secrets_bloc.dart';
import 'package:omni_vault/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:omni_vault/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:omni_vault/injection_container.dart' as di;
import 'package:http/http.dart' as http;

void main() async {
  await setup();
  runApp(const MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await di.registerDependencies();

  await setupNotificationChannels();

  // // Test connection and make headers as json
  // final response = await http.get(
  //   Uri.parse(
  //     AppEndpoints.test,
  //   ),
  //   headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   },
  // );
  // debugPrint(response.body);
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
