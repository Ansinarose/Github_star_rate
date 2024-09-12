import 'package:flutter/foundation.dart';
import '../models/repository_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

class RepositoryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseService _databaseService = DatabaseService();
  List<Repository> _repositories = [];
  bool _isLoading = false;

  List<Repository> get repositories => _repositories;
  bool get isLoading => _isLoading;

  Future<void> fetchRepositories(int page) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Repository> fetchedRepositories =
          await _apiService.fetchRepositories(page);
      _repositories.addAll(fetchedRepositories);

      for (var repo in fetchedRepositories) {
        await _databaseService.insertRepository(repo);
      }
    } catch (e) {
      print("Error fetching repositories: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCachedRepositories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _repositories = await _databaseService.getRepositories();
      print("Loaded ${_repositories.length} repositories from cache");
      for (var repo in _repositories) {
        print("Repo: ${repo.name}, Local Avatar: ${repo.localAvatarPath}");
      }
    } catch (e) {
      print("Error loading cached repositories: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}