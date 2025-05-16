import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../constants.dart';
import '../models/book_model.dart';

class Advanced extends StatefulWidget {
  const Advanced({super.key});

  @override
  State<Advanced> createState() => _AdvancedState();
}

class _AdvancedState extends State<Advanced> {
  TextEditingController searchController = TextEditingController();
  List<BookModel> booksList = [];
  bool isLoading = true;
  File? selectedImage;

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
                    author: book['authorNames']?.join(", ") ?? 'Unknown',
                    pages: book['pages'] ?? 0,
                    language: book['language'] ?? 'Unknown',
                    department: book['department'] ?? 'Unknown',
                    imageBase64: '',
                    // imageUrl: book['imageUrl'] != null &&
                    //         Uri.tryParse(book['imageUrl'])?.hasAbsolutePath ==
                    //             true
                    //     ? book['imageUrl']
                    //     : '',
                    // imageBase64: '',
                  ))
              .toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  Future<void> uploadBookImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });

      try {
        String fileName = pickedFile.path.split('/').last;
        FormData formData = FormData.fromMap({
          "file":
              await MultipartFile.fromFile(pickedFile.path, filename: fileName),
        });

        var response = await Dio()
            .post("https://fci-library.me/api/upload", data: formData);
        if (response.statusCode == 200) {
          print("Image uploaded successfully: ${response.data}");
        }
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
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
                        hintText: "Titles , Authors or Topics",
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
                IconButton(
                    onPressed: uploadBookImage,
                    icon: const Icon(Icons.camera_alt,
                        size: 30, color: Color(0xffd8a152))),
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
                          : ListView.builder(
                              itemCount: booksList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xffefddb2)),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: booksList[index].imageUrl,
                                        width: screenWidth * 0.2,
                                        height: screenHeight * 0.15,
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            Image.network(
                                          'https://th.bing.com/th/id/OIP.r124G7oq3l5JzhPG8TZaIgHaHa?rs=1&pid=ImgDetMain',
                                          width: screenWidth * 0.2,
                                          height: screenHeight * 0.15,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
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
}
