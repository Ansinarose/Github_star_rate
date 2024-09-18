import 'package:flutter_test/flutter_test.dart';
import 'package:github_star_app/models/repository_model.dart';

void main() {
  test('Repository.fromJson should create a Repository object from JSON', () {
    final json = {
      'name': 'flutter',
      'description': 'Flutter framework',
      'stargazers_count': 1000,
      'owner': {
        'login': 'flutter',
        'avatar_url': 'https://example.com/avatar.png',
      },
    };

    final repository = Repository.fromJson(json);

    expect(repository.name, 'flutter');
    expect(repository.description, 'Flutter framework');
    expect(repository.stars, 1000);
    expect(repository.ownerUsername, 'flutter');
    expect(repository.ownerAvatarUrl, 'https://example.com/avatar.png');
  });

  test('Repository.toMap should create a map from Repository object', () {
    final repository = Repository(
      name: 'flutter',
      description: 'Flutter framework',
      stars: 1000,
      ownerUsername: 'flutter',
      ownerAvatarUrl: 'https://example.com/avatar.png',
    );

    final map = repository.toMap();

    expect(map['name'], 'flutter');
    expect(map['description'], 'Flutter framework');
    expect(map['stars'], 1000);
    expect(map['ownerUsername'], 'flutter');
    expect(map['ownerAvatarUrl'], 'https://example.com/avatar.png');
    expect(map['localAvatarPath'], null);  // This will be null by default
  });
}
