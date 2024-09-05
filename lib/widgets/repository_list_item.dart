import 'package:flutter/material.dart';
import '../models/repository_model.dart';

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
      title: Text(repository.name),
      subtitle: Text(repository.description),
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
