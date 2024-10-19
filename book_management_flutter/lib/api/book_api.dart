import 'dart:convert';
import 'package:book_management_flutter/models/book_create_model.dart';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class BookApi {
  final String baseUrl = 'http://127.0.0.1:3000/api';
  final Map<String, String> contentHeaders = {'Content-Type': 'application/json; charset=UTF-8'};

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Book.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<bool> createBook(BookCreate book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books'),
      headers: contentHeaders,
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

  Future<BookCreate> getBook(int id) async {

    final response = await http.get(
      Uri.parse('$baseUrl/books/$id'), 
      headers: contentHeaders,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BookCreate.fromJson(jsonResponse); // Assuming your BookCreate model has a fromJson constructor
    } else {
      throw Exception('Failed to load book');
    } 
  }

  Future<bool> deleteBook(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/books/$id'), 
      headers: contentHeaders,
    );

    return response.statusCode == 204;
  }

  Future<bool> updateBook(int id, BookCreate book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/books/${id}'),
      headers: contentHeaders,
      body: json.encode({
        'title': book.title,
        'author': book.author,
        'publishedYear': book.publishedYear,
        'genre': book.genre,
        'description': book.description,
      }),
    );

    return response.statusCode == 200;
  }
}
