part of 'app_user_cubit.dart';

sealed class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object> get props => [];
}

final class AppUserInitial extends AppUserState {}
final class AppUserUnauthenticated extends AppUserState {}
final class AppUserAuthenticated extends AppUserState {}
