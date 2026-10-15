import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';

class NovaFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final IconData leadingIcon;
  final TextInputType keyboardType;
  final String? errorMessage;
  final ValueChanged<String>? onChanged;

  const NovaFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.leadingIcon,
    this.keyboardType = TextInputType.text,
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
              keyboardType: keyboardType,
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
                prefixIcon: Icon(
                  leadingIcon,
                  color: NovaColors.onSurfaceVariant,
                  size: 20,
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
