import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repository_model.dart';

class ApiService {
  final String baseUrl = 'https://api.github.com';

  Future<List<Repository>> fetchRepositories(int page) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/search/repositories?q=created:>2022-04-29&sort=stars&order=desc&page=$page&per_page=10'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((json) => Repository.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
