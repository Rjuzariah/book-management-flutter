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
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreBooks = true;
  List<Book> loadedBooks = []; 

  @override
  void initState() {
    super.initState();
    _fetchBooks(); // Fetch the book list when the page initializes
  }

  // Method to fetch books
  Future<void> _fetchBooks() async {
    if (isLoading || !hasMoreBooks) return; // Exit if loading or no more books

    setState(() {
      isLoading = true; // Set loading state to true
    });

    try {
      PaginatedBooks paginatedBooks = await BookApi().fetchBooks(currentPage);
      loadedBooks.addAll(paginatedBooks.books); // Add new books to the list
      currentPage++;
      hasMoreBooks = paginatedBooks.currentPage < paginatedBooks.totalPages; // Check if more books are available
      
      setState(() {}); // Trigger a rebuild to update the UI
    } catch (error) {
      print("Error fetching books: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching books: $error')),
      );
    } finally {
      setState(() {
        isLoading = false; // Reset loading state
      });
    }
  }

  void _refreshBooks() {
    setState(() {
      loadedBooks.clear(); // Clear the existing books
      currentPage = 1; // Reset to first page
      hasMoreBooks = true; // Reset the flag
    });
    _fetchBooks(); // Fetch new books
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: loadedBooks.length,
              itemBuilder: (context, index) {
                final book = loadedBooks[index];
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
            ),
          ),
          // Load More button
          if (hasMoreBooks) // Check if there are more books to load
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: isLoading ? null : _fetchBooks, // Disable button while loading
                child: isLoading
                    ? CircularProgressIndicator() // Show loader while fetching
                    : Text('Load More'),
              ),
            ),
        ],
      ),
    );
  }
}
