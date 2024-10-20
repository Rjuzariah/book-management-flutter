import 'package:flutter_test/flutter_test.dart';
import 'package:book_management_flutter/models/book_create_edit_model.dart';

void main() {
  group('BookCreateEdit Model', () {
    // Sample data for testing
    final BookCreateEdit bookCreateEdit = BookCreateEdit(
      title: 'Flutter for Beginners',
      author: 'Jane Doe',
      publishedYear: 2024,
      genre: 'Programming',
      description: 'A comprehensive guide to Flutter.',
    );

    test('BookCreateEdit should have correct properties', () {
      expect(bookCreateEdit.title, 'Flutter for Beginners');
      expect(bookCreateEdit.author, 'Jane Doe');
      expect(bookCreateEdit.publishedYear, 2024);
      expect(bookCreateEdit.genre, 'Programming');
      expect(bookCreateEdit.description, 'A comprehensive guide to Flutter.');
    });

    test('BookCreateEdit.fromJson should create a valid BookCreateEdit object', () {
      final json = {
        'title': 'Flutter for Beginners',
        'author': 'Jane Doe',
        'publishedYear': 2024,
        'genre': 'Programming',
        'description': 'A comprehensive guide to Flutter.',
      };

      final bookCreateEditFromJson = BookCreateEdit.fromJson(json);

      expect(bookCreateEditFromJson.title, bookCreateEdit.title);
      expect(bookCreateEditFromJson.author, bookCreateEdit.author);
      expect(bookCreateEditFromJson.publishedYear, bookCreateEdit.publishedYear);
      expect(bookCreateEditFromJson.genre, bookCreateEdit.genre);
      expect(bookCreateEditFromJson.description, bookCreateEdit.description);
    });

    test('BookCreateEdit.toJson should produce a valid JSON map', () {
      final json = bookCreateEdit.toJson();

      expect(json['title'], bookCreateEdit.title);
      expect(json['author'], bookCreateEdit.author);
      expect(json['publishedYear'], bookCreateEdit.publishedYear);
      expect(json['genre'], bookCreateEdit.genre);
      expect(json['description'], bookCreateEdit.description);
    });

    test('BookCreateEdit should handle nullable fields correctly', () {
      final BookCreateEdit bookWithNullFields = BookCreateEdit(
        title: 'Flutter for Everyone',
      );

      expect(bookWithNullFields.author, null);
      expect(bookWithNullFields.publishedYear, null);
      expect(bookWithNullFields.genre, null);
      expect(bookWithNullFields.description, null);
    });
  });
}
