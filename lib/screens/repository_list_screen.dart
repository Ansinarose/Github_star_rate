
import 'package:flutter/material.dart';
import 'package:github_star_app/common/constants/custom_appbar.dart';
import 'package:github_star_app/common/widgets/repository_list.dart';
import 'package:provider/provider.dart';
import '../providers/repository_provider.dart';

class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}

class _RepositoryListScreenState extends State<RepositoryListScreen> {
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final repoProvider = Provider.of<RepositoryProvider>(context, listen: false);
    repoProvider.loadCachedRepositories();
    repoProvider.fetchRepositories(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        repoProvider.fetchRepositories(_page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text('GitHub Repositories')),
     appBar: CustomAppBar(title: 'Top starred Repositories'),
      body: Consumer<RepositoryProvider>(
        builder: (context, repoProvider, child) {
          if (repoProvider.isLoading && repoProvider.repositories.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            controller: _scrollController,
            itemCount: repoProvider.repositories.length +
                (repoProvider.isLoading ? 1 : 0),
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              if (index == repoProvider.repositories.length) {
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