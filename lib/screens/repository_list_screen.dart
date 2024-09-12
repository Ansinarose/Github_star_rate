// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:github_star_app/common/constants/color_constant.dart';
import 'package:github_star_app/common/constants/custom_appbar.dart';
import 'package:github_star_app/common/widgets/repository_list.dart';
import 'package:provider/provider.dart';
import '../providers/repository_provider.dart';

// class RepositoryListScreen extends StatefulWidget {
//   @override
//   _RepositoryListScreenState createState() => _RepositoryListScreenState();
// }

// class _RepositoryListScreenState extends State<RepositoryListScreen> {
//   int _page = 1;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
    
//     // Use Future.microtask to schedule the initial data fetch after the build is complete
//     Future.microtask(() {
//       final repoProvider = Provider.of<RepositoryProvider>(context, listen: false);
//       repoProvider.loadCachedRepositories();
//       repoProvider.fetchRepositories(_page);
//     });
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       _page++;
//       Provider.of<RepositoryProvider>(context, listen: false).fetchRepositories(_page);
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppConstants.scaffoldBackgroundColor,
//       appBar: CustomAppBar(title: 'Top starred Repositories'),
//       body: Consumer<RepositoryProvider>(
//         builder: (context, repoProvider, child) {
//           if (repoProvider.isLoading && repoProvider.repositories.isEmpty) {
//             return Center(child: CircularProgressIndicator());
//           }

//           return ListView.separated(
//             controller: _scrollController,
//             itemCount: repoProvider.repositories.length +
//                 (repoProvider.isLoading ? 1 : 0),
//             separatorBuilder: (context, index) => Divider(),
//             itemBuilder: (context, index) {
//               if (index == repoProvider.repositories.length) {
//                 return Center(child: CircularProgressIndicator());
//               }

//               final repository = repoProvider.repositories[index];
//               return RepositoryListItem(repository: repository);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
class RepositoryListScreen extends StatefulWidget {
  @override
  _RepositoryListScreenState createState() => _RepositoryListScreenState();
}
class _RepositoryListScreenState extends State<RepositoryListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    Future.microtask(() {
      final repoProvider = Provider.of<RepositoryProvider>(context, listen: false);
      repoProvider.loadCachedRepositories();
      repoProvider.fetchRepositories();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      Provider.of<RepositoryProvider>(context, listen: false).fetchRepositories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Top starred Repositories'),
      body: Consumer<RepositoryProvider>(
        builder: (context, repoProvider, child) {
          if (repoProvider.isLoading && repoProvider.repositories.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => repoProvider.refreshRepositories(),
            child: ListView.separated(
              controller: _scrollController,
              itemCount: repoProvider.repositories.length + (repoProvider.hasMoreData ? 1 : 0),
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                if (index == repoProvider.repositories.length) {
                  return repoProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink();
                }

                final repository = repoProvider.repositories[index];
                return RepositoryListItem(repository: repository);
              },
            ),
          );
        },
      ),
    );
  }
}