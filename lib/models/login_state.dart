class LoginUiState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isPasswordVisible;
  final bool isSubmitting;
  final String? emailError;
  final String? passwordError;
  final String? feedbackMessage;

  const LoginUiState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isPasswordVisible = false,
    this.isSubmitting = false,
    this.emailError,
    this.passwordError,
    this.feedbackMessage,
  });

  LoginUiState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isPasswordVisible,
    bool? isSubmitting,
    String? emailError,
    String? passwordError,
    String? feedbackMessage,
  }) {
    return LoginUiState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      emailError: emailError,
      passwordError: passwordError,
      feedbackMessage: feedbackMessage,
    );
  }
}
