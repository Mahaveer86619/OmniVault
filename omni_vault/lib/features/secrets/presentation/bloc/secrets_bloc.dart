import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';

part 'secrets_event.dart';
part 'secrets_state.dart';

class SecretsBloc extends Bloc<SecretsEvent, SecretsState> {
  final Logger _logger;
  final AppUserCubit _appUserCubit;

  SecretsBloc({
    required AppUserCubit appUserCubit,
    required Logger logger,
  })  : _appUserCubit = appUserCubit,
        _logger = logger,
        super(SecretsInitial()) {
    on<SecretsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
