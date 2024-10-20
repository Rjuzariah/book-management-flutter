import 'dart:convert';
import 'package:book_management_flutter/models/book_create_edit_model.dart';
import 'package:book_management_flutter/models/paginated_book_model.dart';
import 'package:http/http.dart' as http;

class BookApi {
  final String baseUrl = 'http://127.0.0.1:3000/api';
  final Map<String, String> headers = {
    'Authorization':'book-management-static-token', 
    'Content-Type': 'application/json; charset=UTF-8'};

  Future<PaginatedBooks> fetchBooks(int page) async {
    final response = await http.get(
    Uri.parse('$baseUrl/books?page=$page&limit=10'), // Adjust limit as needed
    headers: headers
  );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return PaginatedBooks.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<bool> createBook(BookCreateEdit book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/books'),
      headers: headers,
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
      return false;
    }
  }

  Future<BookCreateEdit> getBook(int id) async {

    final response = await http.get(
      Uri.parse('$baseUrl/books/$id'), 
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return BookCreateEdit.fromJson(jsonResponse); // Assuming your BookCreateEdit model has a fromJson constructor
    } else {
      throw Exception('Failed to load book');
    } 
  }

  Future<bool> deleteBook(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/books/$id'), 
      headers: headers,
    );

    return response.statusCode == 204;
  }

  Future<bool> updateBook(int id, BookCreateEdit book) async {
    final response = await http.put(
      Uri.parse('$baseUrl/books/${id}'),
      headers: headers,
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
