import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';

class NovaStatsCard extends StatelessWidget {
  final DemoProfile profile;

  const NovaStatsCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: const BoxDecoration(
        color: NovaColors.surfaceContainerHigh,
        borderRadius: NovaShapes.statsCard,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Column 1: Projects
          Expanded(
            child: _StatColumn(
              value: profile.projectsCount.toString(),
              label: 'PROJECTS',
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 36,
            color: NovaColors.outlineVariant,
          ),

          // Column 2: Followers
          Expanded(
            child: _StatColumn(
              value: profile.followersLabel,
              label: 'FOLLOWERS',
            ),
          ),

          // Divider
          Container(
            width: 1,
            height: 36,
            color: NovaColors.outlineVariant,
          ),

          // Column 3: Rating
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profile.rating.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: NovaColors.onSurface,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: NovaColors.ratingStar,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'RATING',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: NovaColors.onSurfaceVariant.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: NovaColors.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: NovaColors.onSurfaceVariant.withValues(alpha: 0.85),
          ),
        ),
      ],
    );
  }
}
