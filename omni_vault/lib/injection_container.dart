import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';
import 'package:omni_vault/common/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:omni_vault/common/repository/app_user_repo.dart';
import 'package:omni_vault/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:omni_vault/features/secrets/presentation/bloc/secrets_bloc.dart';
import 'package:omni_vault/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:omni_vault/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  other();
  core();
  dataSources();
  repositories();
  useCases();
  blocs();
}

void other() async {
  //* Register SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //* Register FlutterSecureStorage
  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  //* Register Logger
  sl.registerSingleton<Logger>(Logger());
}

void core() async {
  //* Register AppUserRepository
  sl.registerLazySingleton<AppUserRepository>(
    () => AppUserRepository(
      logger: sl<Logger>(),
    ),
  );
  //* Register AppUserCubit
  sl.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(
      sharedPreferences: sl<SharedPreferences>(),
      secureStorage: sl<FlutterSecureStorage>(),
      appUserRepository: sl<AppUserRepository>(),
      logger: sl<Logger>(),
    ),
  );
  //* Register NavigationBloc
  sl.registerLazySingleton<NavigationBloc>(
    () => NavigationBloc(),
  );
}

void dataSources() async {}

void repositories() async {}

void useCases() async {}

void blocs() async {
  //* Register NotesBloc
  sl.registerLazySingleton<NotesBloc>(
    () => NotesBloc(
      appUserCubit: sl(),
      logger: sl(),
    ),
  );
  //* Register SecretsBloc
  sl.registerLazySingleton<SecretsBloc>(
    () => SecretsBloc(
      appUserCubit: sl(),
      logger: sl(),
    ),
  );
  //* Register SettingsBloc
  sl.registerLazySingleton<SettingsBloc>(
    () => SettingsBloc(
      appUserCubit: sl(),
      logger: sl(),
    ),
  );
  //* Register TasksBloc
  sl.registerLazySingleton<TasksBloc>(
    () => TasksBloc(
      appUserCubit: sl(),
      logger: sl(),
    ),
  );
}
