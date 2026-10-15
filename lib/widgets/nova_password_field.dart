import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';

class NovaPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final bool isPasswordVisible;
  final VoidCallback onToggleVisibility;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;

  const NovaPasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.isPasswordVisible,
    required this.onToggleVisibility,
    this.errorMessage,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorMessage != null && errorMessage!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: NovaColors.onSurfaceVariant,
            ),
          ),
        ),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: hasError
                ? NovaColors.errorContainer.withValues(alpha: 0.2)
                : NovaColors.surfaceContainerLow,
            borderRadius: NovaShapes.inputField,
          ),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: !isPasswordVisible,
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 15,
                color: NovaColors.onSurface,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: NovaColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: NovaColors.onSurfaceVariant,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: NovaColors.onSurfaceVariant,
                    size: 20,
                  ),
                  onPressed: onToggleVisibility,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              errorMessage!,
              style: const TextStyle(
                fontSize: 12,
                color: NovaColors.error,
              ),
            ),
          ),
      ],
    );
  }
}
