import 'package:flutter/material.dart';
import './screen/book_list.dart';

void main() {
  runApp(MaterialApp(
    home: BookListPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue, // Use primarySwatch to define a range of colors
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue, // Set AppBar color globally
        titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  ));
}
