// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:github_star_app/models/repository_model.dart';

// A widget that displays a repository item in a card with expandable details.
class RepositoryListItem extends StatefulWidget {
  // The repository data to display.
  final Repository repository;

  // Constructor for initializing the repository.
  const RepositoryListItem({Key? key, required this.repository}) : super(key: key);

  @override
  _RepositoryListItemState createState() => _RepositoryListItemState();
}

class _RepositoryListItemState extends State<RepositoryListItem> {
  // State variable to track whether the item is expanded or not.
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        // Displays the repository owner's avatar.
        leading: CircleAvatar(
          backgroundImage: _getAvatarImage(),
          onBackgroundImageError: (exception, stackTrace) {
            print("Error loading avatar: $exception");
          },
          child: Text(widget.repository.ownerUsername[0].toUpperCase()),
        ),
        // Displays the repository name as the title.
        title: Text(
          'Repository: ${widget.repository.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // Displays the repository username and a preview of the description.
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
        // Displays the number of stars in the trailing icon.
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            SizedBox(width: 4),
            Text(widget.repository.stars.toString()),
          ],
        ),
        // Expanded content shows the full description of the repository.
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              _getFullDescription(),
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
        // Toggles expansion state when the tile is clicked.
        onExpansionChanged: (expanded) {
          setState(() {
            _expanded = expanded;
          });
        },
      ),
    );
  }

  // Returns an avatar image based on local path or network URL.
  ImageProvider _getAvatarImage() {
    if (widget.repository.localAvatarPath != null && widget.repository.localAvatarPath!.isNotEmpty) {
      print("Using local avatar: ${widget.repository.localAvatarPath}");
      return FileImage(File(widget.repository.localAvatarPath!));
    } else {
      print("Using network avatar: ${widget.repository.ownerAvatarUrl}");
      return NetworkImage(widget.repository.ownerAvatarUrl);
    }
  }

  // Provides a preview of the repository description.
  String _getDescriptionPreview() {
    if (widget.repository.description.isEmpty) {
      return 'No description provided for this repository.';
    }
    return widget.repository.description;
  }

  // Provides the full description of the repository.
  String _getFullDescription() {
    if (widget.repository.description.isEmpty) {
      return 'No description provided for this repository.';
    }
    return widget.repository.description;
  }
}
