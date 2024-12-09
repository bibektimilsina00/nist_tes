// auth_state.dart
class AuthState {
  final bool isLoading;
  final String error;
  final bool isLoggedIn;
  final String userPhone;

  const AuthState({
    this.isLoading = false,
    this.error = '',
    this.isLoggedIn = false,
    this.userPhone = '',
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoggedIn,
    String? userPhone,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userPhone: userPhone ?? this.userPhone,
    );
  }
}
