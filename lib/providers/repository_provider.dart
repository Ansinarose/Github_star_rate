import 'package:flutter/material.dart';
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
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCachedRepositories() async {
    _repositories = await _databaseService.getRepositories();
    notifyListeners();
  }
}
