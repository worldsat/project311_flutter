import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';
import '../theme/nova_spacing.dart';

class NovaActionButtons extends StatelessWidget {
  final VoidCallback onEditProfileClick;
  final VoidCallback onShareClick;

  const NovaActionButtons({
    super.key,
    required this.onEditProfileClick,
    required this.onShareClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Primary Edit Profile Button
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: onEditProfileClick,
              style: ElevatedButton.styleFrom(
                backgroundColor: NovaColors.editButton,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: NovaShapes.buttonPill,
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(width: NovaSpacing.xs),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: NovaSpacing.sm),

        // Secondary Circular Share Button
        InkWell(
          onTap: onShareClick,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: NovaColors.surfaceContainer,
            ),
            child: const Icon(
              Icons.share_outlined,
              size: 20,
              color: NovaColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
