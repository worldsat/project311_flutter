import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';
import '../theme/nova_spacing.dart';

class NovaProfileHero extends StatelessWidget {
  final DemoProfile profile;

  const NovaProfileHero({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar with overlaid badges
        SizedBox(
          width: 114,
          height: 114,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Avatar container
              Container(
                width: 112,
                height: 112,
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: NovaColors.surfaceContainerHigh,
                ),
                child: ClipOval(
                  child: Image.asset(
                    profile.avatarAsset,
                    width: 104,
                    height: 104,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Top-Right: Online status indicator
              if (profile.isOnline)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: NovaColors.statusOnline,
                      ),
                    ),
                  ),
                ),

              // Bottom-Right: Verified badge
              if (profile.isVerified)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: NovaColors.primaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.verified_rounded,
                      size: 20,
                      color: NovaColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: NovaSpacing.sm),

        // Display Name
        Text(
          profile.displayName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: NovaColors.onSurface,
          ),
        ),

        const SizedBox(height: NovaSpacing.xxs),

        // Handle & Role
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profile.handle,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: NovaColors.primary,
              ),
            ),
            const SizedBox(width: NovaSpacing.xs),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: NovaColors.outlineVariant,
              ),
            ),
            const SizedBox(width: NovaSpacing.xs),
            Text(
              profile.role,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: NovaColors.onSurfaceVariant,
              ),
            ),
          ],
        ),

        if (profile.isProMember) ...[
          const SizedBox(height: NovaSpacing.sm),
          // Pro Member Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: const BoxDecoration(
              color: NovaColors.surfaceContainerHigh,
              borderRadius: NovaShapes.chipPill,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.stars_rounded,
                  size: 16,
                  color: NovaColors.primary,
                ),
                SizedBox(width: 6),
                Text(
                  'Pro Member',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: NovaColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
