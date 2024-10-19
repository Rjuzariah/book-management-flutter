import 'dart:convert';
import 'package:book_management_flutter/models/book_create_model.dart';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BookApi {
  final String baseUrl = 'http://127.0.0.1:3000';

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/api/books'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Book.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<bool> createBook(BookCreate book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/books'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
          'title': book.title,
          'author': book.author,
          'publishedYear': book.publishedYear,
          'genre': book.genre,
          'description': book.description,
        }),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create book');
    }
  }

  // Similar methods for update and delete...
}
