import '../models/book_model.dart';

class PaginatedBooks {
  final List<Book> books;
  final int totalItems;
  final int totalPages;
  final int currentPage;

  PaginatedBooks({
    required this.books,
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
  });

  factory PaginatedBooks.fromJson(Map<String, dynamic> json) {
    return PaginatedBooks(
      books: (json['books'] as List).map((i) => Book.fromJson(i)).toList(),
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }
}
