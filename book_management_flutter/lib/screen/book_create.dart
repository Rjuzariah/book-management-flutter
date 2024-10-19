import 'package:flutter/material.dart';
import '../models/book_create_model.dart'; // Your book model
import '../api/book_api.dart'; // Import your API handler

class BookCreatePage extends StatefulWidget {
  @override
  _BookCreatePageState createState() => _BookCreatePageState();
}

class _BookCreatePageState extends State<BookCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publishedYearController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _submitCreate() async {
    // Create a new book object
    BookCreate newBook = BookCreate(
      title: _titleController.text,
      author: _authorController.text.isEmpty ? null : _authorController.text,
      publishedYear: int.tryParse(_publishedYearController.text),
      genre: _genreController.text.isEmpty ? null : _genreController.text,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
    );

    // Call the API to create the book
    // bool success = true;
    final success = await BookApi().createBook(newBook);
    print(success);
    if (success) {
      // Go back to the previous screen with success message
      Navigator.pop(context, true);
    } else {
      // Handle failure (show a message or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create book.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              onPressed: _submitCreate,
              child: Text('Create Book'),
            ),
          ],
        ),
      ),
    );
  }
}
