import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Logger _logger;
  final AppUserCubit _appUserCubit;
  
  SettingsBloc({
    required AppUserCubit appUserCubit,
    required Logger logger,
  }) : _appUserCubit = appUserCubit,
      _logger = logger,
  super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
