// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import '../models/repository_model.dart';
import '../services/api_service.dart';
import '../services/db_service.dart';

/// Provides and manages the state of GitHub repositories.
class RepositoryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseService _databaseService = DatabaseService();
  List<Repository> _repositories = [];
  bool _isLoading = false;

  /// Getter for the list of repositories.
  List<Repository> get repositories => _repositories;

  /// Getter for the loading state.
  bool get isLoading => _isLoading;

  /// Fetches repositories from the API and updates the state.
  /// 
  /// [page] is the page number to fetch.
  Future<void> fetchRepositories(int page) async {
    _isLoading = true;
    notifyListeners();

    try {
      List<Repository> fetchedRepositories =
          await _apiService.fetchRepositories(page);
      _repositories.addAll(fetchedRepositories);

      // Cache fetched repositories
      for (var repo in fetchedRepositories) {
        await _databaseService.insertRepository(repo);
      }
    } catch (e) {
      print("Error fetching repositories: $e");
      // Implement proper error handling
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Loads cached repositories from the local database.
  Future<void> loadCachedRepositories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _repositories = await _databaseService.getRepositories();
      print("Loaded ${_repositories.length} repositories from cache");
    } catch (e) {
      print("Error loading cached repositories: $e");
      // Implement proper error handling
    }

    _isLoading = false;
    notifyListeners();
  }
}