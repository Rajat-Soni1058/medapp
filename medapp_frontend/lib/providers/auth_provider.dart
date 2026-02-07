import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifier, StateNotifierProvider;
import 'package:medapp_frontend/services/authservice.dart';
import 'package:medapp_frontend/services/tokenstorage.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? role; // doc ya patient
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.role,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? role,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      role: role ?? this.role,
      error: error, 
    );
  }
}


final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthController(this._authService) : super(AuthState());

  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    final token = await TokenStorage.getToken();
    final role = await TokenStorage.getUserRole();

    if (token != null && token.isNotEmpty) {
      state = AuthState(isAuthenticated: true, role: role, isLoading: false);
    } else {
      state = AuthState(isAuthenticated: false, isLoading: false);
    }
  }

  Future<void> login(String email, String password, bool isDoctor) async {
    state = state.copyWith(isLoading: true, error: null);
    final error = await _authService.login(
      email: email, 
      password: password, 
      isDoctor: isDoctor
    );

    if (error == null) {
     
      state = AuthState(
        isAuthenticated: true, 
        role: isDoctor ? 'doctor' : 'patient',
        isLoading: false
      );
    } else {
      state = state.copyWith(isLoading: false, error: error);
    }
  }
  Future<bool> signUp(Map<String,dynamic> data, bool isDoctor) async {
    state = state.copyWith(isLoading: true, error: null);
    final error = await _authService.signUp(data: data, isDoctor: isDoctor);

    if (error == null) {
      // Success
      if (!isDoctor) {
    
        state = AuthState(isAuthenticated: true, role: 'patient', isLoading: false);
      } else {
     
        state = state.copyWith(isLoading: false);
      }
      return true;
    } else {      state = state.copyWith(isLoading: false, error: error);
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    state = AuthState(isAuthenticated: false);
  }
}


final authProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});
