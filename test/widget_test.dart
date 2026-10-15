import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/nova_theme.dart';

void main() {
  testWidgets('NovaApp Login Screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NovaApp());
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    // Initial state is empty, matching Android LoginUiState
    expect(find.text('elena.vance@nova.design'), findsNothing);
    expect(find.text('password123'), findsNothing);
  });

  testWidgets('SignUpScreen UI elements test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: NovaTheme.lightTheme,
        home: const SignUpScreen(),
      ),
    );
    expect(find.text('Create Account'), findsNWidgets(2));
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
  });

  testWidgets('ProfileScreen UI elements test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: NovaTheme.lightTheme,
        home: const ProfileScreen(),
      ),
    );
    // Profile Header & Hero
    expect(find.text('Profile'), findsNWidgets(2)); // Top app bar & Bottom nav
    expect(find.text('Elena Vance'), findsOneWidget);
    expect(find.text('@elenavance'), findsOneWidget);
    expect(find.text('Senior Product Designer'), findsOneWidget);
    expect(find.text('Pro Member'), findsOneWidget);

    // Stats
    expect(find.text('42'), findsOneWidget);
    expect(find.text('PROJECTS'), findsOneWidget);
    expect(find.text('12.8k'), findsOneWidget);
    expect(find.text('FOLLOWERS'), findsOneWidget);
    expect(find.text('4.9'), findsOneWidget);
    expect(find.text('RATING'), findsOneWidget);

    // Action Buttons
    expect(find.text('Edit Profile'), findsOneWidget);

    // Settings Sections
    expect(find.text('Account & Security'), findsOneWidget);
    expect(find.text('Personal Information'), findsOneWidget);
    expect(find.text('Security & Biometrics'), findsOneWidget);
    expect(find.text('Payment Methods'), findsOneWidget);
    expect(find.text('App Preferences'), findsOneWidget);
    expect(find.text('Material You Theme'), findsOneWidget);
    expect(find.text('Push Notifications'), findsOneWidget);
    expect(find.text('Data & Cloud Storage'), findsOneWidget);
    expect(find.text('Visa ending in 4289'), findsOneWidget);
    expect(find.text('18.4 GB of 50 GB used'), findsOneWidget);
    expect(find.text('37%'), findsOneWidget);

    // Logout
    expect(find.text('Log Out'), findsOneWidget);
  });
}
