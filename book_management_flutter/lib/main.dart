import 'package:flutter/material.dart';
import './screen/book_list.dart';

void main() {
  runApp(MaterialApp(
    title: 'Book Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    home: BookListPage(),
  ));
}
