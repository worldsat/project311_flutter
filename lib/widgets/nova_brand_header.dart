import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_spacing.dart';

class NovaLoginBrandHeader extends StatelessWidget {
  const NovaLoginBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ambient Glow & Logo Emblem: size 130dp
        SizedBox(
          width: 130,
          height: 130,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Radial ambient glow
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      NovaColors.primaryContainer.withValues(alpha: 0.50),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Inner white circle 92dp with shadow spotColor = primary.copy(alpha: 0.2f)
              Container(
                width: 92,
                height: 92,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: NovaColors.primary.withValues(alpha: 0.20),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/nova_brand_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: NovaSpacing.xs),

        // Nova wordmark with red-pink dot accent
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nova',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: NovaColors.onSurface,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: NovaColors.secondaryContainer,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Welcome Back headline: 28sp Bold
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: NovaColors.onSurface,
          ),
        ),

        const SizedBox(height: 6),

        // Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Sign in to continue exploring your personalized workspace',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: NovaColors.onSurfaceVariant.withValues(alpha: 0.9),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
