import 'package:book_management_flutter/models/book_create_model.dart';
import 'package:flutter/material.dart';
import '../api/book_api.dart'; // Adjust the import as needed

class BookEditPage extends StatefulWidget {
  final int bookId;

  BookEditPage({required this.bookId});

  @override
  _BookEditPageState createState() => _BookEditPageState();
}

class _BookEditPageState extends State<BookEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _publishedYearController;
  late TextEditingController _genreController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _publishedYearController = TextEditingController();
    _genreController = TextEditingController();
    _descriptionController = TextEditingController();
    _fetchBookData();
  }

  void _fetchBookData() async {
    // Fetch book data using the API
    BookCreate book = await BookApi().getBook(widget.bookId);
    _titleController = TextEditingController(text: book.title);
    _authorController = TextEditingController(text: book.author ?? '');
    _publishedYearController = TextEditingController(text: book.publishedYear?.toString() ?? '');
    _genreController = TextEditingController(text: book.genre ?? '');
    _descriptionController = TextEditingController(text: book.description ?? '');
    setState(() {});
  }

  Future<void> _updateBook() async {
    final updatedBook = BookCreate(
      title: _titleController.text,
      author: _authorController.text,
      publishedYear: int.tryParse(_publishedYearController.text),
      genre: _genreController.text,
      description: _descriptionController.text,
    );

    final success = await BookApi().updateBook(widget.bookId, updatedBook);
    if (success) {
      // Navigate back to the list page
      Navigator.pop(context, true); // Return true to indicate success
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update book.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _publishedYearController,
              decoration: InputDecoration(labelText: 'Published Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateBook,
              child: Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
