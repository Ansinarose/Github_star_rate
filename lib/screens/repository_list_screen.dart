// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:github_star_app/common/constants/color_constant.dart';
import 'package:github_star_app/common/constants/custom_appbar.dart';
import 'package:github_star_app/common/widgets/repository_list.dart';
import 'package:provider/provider.dart';
import '../providers/repository_provider.dart';

/// A screen that displays a list of GitHub repositories.
class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  // Current page number for pagination
  int _page = 1;
  
  // ScrollController to detect when user has scrolled to the bottom
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add listener to scroll controller
    _scrollController.addListener(_onScroll);

    // Schedule initial data fetch after the build is complete
    Future.microtask(() {
      final repoProvider = Provider.of<RepositoryProvider>(context, listen: false);
      // Load cached repositories first
      repoProvider.loadCachedRepositories();
      // Then fetch new repositories
      repoProvider.fetchRepositories(_page);
    });
  }

  /// Called when the user scrolls to the bottom of the list
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has reached the bottom, load more data
      _page++;
      Provider.of<RepositoryProvider>(context, listen: false).fetchRepositories(_page);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Top starred Repositories'),
      body: Consumer<RepositoryProvider>(
        builder: (context, repoProvider, child) {
          if (repoProvider.isLoading && repoProvider.repositories.isEmpty) {
            // Show loading indicator if no data has been loaded yet
            return Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            controller: _scrollController,
            itemCount: repoProvider.repositories.length +
                (repoProvider.isLoading ? 1 : 0),
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              if (index == repoProvider.repositories.length) {
                // Show loading indicator at the bottom while loading more items
                return Center(child: CircularProgressIndicator());
              }

              final repository = repoProvider.repositories[index];
              return RepositoryListItem(repository: repository);
            },
          );
        },
      ),
    );
  }
}