import 'package:flutter/material.dart';
import '../models/login_state.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_spacing.dart';
import '../widgets/nova_biometrics_button.dart';
import '../widgets/nova_brand_header.dart';
import '../widgets/nova_form_field.dart';
import '../widgets/nova_password_field.dart';
import '../widgets/nova_primary_button.dart';
import '../widgets/nova_social_auth.dart';
import '../widgets/nova_wavy_background.dart';
import 'profile_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginUiState _state = const LoginUiState();

  final RegExp _emailRegex =
      RegExp(r'^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    String? emailError;
    String? passwordError;

    if (email.isEmpty) {
      emailError = 'Email is required';
    } else if (!_emailRegex.hasMatch(email)) {
      emailError = 'Please enter a valid email address';
    }

    if (password.isEmpty) {
      passwordError = 'Password is required';
    }

    if (emailError != null || passwordError != null) {
      setState(() {
        _state = _state.copyWith(
          emailError: emailError,
          passwordError: passwordError,
        );
      });
      return;
    }

    setState(() {
      _state = _state.copyWith(
        isSubmitting: true,
        emailError: null,
        passwordError: null,
      );
    });

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      _state = _state.copyWith(isSubmitting: false);
    });

    _showFeedback('Welcome back, Elena!');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  Future<void> _handleBiometric() async {
    setState(() {
      _state = _state.copyWith(isSubmitting: true);
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      _state = _state.copyWith(isSubmitting: false);
    });

    _showFeedback('Biometric authentication verified!');

    Navigator.push(
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
          // Dynamic Wavy Background matching Kotlin NovaWavyBackground exactly
          const Positioned.fill(
            child: NovaWavyBackground(),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // Centered Brand Logo & Welcome Headings
                  const NovaLoginBrandHeader(),

                  const SizedBox(height: 20),

                  // Elegant Glassmorphic Form Card matching Kotlin
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color(0xFFC7D2FE).withValues(alpha: 0.70),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2514A5).withValues(alpha: 0.18),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Email Field
                        NovaFormField(
                          controller: _emailController,
                          label: 'Email address',
                          placeholder: 'name@example.com',
                          leadingIcon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          errorMessage: _state.emailError,
                          onChanged: (val) {
                            setState(() {
                              _state = _state.copyWith(
                                email: val,
                                emailError: null,
                              );
                            });
                          },
                        ),

                        const SizedBox(height: NovaSpacing.md),

                        // Password Field
                        NovaPasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          placeholder: 'Enter your password',
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
                              );
                            });
                          },
                        ),

                        const SizedBox(height: NovaSpacing.xs),

                        // Remember Me & Forgot Password Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Remember Me Checkbox
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _state = _state.copyWith(rememberMe: !_state.rememberMe);
                                });
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _state.rememberMe
                                          ? NovaColors.primary
                                          : NovaColors.surfaceContainerHigh,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.center,
                                    child: _state.rememberMe
                                        ? const Icon(
                                            Icons.check,
                                            size: 14,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: NovaColors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Forgot Password Link
                            GestureDetector(
                              onTap: () {
                                _showFeedback('Password reset: Demo recovery link requested');
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: NovaColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: NovaSpacing.md),

                        // Submit CTA Button
                        NovaPrimaryCtaButton(
                          text: 'Sign In',
                          isLoading: _state.isSubmitting,
                          onClick: _handleSubmit,
                        ),

                        // Divider with label
                        const NovaDividerLabel(text: 'OR CONTINUE WITH'),

                        // Social Federation Buttons
                        NovaSocialAuthRow(
                          onGoogleClick: () {
                            _showFeedback('Google sign-in demo requested');
                          },
                          onAppleClick: () {
                            _showFeedback('Apple sign-in demo requested');
                          },
                        ),

                        const SizedBox(height: NovaSpacing.sm),

                        // Biometrics Button
                        NovaBiometricsButton(
                          onClick: _handleBiometric,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: NovaSpacing.lg),

                  // Floating Frosted Sign Up Footer Pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2514A5).withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 13,
                            color: NovaColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
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
