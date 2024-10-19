import 'package:flutter/material.dart';
import '../../api/book_api.dart';
import '../models/book_model.dart';
import '../screen/book_detail.dart';
import '../screen/book_create.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  Future<List<Book>>? futureBooks;

  void initState() {
    super.initState();
    _fetchBooks(); // Fetch the book list when the page initializes
  }

  // Method to fetch books
  Future<void> _fetchBooks() async {
    futureBooks = BookApi().fetchBooks(); // Fetch the books
    setState(() {}); // Trigger a rebuild
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
              // Navigate to the BookCreatePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookCreatePage()),
              ).then((value) {
                // Optionally, refresh the book list here after returning
                if (value == true) {
                  _fetchBooks();
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: futureBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No albums found.'));
          } else {
            final books = snapshot.data!;
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
                        builder: (context) => BookDetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
        
      ),
    );
  }
}
