import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repository_model.dart';

class ApiService {
  // Base URL for the GitHub API.
  final String baseUrl = 'https://api.github.com';
  // Number of repositories per page for pagination.
  final int perPage = 10;

  // Fetches a list of repositories from the GitHub API for the specified page.
  Future<List<Repository>> fetchRepositories(int page) async {
    // Constructs the API request URL with pagination parameters.
    final response = await http.get(Uri.parse(
        '$baseUrl/search/repositories?q=created:>2022-04-29&sort=stars&order=desc&page=$page&per_page=$perPage'));

    // Checks if the request was successful (HTTP status code 200).
    if (response.statusCode == 200) {
      // Parses the JSON response body.
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      // Converts the JSON data to a list of Repository objects.
      return items.map((json) => Repository.fromJson(json)).toList();
    } else {
      // Throws an exception if the request failed.
      throw Exception('Failed to load repositories');
    }
  }
}
