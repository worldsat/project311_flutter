import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';

class NovaPrimaryCtaButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final bool isLoading;

  const NovaPrimaryCtaButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: NovaColors.primary,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: NovaShapes.buttonPill,
          ),
          elevation: 2,
          shadowColor: NovaColors.primary.withValues(alpha: 0.4),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 19,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
