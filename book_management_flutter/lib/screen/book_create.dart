import 'package:flutter/material.dart';
import '../models/book_create_edit_model.dart';
import '../api/book_api.dart';

class BookCreateEditPage extends StatefulWidget {
  @override
  _BookCreateEditPageState createState() => _BookCreateEditPageState();
}

class _BookCreateEditPageState extends State<BookCreateEditPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _publishedYearController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _submitCreate() async {
    // Create a new book object
    BookCreateEdit newBook = BookCreateEdit(
      title: _titleController.text,
      author: _authorController.text.isEmpty ? null : _authorController.text,
      publishedYear: int.tryParse(_publishedYearController.text),
      genre: _genreController.text.isEmpty ? null : _genreController.text,
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
    );

    // Call the API to create the book
    final success = await BookApi().createBook(newBook);
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
        child: Form(
          key: _formKey, // Assign the key to the form
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required'; // Validation rule for the title
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              TextFormField(
                controller: _publishedYearController,
                decoration: InputDecoration(labelText: 'Published Year'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(labelText: 'Genre'),
              ),
              TextFormField(
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
      )
    );
  }
}
