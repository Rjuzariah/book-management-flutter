import 'package:flutter/material.dart';
import '../../api/book_api.dart';
import '../models/paginated_book_model.dart';
import '../models/book_model.dart';
import '../screen/book_detail.dart';
import '../screen/book_create.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late Future<PaginatedBooks> futureBooks;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    futureBooks = _fetchBooks(); // Fetch the book list when the page initializes
  }

  // Method to fetch books
  Future<PaginatedBooks> _fetchBooks() async {
    try {
      PaginatedBooks paginatedBooks = await BookApi().fetchBooks(currentPage);
      return paginatedBooks; // Return paginated books for FutureBuilder
    } catch (error) {
      print("Error fetching books: $error");
      rethrow; // rethrowing the error in case it's needed for further handling
    }
  }

  void _refreshBooks() {
    setState(() {
      futureBooks = _fetchBooks(); // Update the future for FutureBuilder
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the BookCreateEditPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookCreateEditPage()),
              ).then((value) {
                // Refresh the book list here after returning
                if (value == true) {
                  _refreshBooks();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Book created successfully!')),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<PaginatedBooks>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.books.isEmpty) {
            return Center(child: Text('No books found.'));
          } else {
            final books = snapshot.data!.books; // Access the books list
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  onTap: () {
                    // Navigate to the BookDetailPage and pass the selected book
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(bookId: book.id),
                      ),
                    ).then((value) {
                      _refreshBooks();
  
              });
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final success = await BookApi().deleteBook(book.id.toString());
                      if (success) {
                        _refreshBooks(); // Refresh the books list after deletion
                        // Show success message and refresh the list
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Book deleted successfully.')),
                        );
                        
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to delete book.')),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
