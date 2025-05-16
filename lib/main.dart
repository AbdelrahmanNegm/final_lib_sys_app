import 'package:flutter/material.dart';
import 'package:library_app/screens/about_us_screen.dart';
import 'package:library_app/screens/book_request_integration.dart';
import 'package:library_app/screens/book_request_screen.dart';
import 'package:library_app/screens/edit_book.dart';
import 'package:library_app/screens/edit_books_main_screen.dart';
import 'package:library_app/screens/resetpass1.dart';
import 'package:library_app/screens/resetpass2.dart';

//

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppConstants.fontFamily,
        useMaterial3: true,
      ),
      home: ResetPassword2(
          //bookId: 1, book: null,
          // bookId:2,

          // bookId: 3,
          // bookId1 13,
          ),

      // bookId: 7,
    );
  }
}
