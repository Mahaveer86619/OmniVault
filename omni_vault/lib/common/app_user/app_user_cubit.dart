import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:omni_vault/common/app_constants/app_constants.dart';
import 'package:omni_vault/common/repository/app_user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage;
  final Logger _logger;

  final AppUserRepository _appUserRepository;

  AppUserCubit({
    required SharedPreferences sharedPreferences,
    required FlutterSecureStorage secureStorage,
    required Logger logger,
    required AppUserRepository appUserRepository,
  })  : _secureStorage = secureStorage,
        _sharedPreferences = sharedPreferences,
        _logger = logger,
        _appUserRepository = appUserRepository,
        super(AppUserInitial());

  //* User passed on boarding screens
  Future<void> passedOnBoarding() async {
    emit(AppUserUnauthenticated());
  }

  //* Authenticate User
  Future<void> authenticateUser({
    required Map<String, dynamic> user,
    required String token,
  }) async {
    try {
      saveUser(user);
      saveToken(token);
      emit(AppUserAuthenticated()); 
    } catch (e) {
      _logger.e('Error authenticating user: $e');
      rethrow;
    }
  }

  //* Sign out user
  Future<void> signOutUser() async {
    try {
      await deleteUser();
      await deleteToken();
      emit(AppUserInitial());
    } catch (e) {
      _logger.e('Error signing out user: $e');
      rethrow;
    }
  }

  //* Save user to shared preferences
  Future<void> saveUser(Map<String, dynamic> userMap) async {
    try {
      await _sharedPreferences.setString(prefUserKey, jsonEncode(userMap));
      _logger.i('User saved successfully');
    } catch (e) {
      _logger.e('Error saving user: $e');
      rethrow;
    }
  }

  //* Save token to secure storage
  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(
        key: prefTokenKey,
        value: token,
      );
      _logger.i('Token saved successfully');
    } catch (e) {
      _logger.e('Error saving token: $e');
      rethrow;
    }
  }

  //* Get user from shared preferences
  Future<Map<String, dynamic>?> getUser() async {
    try {
      final userString = _sharedPreferences.getString(prefUserKey);
      if (userString == null) {
        return null;
      }
      final userMap = jsonDecode(userString);
      return userMap;
    } catch (e) {
      _logger.e('Error getting user: $e');
      rethrow;
    }
  }
  //* Get token from secure storage
  Future<String?> getToken() async {
    try {
      final tokenString = await _secureStorage.read(key: prefTokenKey) ?? '';
      if (tokenString.isEmpty) {
        return null;
      }
      return tokenString;
    } catch (e) {
      _logger.e('Error getting token: $e');
      rethrow;
    }
  }

  //* Delete user from shared preferences
  Future<void> deleteUser() async {
    try {
      await _sharedPreferences.remove(prefUserKey);
      _logger.i('User deleted successfully');
    } catch (e) {
      _logger.e('Error deleting user: $e');
      rethrow;
    }
  }
  //* Delete token from secure storage
  Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(key: prefTokenKey);
      _logger.i('Token deleted successfully');
    } catch (e) {
      _logger.e('Error deleting token: $e');
      rethrow;
    }
  }
}
