import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../constants.dart';
import '../models/book_model.dart';

class LibraryBooksScreen1 extends StatefulWidget {
  const LibraryBooksScreen1({super.key});

  @override
  State<LibraryBooksScreen1> createState() => _LibraryBooksScreen1State();
}

class _LibraryBooksScreen1State extends State<LibraryBooksScreen1> {
  TextEditingController searchController = TextEditingController();
  List<BookModel> booksList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      var response =
          await Dio().get('https://fci-library.me/api/Book/?isAvailable=true');
      if (response.statusCode == 200) {
        setState(() {
          booksList = (response.data as List)
              .map((book) => BookModel(
                    title: book['name'] ?? 'Unknown',
                    author:
                        (book['authorNames'] as List?)?.join(", ") ?? 'Unknown',
                    pages: book['pages'] ?? 0,
                    language: book['language'] ?? 'Unknown',
                    department: book['department'] ?? 'Unknown',
                    imageBase64: book['image'] ?? '',
                  ))
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  Uint8List? getImageBytes(String base64String) {
    try {
      if (base64String.isNotEmpty && base64String != 'Unknown') {
        // Remove any unwanted characters that could be causing the error
        String cleanedBase64 = base64String.replaceAll(RegExp(r'\s+'), '');
        return base64Decode(cleanedBase64);
      }
    } catch (e) {
      print("Error decoding base64: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfffcf6df),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppConstants.primaryColor,
                    )),
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Titles, Authors, or Topics",
                        filled: true,
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppConstants.primaryColor),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                        fillColor: const Color(0xffdfc394),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: AppConstants.primaryColor))),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff9edca),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              itemCount: booksList.length,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xffefddb2)),
                                  child: Row(
                                    children: [
                                      _buildImage(booksList[index]),
                                      SizedBox(width: screenWidth * 0.04),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              booksList[index].title,
                                              style: TextStyle(
                                                  color:
                                                      AppConstants.primaryColor,
                                                  fontSize: screenWidth * 0.04,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Text(
                                                "department: ${booksList[index].department}",
                                                style: TextStyle(
                                                    color: AppConstants
                                                        .primaryColor,
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    height: 1.4,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                "Pages: ${booksList[index].pages}",
                                                style: TextStyle(
                                                    color: AppConstants
                                                        .primaryColor,
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    height: 1.4,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                "Author: ${booksList[index].author}",
                                                style: TextStyle(
                                                    color: AppConstants
                                                        .primaryColor,
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    height: 1.4,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: screenHeight * 0.02);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _buildImage(BookModel book) {
    Uint8List? imageBytes = getImageBytes(book.imageBase64);
    if (imageBytes != null && imageBytes.isNotEmpty) {
      return Image.memory(
        imageBytes,
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.15,
        fit: BoxFit.fill,
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
      );
    }
  }
}
