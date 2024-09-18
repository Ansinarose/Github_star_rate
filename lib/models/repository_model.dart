class Repository {
  // Repository name.
  final String name;
  // Repository description.
  final String description;
  // Number of stars the repository has.
  final int stars;
  // Username of the repository owner.
  final String ownerUsername;
  // URL of the owner's avatar.
  final String ownerAvatarUrl;
  // Local path to the owner's avatar, if available.
  final String? localAvatarPath;

  // Constructor to initialize the Repository object with required fields and optional localAvatarPath.
  Repository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatarUrl,
    this.localAvatarPath
  });

  // Factory method to create a Repository instance from a JSON map.
  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      // Default to empty string if description is null.
      description: json['description'] ?? '',
      stars: json['stargazers_count'],
      ownerUsername: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
    );
  }

  // Converts the Repository instance to a map for storage or serialization.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'stars': stars,
      'ownerUsername': ownerUsername,
      'ownerAvatarUrl': ownerAvatarUrl,
      // Include localAvatarPath if it's not null.
      'localAvatarPath': localAvatarPath,
    };
  }
}
