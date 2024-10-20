import 'package:flutter_test/flutter_test.dart';
import 'package:book_management_flutter/models/book_model.dart';

void main() {
  group('Book Model', () {
    // Sample data for testing
    final DateTime now = DateTime.now();
    final Book book = Book(
      id: 1,
      title: 'Flutter for Beginners',
      author: 'Jane Doe',
      publishedYear: 2024,
      genre: 'Programming',
      description: 'A comprehensive guide to Flutter.',
      createdAt: now,
      updatedAt: now,
    );

    test('Book should have correct properties', () {
      expect(book.id, 1);
      expect(book.title, 'Flutter for Beginners');
      expect(book.author, 'Jane Doe');
      expect(book.publishedYear, 2024);
      expect(book.genre, 'Programming');
      expect(book.description, 'A comprehensive guide to Flutter.');
      expect(book.createdAt, now);
      expect(book.updatedAt, now);
    });

    test('Book.fromJson should create a valid Book object', () {
      final json = {
        'id': 1,
        'title': 'Flutter for Beginners',
        'author': 'Jane Doe',
        'publishedYear': 2024,
        'genre': 'Programming',
        'description': 'A comprehensive guide to Flutter.',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };

      final bookFromJson = Book.fromJson(json);

      expect(bookFromJson.id, book.id);
      expect(bookFromJson.title, book.title);
      expect(bookFromJson.author, book.author);
      expect(bookFromJson.publishedYear, book.publishedYear);
      expect(bookFromJson.genre, book.genre);
      expect(bookFromJson.description, book.description);
      expect(bookFromJson.createdAt, book.createdAt);
      expect(bookFromJson.updatedAt, book.updatedAt);
    });

    test('Book.toJson should produce a valid JSON map', () {
      final json = book.toJson();

      expect(json['id'], book.id);
      expect(json['title'], book.title);
      expect(json['author'], book.author);
      expect(json['publishedYear'], book.publishedYear);
      expect(json['genre'], book.genre);
      expect(json['description'], book.description);
      expect(json['createdAt'], book.createdAt.toIso8601String());
      expect(json['updatedAt'], book.updatedAt.toIso8601String());
    });

    test('Book should handle nullable fields correctly', () {
      final Book bookWithNullFields = Book(
        id: 2,
        title: 'Flutter for Everyone',
        createdAt: now,
        updatedAt: now,
      );

      expect(bookWithNullFields.author, null);
      expect(bookWithNullFields.publishedYear, null);
      expect(bookWithNullFields.genre, null);
      expect(bookWithNullFields.description, null);
    });
  });
}
