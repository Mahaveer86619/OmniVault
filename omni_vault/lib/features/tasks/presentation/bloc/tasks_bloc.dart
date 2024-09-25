import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:omni_vault/common/app_user/app_user_cubit.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final Logger _logger;
  final AppUserCubit _appUserCubit;

  TasksBloc({
    required AppUserCubit appUserCubit,
    required Logger logger,
  })  : _appUserCubit = appUserCubit,
        _logger = logger,
        super(TasksInitial()) {
    on<TasksEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
