import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/book_model.dart';

class LibraryBooksScreen extends StatefulWidget {
  const LibraryBooksScreen({super.key});

  @override
  State<LibraryBooksScreen> createState() => _LibraryBooksScreenState();
}

class _LibraryBooksScreenState extends State<LibraryBooksScreen> {
  TextEditingController searchController = TextEditingController();

  List<BookModel> booksList = [
    BookModel(
      title: "The Secret to Cybersecurity .by Scott E. Augenbaum",
      author: "Oliver Grillmeyer",
      pages: 197,
      language: "English",
      department: "General",
      imageBase64: '',
    ),
    BookModel(
      title: "Principles of Digital Signal Processing .by S.Palani",
      author: "F. Scott Fitzgerald",
      pages: 328,
      language: "English",
      department: "IT",
      imageBase64: '',
    ),
    BookModel(
      title: "Computer Networking .by RUSSEL SCOTT",
      author: "Harper Lee",
      pages: 281,
      language: "English",
      department: "CS",
      imageBase64: '',
    ),
    BookModel(
      title: "The Clean Coder .by Robert C. Martin",
      author: "Robert C. Martin",
      pages: 279,
      language: "English",
      department: "IS",
      imageBase64: '',
    ),
    BookModel(
      title: "Grokking Algorithms Second Edition . by Aditya Bhargava",
      author: "F. Scott Fitzgerald",
      pages: 180,
      language: "English",
      department: "General",
      imageBase64: '',
    ),
    BookModel(
      title: "Exploring Computer Science With Schema .by Oliver Grlillmeyer",
      author: "Oliver Grillmeyer",
      pages: 635,
      language: "English",
      department: "IT",
      imageBase64: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffcf6df),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppConstants.primaryColor,
                  )),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                // width: MediaQuery.of(context).size.width * 0.75,
                child: TextFormField(
                  controller: searchController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      // labelText: "Email",
                      hintText: "Titles , Authors or Topics",
                      filled: true,
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppConstants.primaryColor),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      fillColor: const Color(0xffdfc394),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppConstants.primaryColor,
                          ))),
                  keyboardType: TextInputType.text,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications,
                    size: 30,
                    color: Color(0xffd8a152),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 12 ,vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xfff9edca),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Filter By",
                                style: TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Icon(
                                Icons.filter_alt,
                                color: Color(0xffd8a152),
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: booksList.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xffefddb2)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  booksList[index].imagePath,
                                  width: 90,
                                  height: 130,
                                  fit: BoxFit.fill,
                                  // height: 100,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        booksList[index].title,
                                        style: const TextStyle(
                                            color: AppConstants.primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 1,
                                      width: 200,
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFB28F63),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF553C28),
                                                offset: Offset(2, 5),
                                                spreadRadius: 0.8,
                                                blurRadius: 3)
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Page : ${booksList[index].pages} ",
                                      style: const TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 14,
                                          height: 1.4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Author : ${booksList[index].author} ",
                                      style: const TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 14,
                                          height: 1.4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Language : ${booksList[index].language} ",
                                      style: const TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 14,
                                          height: 1.4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Department : ${booksList[index].department} ",
                                      style: const TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontSize: 14,
                                          height: 1.4,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
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
