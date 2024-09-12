class Repository {
  final String name;
  final String description;
  final int stars;
  final String ownerUsername;
  final String ownerAvatarUrl;
  final String? localAvatarPath;

  Repository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatarUrl,
    this.localAvatarPath
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      description: json['description'] ?? '',
      stars: json['stargazers_count'],
      ownerUsername: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'stars': stars,
      'ownerUsername': ownerUsername,
      'ownerAvatarUrl': ownerAvatarUrl,
      'localAvatarPath': localAvatarPath,
    };
  }
}
