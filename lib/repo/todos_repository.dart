import 'dart:convert';

import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TodosRepository {
  final _client = http.Client();

  Future<List<Todo>> getTodos() async {
    final response =
        await _client.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
