import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../theme/nova_colors.dart';
import '../theme/nova_spacing.dart';
import '../widgets/nova_action_buttons.dart';
import '../widgets/nova_bottom_nav_bar.dart';
import '../widgets/nova_profile_hero.dart';
import '../widgets/nova_settings_section.dart';
import '../widgets/nova_stats_card.dart';
import '../widgets/nova_top_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DemoProfile _profile = MockProfileData.novaPreviewProfile;
  bool _securityEnabled = true;
  bool _materialYouEnabled = true;
  ProfileDestination _selectedDestination = ProfileDestination.profile;

  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: NovaColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleLogout() {
    _showFeedback('Logged out of Nova session');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NovaColors.surface,
      appBar: NovaTopAppBar(
        onBackClick: () => Navigator.pop(context),
        onEditClick: () => _showFeedback('Edit profile requested'),
        onSettingsClick: () => _showFeedback('Settings requested'),
      ),
      bottomNavigationBar: NovaBottomNavigationBar(
        currentDestination: _selectedDestination,
        onDestinationSelect: (destination) {
          setState(() => _selectedDestination = destination);
          if (destination != ProfileDestination.profile) {
            _showFeedback('${destination.label} section demo');
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: NovaSpacing.md,
          vertical: NovaSpacing.xs,
        ),
        child: Column(
          children: [
            // Profile Hero (Avatar, Online badge, Verified badge, Name, Role, Pro Member)
            NovaProfileHero(profile: _profile),

            const SizedBox(height: NovaSpacing.lg),

            // Quick Stats Card (Projects, Followers, Rating)
            NovaStatsCard(profile: _profile),

            const SizedBox(height: NovaSpacing.lg),

            // Action Buttons (Edit Profile + Share)
            NovaActionButtons(
              onEditProfileClick: () => _showFeedback('Edit Profile clicked'),
              onShareClick: () => _showFeedback('Sharing profile @${_profile.handle}'),
            ),

            const SizedBox(height: NovaSpacing.lg),

            // Section 1: Account & Security
            NovaAccountSecuritySection(
              profile: _profile,
              securityEnabled: _securityEnabled,
              onSecurityToggle: (val) {
                setState(() => _securityEnabled = val);
                _showFeedback(val ? 'Security & Biometrics enabled' : 'Security disabled');
              },
              onPersonalInfoClick: () =>
                  _showFeedback('Personal Information: ${_profile.displayName}'),
              onPaymentMethodsClick: () =>
                  _showFeedback('Payment Methods: Visa ending in ${_profile.paymentCardLastFour}'),
            ),

            const SizedBox(height: NovaSpacing.lg),

            // Section 2: App Preferences
            NovaAppPreferencesSection(
              profile: _profile,
              materialYouEnabled: _materialYouEnabled,
              onMaterialYouToggle: (val) {
                setState(() => _materialYouEnabled = val);
                _showFeedback(val ? 'Material You dynamic colors enabled' : 'Material You disabled');
              },
              onNotificationsClick: () =>
                  _showFeedback('Push Notifications configuration'),
              onStorageClick: () =>
                  _showFeedback('Cloud Storage: ${_profile.storageUsedGb} GB used'),
            ),

            const SizedBox(height: NovaSpacing.lg),

            // Destructive Log Out & Version Footer
            NovaLogoutFooter(
              onLogoutClick: _handleLogout,
            ),

            const SizedBox(height: NovaSpacing.md),
          ],
        ),
      ),
    );
  }
}
