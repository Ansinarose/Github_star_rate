import 'dart:io';
import 'package:flutter/material.dart';
import 'package:github_star_app/models/repository_model.dart';

class RepositoryListItem extends StatefulWidget {
  final Repository repository;

  const RepositoryListItem({Key? key, required this.repository})
      : super(key: key);

  @override
  _RepositoryListItemState createState() => _RepositoryListItemState();
}

class _RepositoryListItemState extends State<RepositoryListItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundImage: _getAvatarImage(),
          onBackgroundImageError: (exception, stackTrace) {
            print("Error loading avatar: $exception");
          },
          child: Text(widget.repository.ownerUsername[0].toUpperCase()),
        ),
        title: Text(
          'Repository: ${widget.repository.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${widget.repository.ownerUsername}'),
            SizedBox(height: 4),
            Text(
              _getDescriptionPreview(),
              style: TextStyle(color: Colors.grey),
              maxLines: _expanded ? null : 2,
              overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            SizedBox(width: 4),
            Text(widget.repository.stars.toString()),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              _getFullDescription(),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            _expanded = expanded;
          });
        },
      ),
    );
  }

  ImageProvider _getAvatarImage() {
    if (widget.repository.localAvatarPath != null && widget.repository.localAvatarPath!.isNotEmpty) {
      print("Using local avatar: ${widget.repository.localAvatarPath}");
      return FileImage(File(widget.repository.localAvatarPath!));
    } else {
      print("Using network avatar: ${widget.repository.ownerAvatarUrl}");
      return NetworkImage(widget.repository.ownerAvatarUrl);
    }
  }

  String _getDescriptionPreview() {
    if (widget.repository.description.isEmpty) {
      return 'No description provided for this repository.';
    }
    return widget.repository.description;
  }

  String _getFullDescription() {
    if (widget.repository.description.isEmpty) {
      return 'No description provided for this repository.';
    }
    return widget.repository.description;
  }
}