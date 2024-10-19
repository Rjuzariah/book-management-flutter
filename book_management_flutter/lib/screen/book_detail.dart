import 'package:book_management_flutter/models/book_create_model.dart';
import 'package:flutter/material.dart';
import '../screen/book_edit.dart';
import '../api/book_api.dart'; // Import your Book API for fetching data

class BookDetailPage extends StatefulWidget {
  final int bookId; // Book ID for fetching details

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late Future<BookCreate> futureBook; // To store the future book data

  @override
  void initState() {
    super.initState();
    fetchBookDetails(); // Fetch book details when the page initializes
  }

  // Method to fetch book details
  void fetchBookDetails() {
    futureBook = BookApi().getBook(widget.bookId); // Call your API to get book
    setState(() {}); // Notify the framework that the state has changed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookEditPage(bookId: widget.bookId),
                ),
              ).then((value) {
                // Refresh the book details when returning from the edit page
                if (value == true) {
                  fetchBookDetails();
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<BookCreate>(
        future: futureBook,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No book found.'));
          } else {
            final book = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${book.title}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Author: ${book.author ?? 'Unknown'}'),
                  SizedBox(height: 10),
                  Text('Published Year: ${book.publishedYear ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text('Genre: ${book.genre ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text('Description: ${book.description ?? 'No description'}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
