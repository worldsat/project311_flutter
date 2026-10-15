enum ProfileDestination {
  home('Home'),
  discover('Discover'),
  messages('Messages'),
  profile('Profile');

  final String label;
  const ProfileDestination(this.label);
}

class DemoProfile {
  final String id;
  final String displayName;
  final String handle;
  final String role;
  final bool isProMember;
  final bool isVerified;
  final bool isOnline;
  final int projectsCount;
  final String followersLabel;
  final double rating;
  final String? paymentCardLastFour;
  final double storageUsedGb;
  final double storageCapacityGb;
  final String avatarAsset;
  final String logoAsset;

  const DemoProfile({
    required this.id,
    required this.displayName,
    required this.handle,
    required this.role,
    this.isProMember = true,
    this.isVerified = true,
    this.isOnline = true,
    required this.projectsCount,
    required this.followersLabel,
    required this.rating,
    this.paymentCardLastFour,
    required this.storageUsedGb,
    required this.storageCapacityGb,
    required this.avatarAsset,
    required this.logoAsset,
  });

  int get storagePercentage {
    if (storageCapacityGb <= 0) return 0;
    return ((storageUsedGb / storageCapacityGb) * 100).round().clamp(0, 100);
  }

  double get storageProgressFraction {
    if (storageCapacityGb <= 0) return 0.0;
    return (storageUsedGb / storageCapacityGb).clamp(0.0, 1.0);
  }
}

class MockProfileData {
  static const DemoProfile novaPreviewProfile = DemoProfile(
    id: 'nova-demo-profile',
    displayName: 'Elena Vance',
    handle: '@elenavance',
    role: 'Senior Product Designer',
    isProMember: true,
    isVerified: true,
    isOnline: true,
    projectsCount: 42,
    followersLabel: '12.8k',
    rating: 4.9,
    paymentCardLastFour: '4289',
    storageUsedGb: 18.4,
    storageCapacityGb: 50.0,
    avatarAsset: 'assets/images/avatar_elena.png',
    logoAsset: 'assets/images/nova_brand_logo.png',
  );
}
