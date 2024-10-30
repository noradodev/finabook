import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/books_model.dart';

class BookService {
  final String _baseUrl = 'https://gutendex.com/books';

  Future<List<Result>> fetchBooks() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['results'];
      return data.map((book) => Result.fromJson(book)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
