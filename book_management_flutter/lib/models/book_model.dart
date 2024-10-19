class Book {
  final int id;
  final String title;
  final String? author; // Nullable field
  final int? publishedYear; // Nullable field
  final String? genre; // Nullable field
  final String? description; // Nullable field
  final DateTime createdAt; // DateTime field
  final DateTime updatedAt; // DateTime field

  Book({
    required this.id,
    required this.title,
    this.author,
    this.publishedYear,
    this.genre,
    this.description,
    required this.createdAt,
    required this.updatedAt});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'], // Nullable field
      publishedYear: json['publishedYear'], // Nullable field
      genre: json['genre'], // Nullable field
      description: json['description'], // Nullable field
      createdAt: DateTime.parse(json['createdAt']), // Convert to DateTime
      updatedAt: DateTime.parse(json['updatedAt']), // Convert to DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publishedYear': publishedYear,
      'genre': genre,
      'description': description,
      'createdAt': createdAt.toIso8601String(), // Convert to ISO 8601 String
      'updatedAt': updatedAt.toIso8601String(), // Convert to ISO 8601 String
    };
  }
}