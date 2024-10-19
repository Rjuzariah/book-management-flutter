class BookCreate {
  final String title;
  final String? author;
  final int? publishedYear;
  final String? genre;
  final String? description;

  BookCreate({
    required this.title,
    this.author,
    this.publishedYear,
    this.genre,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'publishedYear': publishedYear,
      'genre': genre,
      'description': description,
    };
  }
}
