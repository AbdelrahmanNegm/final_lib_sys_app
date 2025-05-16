import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/screens/book_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [
    'All',
    'Programming',
    'Novels',
    'History',
    'Science',
    'Religion',
  ];
  List<Book> allBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final response =
          await http.get(Uri.parse("https://fci-library.me/api/book"));
      if (response.statusCode == 200) {
        final List<dynamic> bookData = json.decode(response.body);
        setState(() {
          allBooks = bookData.map((json) => Book.fromJson(json)).toList();
        });
      } else {
        print("Failed to load books: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching books: $e");
    }
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
    );
  }

  Widget buildBookCard(Book book) {
    Uint8List? imageBytes;
    if (book.image != null) {
      imageBytes = base64Decode(book.image!);
    }
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: imageBytes != null
                ? Image.memory(
                    imageBytes,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.book)),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorAvatar(String imagePath, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontSize: 10, color: Colors.brown),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF3E7),
        elevation: 0,
        // title: Image.asset('assets/logo.png', height: 40),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.brown),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.brown),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1E3D3),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Titles , Authors or Topics',
                  icon: Icon(Icons.search, color: Colors.brown),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: categories
                  .map((category) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: Text(category),
                          backgroundColor: const Color(0xFFF1E3D3),
                          labelStyle: const TextStyle(color: Colors.brown),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          buildSectionTitle("Picks For You"),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: allBooks.map((book) => buildBookCard(book)).toList(),
            ),
          ),
          buildSectionTitle("Most Selling Books"),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children:
                  allBooks.reversed.map((book) => buildBookCard(book)).toList(),
            ),
          ),
          buildSectionTitle("Top Authors"),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildAuthorAvatar("assets/author1.png", "Martin Fowler"),
                _buildAuthorAvatar("assets/author2.png", "Scott Meyers"),
                _buildAuthorAvatar("assets/author3.png", "Bjarne Stroustrup"),
                _buildAuthorAvatar("assets/author4.png", "Bruce Eckel"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
