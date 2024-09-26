import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit _appUserCubit;
  final Logger _logger;

  AuthBloc({
    required AppUserCubit appUserCubit,
    required Logger logger,
  })  : _appUserCubit = appUserCubit,
        _logger = logger,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
