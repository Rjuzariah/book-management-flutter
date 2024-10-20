class BookCreateEdit {
  final String title;
  final String? author;
  final int? publishedYear;
  final String? genre;
  final String? description;

  BookCreateEdit({
    required this.title,
    this.author,
    this.publishedYear,
    this.genre,
    this.description,
  });

  // Factory method to create a BookCreateEdit object from a JSON map
  factory BookCreateEdit.fromJson(Map<String, dynamic> json) {
    return BookCreateEdit(
      title: json['title'],
      author: json['author'],
      publishedYear: json['publishedYear'],
      genre: json['genre'],
      description: json['description'],
    );
  }

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
