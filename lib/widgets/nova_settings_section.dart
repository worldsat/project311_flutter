import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_shapes.dart';
import '../theme/nova_spacing.dart';

class NovaAccountSecuritySection extends StatelessWidget {
  final DemoProfile profile;
  final bool securityEnabled;
  final ValueChanged<bool> onSecurityToggle;
  final VoidCallback onPersonalInfoClick;
  final VoidCallback onPaymentMethodsClick;

  const NovaAccountSecuritySection({
    super.key,
    required this.profile,
    required this.securityEnabled,
    required this.onSecurityToggle,
    required this.onPersonalInfoClick,
    required this.onPaymentMethodsClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            'Account & Security',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: NovaColors.primary,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: NovaColors.surfaceContainerLow,
            borderRadius: NovaShapes.settingsCard,
          ),
          child: Column(
            children: [
              _SettingsNavRow(
                icon: Icons.person_outline_rounded,
                title: 'Personal Information',
                subtitle: 'Name, email, contact details',
                onClick: onPersonalInfoClick,
              ),
              _SettingsSwitchRow(
                icon: Icons.shield_outlined,
                title: 'Security & Biometrics',
                subtitle: securityEnabled
                    ? 'Two-factor authentication enabled'
                    : 'Two-factor authentication disabled',
                isChecked: securityEnabled,
                onToggle: onSecurityToggle,
              ),
              _SettingsNavRow(
                icon: Icons.credit_card_outlined,
                title: 'Payment Methods',
                subtitle: 'Visa ending in ',
                onClick: onPaymentMethodsClick,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NovaAppPreferencesSection extends StatelessWidget {
  final DemoProfile profile;
  final bool materialYouEnabled;
  final ValueChanged<bool> onMaterialYouToggle;
  final VoidCallback onNotificationsClick;
  final VoidCallback onStorageClick;

  const NovaAppPreferencesSection({
    super.key,
    required this.profile,
    required this.materialYouEnabled,
    required this.onMaterialYouToggle,
    required this.onNotificationsClick,
    required this.onStorageClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            'App Preferences',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: NovaColors.primary,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: NovaColors.surfaceContainerLow,
            borderRadius: NovaShapes.settingsCard,
          ),
          child: Column(
            children: [
              _SettingsSwitchRow(
                icon: Icons.palette_outlined,
                title: 'Material You Theme',
                subtitle: 'Dynamic color palette adaptation',
                isChecked: materialYouEnabled,
                onToggle: onMaterialYouToggle,
              ),
              _SettingsNavRow(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                subtitle: 'Activity, messages, and mentions',
                onClick: onNotificationsClick,
              ),
              _SettingsStorageRow(
                profile: profile,
                onClick: onStorageClick,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsNavRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onClick;

  const _SettingsNavRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: NovaShapes.settingsCard,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: NovaColors.surfaceContainerHighest,
              ),
              child: Icon(
                icon,
                size: 20,
                color: NovaColors.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: NovaColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: NovaColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: NovaColors.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSwitchRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isChecked;
  final ValueChanged<bool> onToggle;

  const _SettingsSwitchRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onToggle(!isChecked),
      borderRadius: NovaShapes.settingsCard,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: NovaColors.surfaceContainerHighest,
              ),
              child: Icon(
                icon,
                size: 20,
                color: NovaColors.primary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: NovaColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: NovaColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isChecked,
              onChanged: onToggle,
              activeThumbColor: Colors.white,
              activeTrackColor: NovaColors.switchTrack,
              inactiveThumbColor: NovaColors.outline,
              inactiveTrackColor: NovaColors.surfaceVariant,
              thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Icon(
                    Icons.check,
                    color: NovaColors.primary,
                    size: 14,
                  );
                }
                return null;
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsStorageRow extends StatelessWidget {
  final DemoProfile profile;
  final VoidCallback onClick;

  const _SettingsStorageRow({required this.profile, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: NovaShapes.settingsCard,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: NovaColors.surfaceContainerHighest,
                  ),
                  child: const Icon(
                    Icons.cloud_outlined,
                    size: 20,
                    color: NovaColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data & Cloud Storage',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: NovaColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ' GB of  GB used',
                        style: const TextStyle(
                          fontSize: 12,
                          color: NovaColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: NovaColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 54),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: profile.storageProgressFraction,
                  minHeight: 6,
                  backgroundColor: NovaColors.surfaceContainerHighest,
                  valueColor: const AlwaysStoppedAnimation<Color>(NovaColors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NovaLogoutFooter extends StatelessWidget {
  final VoidCallback onLogoutClick;
  final String versionText;

  const NovaLogoutFooter({
    super.key,
    required this.onLogoutClick,
    this.versionText = 'Nova App v2.4.0 (Build 382) • Material 3',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onLogoutClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: NovaColors.errorContainer,
              foregroundColor: NovaColors.onErrorContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: NovaShapes.buttonPill,
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_rounded,
                  size: 20,
                  color: NovaColors.onErrorContainer,
                ),
                SizedBox(width: NovaSpacing.xs),
                Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: NovaSpacing.md),
        Text(
          versionText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: NovaColors.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
