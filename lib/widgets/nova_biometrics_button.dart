import 'package:flutter/material.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';

class NovaBiometricsButton extends StatelessWidget {
  final VoidCallback onClick;

  const NovaBiometricsButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: NovaShapes.settingsCard,
        border: Border.all(
          color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClick,
          borderRadius: NovaShapes.settingsCard,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fingerprint_rounded,
                color: Color(0xFF4F46E5),
                size: 24,
              ),
              SizedBox(width: 10),
              Text(
                'Sign in with Biometrics',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: NovaColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
