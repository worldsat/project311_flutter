import 'package:flutter/material.dart';
import '../models/signup_state.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';
import '../theme/nova_spacing.dart';
import '../widgets/nova_form_field.dart';
import '../widgets/nova_password_field.dart';
import '../widgets/nova_primary_button.dart';
import '../widgets/nova_signup_brand_header.dart';
import '../widgets/nova_social_auth.dart';
import '../widgets/nova_wavy_background.dart';
import 'profile_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  SignUpUiState _state = const SignUpUiState();

  final RegExp _emailRegex =
      RegExp(r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: NovaColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    String? nameError;
    String? emailError;
    String? passwordError;
    String? confirmError;
    String? termsError;

    if (name.isEmpty) {
      nameError = 'Full name is required';
    }

    if (email.isEmpty) {
      emailError = 'Email is required';
    } else if (!_emailRegex.hasMatch(email)) {
      emailError = 'Please enter a valid email address';
    }

    if (password.isEmpty) {
      passwordError = 'Password is required';
    } else if (password.length < 8) {
      passwordError = 'Password must be at least 8 characters';
    }

    if (confirmPassword.isEmpty) {
      confirmError = 'Please confirm your password';
    } else if (confirmPassword != password) {
      confirmError = 'Passwords do not match';
    }

    if (!_state.acceptedTerms) {
      termsError = 'You must accept the terms to proceed';
    }

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmError != null ||
        termsError != null) {
      setState(() {
        _state = _state.copyWith(
          nameError: nameError,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmError,
          termsError: termsError,
        );
      });
      return;
    }

    setState(() {
      _state = _state.copyWith(
        isSubmitting: true,
        nameError: null,
        emailError: null,
        passwordError: null,
        confirmPasswordError: null,
        termsError: null,
      );
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      _state = _state.copyWith(isSubmitting: false);
    });

    _showFeedback('Account created successfully for $name!');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dynamic Wavy Background
          const Positioned.fill(
            child: NovaWavyBackground(),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  // Top Bar Navigation Back Action in floating frosted circle
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.94),
                            border: Border.all(color: Colors.white, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: NovaColors.primary.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 20,
                            color: NovaColors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Compact Brand Header
                  const NovaSignUpBrandHeader(),

                  const SizedBox(height: NovaSpacing.md),

                  // White Rounded Registration Form Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: NovaShapes.formCard,
                      border: Border.all(
                        color: const Color(0xFFC7D2FE).withValues(alpha: 0.7),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: NovaColors.primary.withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Full Name Field
                        NovaFormField(
                          controller: _nameController,
                          label: 'Full Name',
                          placeholder: 'Alex Morgan',
                          leadingIcon: Icons.person_outline_rounded,
                          errorMessage: _state.nameError,
                          onChanged: (val) {
                            setState(() => _state = _state.copyWith(
                              fullName: val,
                              nameError: null,
                            ));
                          },
                        ),

                        const SizedBox(height: NovaSpacing.sm),

                        // Email Field
                        NovaFormField(
                          controller: _emailController,
                          label: 'Email address',
                          placeholder: 'alex.morgan@domain.com',
                          leadingIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          errorMessage: _state.emailError,
                          onChanged: (val) {
                            setState(() => _state = _state.copyWith(
                              email: val,
                              emailError: null,
                            ));
                          },
                        ),

                        const SizedBox(height: NovaSpacing.sm),

                        // Password Field
                        NovaPasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          placeholder: '••••••••••••',
                          isPasswordVisible: _state.isPasswordVisible,
                          errorMessage: _state.passwordError,
                          onToggleVisibility: () {
                            setState(() {
                              _state = _state.copyWith(
                                isPasswordVisible: !_state.isPasswordVisible,
                              );
                            });
                          },
                          onChanged: (val) {
                            setState(() {
                              _state = _state.copyWith(
                                password: val,
                                passwordError: null,
                                confirmPasswordError: _state.confirmPassword.isNotEmpty &&
                                        _state.confirmPassword != val
                                    ? 'Passwords do not match'
                                    : null,
                              );
                            });
                          },
                        ),

                        const SizedBox(height: 6),

                        // Password Strength Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                for (int i = 1; i <= 4; i++) ...[
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: i <= _state.passwordStrengthLevel
                                          ? NovaColors.primary
                                          : NovaColors.primaryContainer,
                                    ),
                                  ),
                                  if (i < 4) const SizedBox(width: 4),
                                ],
                                if (_state.passwordStrengthLabel.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    _state.passwordStrengthLabel,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: NovaColors.primary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const Text(
                              'At least 8 chars',
                              style: TextStyle(
                                fontSize: 11,
                                color: NovaColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: NovaSpacing.sm),

                        // Confirm Password Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4, bottom: 6),
                              child: const Text(
                                'Confirm Password',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: NovaColors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            Container(
                              height: 54,
                              decoration: BoxDecoration(
                                color: _state.confirmPasswordError != null
                                    ? NovaColors.errorContainer.withValues(alpha: 0.2)
                                    : NovaColors.surfaceVariant.withValues(alpha: 0.7),
                                borderRadius: NovaShapes.inputField,
                                border: Border.all(
                                  color: _state.confirmPasswordError != null
                                      ? NovaColors.error
                                      : Colors.transparent,
                                  width: 1.2,
                                ),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_state.isPasswordVisible,
                                  onChanged: (val) {
                                    setState(() {
                                      _state = _state.copyWith(
                                        confirmPassword: val,
                                        confirmPasswordError: val.isNotEmpty &&
                                                val != _state.password
                                            ? 'Passwords do not match'
                                            : null,
                                      );
                                    });
                                  },
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: NovaColors.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '••••••••••••',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: NovaColors.onSurfaceVariant.withValues(alpha: 0.55),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.verified_outlined,
                                      color: NovaColors.onSurfaceVariant,
                                      size: 20,
                                    ),
                                    suffixIcon: _state.isConfirmPasswordMatching
                                        ? const Icon(
                                            Icons.check_circle_rounded,
                                            color: NovaColors.primary,
                                            size: 20,
                                          )
                                        : null,
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (_state.confirmPasswordError != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Text(
                                  _state.confirmPasswordError!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: NovaColors.error,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Consent Checkbox Row
                        InkWell(
                          onTap: () {
                            setState(() {
                              _state = _state.copyWith(
                                acceptedTerms: !_state.acceptedTerms,
                                termsError: null,
                              );
                            });
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _state.acceptedTerms
                                        ? NovaColors.primary
                                        : NovaColors.surfaceContainerHigh,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.center,
                                  child: _state.acceptedTerms
                                      ? const Icon(
                                          Icons.check,
                                          size: 14,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      const Text(
                                        'I agree to the ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: NovaColors.onSurfaceVariant,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _showFeedback(
                                            'Terms of Service: Nova Demo Workspace'),
                                        child: const Text(
                                          'Terms of Service',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                            color: NovaColors.primary,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        ' and ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: NovaColors.onSurfaceVariant,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _showFeedback(
                                            'Privacy Policy: Nova Demo Policy'),
                                        child: const Text(
                                          'Privacy Policy',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                            color: NovaColors.primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (_state.termsError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(
                              _state.termsError!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: NovaColors.error,
                              ),
                            ),
                          ),

                        const SizedBox(height: NovaSpacing.md),

                        // Create Account CTA Button
                        NovaPrimaryCtaButton(
                          text: 'Create Account',
                          isLoading: _state.isSubmitting,
                          onClick: _handleSubmit,
                        ),
                      ],
                    ),
                  ),

                  // Divider
                  const NovaDividerLabel(text: 'OR REGISTER WITH'),

                  // Social Buttons
                  NovaSocialAuthRow(
                    onGoogleClick: () =>
                        _showFeedback('Registering with Google is for preview only'),
                    onAppleClick: () =>
                        _showFeedback('Registering with Apple is for preview only'),
                  ),

                  const SizedBox(height: NovaSpacing.lg),

                  // Footer Sign In Link
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: NovaColors.primary.withValues(alpha: 0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 13,
                            color: NovaColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: NovaColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: NovaSpacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
