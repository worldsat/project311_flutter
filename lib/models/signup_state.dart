class SignUpUiState {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPasswordVisible;
  final bool acceptedTerms;
  final String? nameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;
  final String? termsError;
  final bool isSubmitting;
  final String? feedbackMessage;

  const SignUpUiState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordVisible = false,
    this.acceptedTerms = false,
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.termsError,
    this.isSubmitting = false,
    this.feedbackMessage,
  });

  int get passwordStrengthLevel {
    if (password.isEmpty) return 0;
    if (password.length < 4) return 1;
    if (password.length < 8) return 2;
    if (password.length < 12) return 3;
    return 4;
  }

  String get passwordStrengthLabel {
    return switch (passwordStrengthLevel) {
      0 => '',
      1 => 'Weak',
      2 => 'Fair security',
      3 => 'Medium security',
      _ => 'Strong security',
    };
  }

  bool get isConfirmPasswordMatching =>
      confirmPassword.isNotEmpty && confirmPassword == password;

  SignUpUiState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isPasswordVisible,
    bool? acceptedTerms,
    String? nameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    String? termsError,
    bool? isSubmitting,
    String? feedbackMessage,
  }) {
    return SignUpUiState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      nameError: nameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      termsError: termsError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      feedbackMessage: feedbackMessage,
    );
  }
}
