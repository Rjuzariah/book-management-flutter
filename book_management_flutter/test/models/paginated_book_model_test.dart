import 'package:flutter_test/flutter_test.dart';
import 'package:book_management_flutter/models/book_model.dart';
import 'package:book_management_flutter/models/paginated_book_model.dart';

void main() {
  group('PaginatedBooks Model', () {
    // Sample data for testing
    final List<Book> sampleBooks = [
      Book(
        id: 1,
        title: 'Book One',
        author: 'Author One',
        publishedYear: 2021,
        genre: 'Fiction',
        description: 'Description of Book One',
        createdAt: DateTime.parse('2021-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2021-02-01T00:00:00Z'),
      ),
      Book(
        id: 2,
        title: 'Book Two',
        author: 'Author Two',
        publishedYear: 2022,
        genre: 'Non-Fiction',
        description: 'Description of Book Two',
        createdAt: DateTime.parse('2022-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2022-02-01T00:00:00Z'),
      ),
    ];

    final PaginatedBooks paginatedBooks = PaginatedBooks(
      books: sampleBooks,
      totalItems: 2,
      totalPages: 1,
      currentPage: 1,
    );

    test('PaginatedBooks should have correct properties', () {
      expect(paginatedBooks.books.length, 2);
      expect(paginatedBooks.totalItems, 2);
      expect(paginatedBooks.totalPages, 1);
      expect(paginatedBooks.currentPage, 1);
    });

    test('PaginatedBooks.fromJson should create a valid PaginatedBooks object', () {
      final json = {
        'books': [
          {
            'id': 1,
            'title': 'Book One',
            'author': 'Author One',
            'publishedYear': 2021,
            'genre': 'Fiction',
            'description': 'Description of Book One',
            'createdAt': '2021-01-01T00:00:00Z',
            'updatedAt': '2021-02-01T00:00:00Z',
          },
          {
            'id': 2,
            'title': 'Book Two',
            'author': 'Author Two',
            'publishedYear': 2022,
            'genre': 'Non-Fiction',
            'description': 'Description of Book Two',
            'createdAt': '2022-01-01T00:00:00Z',
            'updatedAt': '2022-02-01T00:00:00Z',
          },
        ],
        'totalItems': 2,
        'totalPages': 1,
        'currentPage': 1,
      };

      final paginatedBooksFromJson = PaginatedBooks.fromJson(json);

      expect(paginatedBooksFromJson.books.length, paginatedBooks.books.length);
      expect(paginatedBooksFromJson.totalItems, paginatedBooks.totalItems);
      expect(paginatedBooksFromJson.totalPages, paginatedBooks.totalPages);
      expect(paginatedBooksFromJson.currentPage, paginatedBooks.currentPage);

      // Check the content of the first book
      final firstBook = paginatedBooksFromJson.books[0];
      expect(firstBook.id, 1);
      expect(firstBook.title, 'Book One');
      expect(firstBook.author, 'Author One');
    });

    test('PaginatedBooks should handle empty book list', () {
      final emptyPaginatedBooks = PaginatedBooks(
        books: [],
        totalItems: 0,
        totalPages: 0,
        currentPage: 0,
      );

      expect(emptyPaginatedBooks.books.isEmpty, true);
      expect(emptyPaginatedBooks.totalItems, 0);
      expect(emptyPaginatedBooks.totalPages, 0);
      expect(emptyPaginatedBooks.currentPage, 0);
    });

    test('PaginatedBooks.fromJson should handle empty book list in JSON', () {
      final json = {
        'books': [],
        'totalItems': 0,
        'totalPages': 0,
        'currentPage': 0,
      };

      final emptyPaginatedBooksFromJson = PaginatedBooks.fromJson(json);

      expect(emptyPaginatedBooksFromJson.books.isEmpty, true);
      expect(emptyPaginatedBooksFromJson.totalItems, 0);
      expect(emptyPaginatedBooksFromJson.totalPages, 0);
      expect(emptyPaginatedBooksFromJson.currentPage, 0);
    });
  });
}
