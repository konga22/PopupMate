class UserBadge {
  const UserBadge({required this.title, required this.caption});

  final String title;
  final String caption;
}

class UserProfile {
  const UserProfile({
    required this.name,
    required this.handle,
    required this.bio,
    required this.reviewCount,
    required this.savedCount,
    required this.badges,
  });

  final String name;
  final String handle;
  final String bio;
  final int reviewCount;
  final int savedCount;
  final List<UserBadge> badges;
}
