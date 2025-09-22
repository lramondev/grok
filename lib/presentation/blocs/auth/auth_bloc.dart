import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:grok/core/lifecycle/app_lifecycle_manager.dart';
import 'package:grok/presentation/blocs/auth/auth_event.dart';
import 'package:grok/presentation/blocs/auth/auth_state.dart';
import 'package:grok/data/repositories/auth_repository.dart';

import 'package:grok/data/models/user_model.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final AppLifecycleManager appLifecycleManager = AppLifecycleManager();

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthCheck>(_onAuthCheck);
    on<AuthLogin>(_onAuthLogin);
    on<AuthProfile>(_onAuthProfile);
    on<AuthLogout>(_onAuthLogout);
    add(AuthProfile());

    appLifecycleManager.init();
    appLifecycleManager.addResumedCallback(() => add(AuthCheck()));
  }

  Future<void> _onAuthCheck(
    AuthCheck event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.check();
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthLogin(
    AuthLogin event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.cpf, event.password);
      await _persistUserData(user);
      if (event.rememberMe) {
        await _saveCredentials(event.cpf, event.password);
      } else {
        await _clearCredentials();
      }
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit
  ) async {
    await clearUserData();
    emit(AuthInitial());
  }

  Future<void> _onAuthProfile(
    AuthProfile event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    try {
      final user = await loadPersistedUser();
      emit(AuthLoaded(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _persistUserData(UserModel user) async {
    await storage.write(key: 'user', value: jsonEncode(user));
  }

  Future<UserModel?> loadPersistedUser() async {
    final userData = await storage.read(key: 'user');
    if(userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<void> clearUserData() async {
    await storage.delete(key: 'user');
  }

  Future<void> _saveCredentials(String cpf, String password) async {
    await storage.write(key: 'saved_cpf', value: cpf);
    await storage.write(key: 'saved_password', value: password);
  }

  Future<Map<String, String>?> loadSavedCredentials() async {
    final cpf = await storage.read(key: 'saved_cpf');
    final password = await storage.read(key: 'saved_password');
    if (cpf != null && password != null) {
      return { 'cpf': cpf, 'password': password };
    }
    return null;
  }

  Future<void> _clearCredentials() async {
    await storage.delete(key: 'saved_cpf');
    await storage.delete(key: 'saved_password');
  }
}
