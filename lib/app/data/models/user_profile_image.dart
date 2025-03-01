class UserProfileImage {
  final String? small;
  final String? medium;
  final String? large;

  UserProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory UserProfileImage.fromJson(Map<String, dynamic> json) {
    return UserProfileImage(
      small: json['small'],
      medium: json['medium'],
      large: json['large'],
    );
  }
}