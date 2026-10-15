import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_spacing.dart';

class NovaSignUpBrandHeader extends StatelessWidget {
  const NovaSignUpBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Compact logo emblem with decorative spark badge
        SizedBox(
          width: 68,
          height: 68,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: NovaColors.surfaceContainerHigh,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        NovaColors.primaryContainer,
                        NovaColors.primary,
                        NovaColors.secondary,
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.all_inclusive_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),

              // Top-right spark accent badge
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: NovaColors.secondaryContainer,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.stars_rounded,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: NovaSpacing.xs),

        const Text(
          'NOVA',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: NovaColors.primary,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'Create Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: NovaColors.onSurface,
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          'Sign up to start your journey with Nova',
          style: TextStyle(
            fontSize: 13,
            color: NovaColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
