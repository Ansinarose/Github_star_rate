import 'package:flutter/material.dart';
import 'package:github_star_app/models/repository_model.dart';

class RepositoryListItem extends StatelessWidget {
  final Repository repository;

  const RepositoryListItem({Key? key, required this.repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(repository.ownerAvatarUrl),
      ),
      title: Text(
        'Repository: ${repository.name}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Username: ${repository.ownerUsername}'),
          SizedBox(height: 4),
          Text(
            repository.description,
            style: TextStyle(color: Colors.grey),
            maxLines: 2, // Limit to 2 lines if the description is long
            overflow: TextOverflow.ellipsis, // Add ellipsis for long text
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.yellow),
          SizedBox(width: 4),
          Text(repository.stars.toString()),
        ],
      ),
      
    );
  
  }
}
