import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_spacing.dart';

class NovaTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackClick;
  final VoidCallback onEditClick;
  final VoidCallback onSettingsClick;

  const NovaTopAppBar({
    super.key,
    required this.onBackClick,
    required this.onEditClick,
    required this.onSettingsClick,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: NovaSpacing.md),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered Title
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: NovaColors.onSurface,
              ),
            ),

            // Left Navigation and Brand Logo
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onBackClick,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: NovaColors.surfaceContainer,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 20,
                        color: NovaColors.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: NovaSpacing.xs),
                  Image.asset(
                    'assets/images/nova_brand_logo.png',
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            // Right Actions (Edit, Settings)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onEditClick,
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 20,
                      color: NovaColors.onSurfaceVariant,
                    ),
                  ),
                  IconButton(
                    onPressed: onSettingsClick,
                    icon: const Icon(
                      Icons.settings_outlined,
                      size: 20,
                      color: NovaColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
