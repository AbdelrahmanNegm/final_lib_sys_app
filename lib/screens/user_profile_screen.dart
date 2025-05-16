import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/screens/edit_profile_screen.dart';
import 'package:library_app/screens/settings_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  String name = "Loading...";
  String email = "";
  List<dynamic> favoriteBooks = [];
  List<dynamic> borrowedBooks = [];
  bool isLoadingFavorites = true;
  bool isLoadingBorrowed = true;
  final int userId = 1; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    getProfile();
    getFavoriteBooks();
    getBorrowedBooks();
  }

  Future<void> getProfile() async {
    final url =
        Uri.parse('https://fci-library.me/api/user/profile/searchid/$userId');
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          name = data['name'];
          email = data['email'];
        });
      } else {
        debugPrint('Error: ${response.body}');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }

  Future<void> getFavoriteBooks() async {
    final url = Uri.parse('https://fci-library.me/api/favorite/$userId');
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          favoriteBooks = data;
          isLoadingFavorites = false;
        });
      } else {
        debugPrint('Error fetching favorites: ${response.body}');
      }
    } catch (e) {
      debugPrint('Exception fetching favorites: $e');
      setState(() => isLoadingFavorites = false);
    }
  }

  Future<void> getBorrowedBooks() async {
    final url = Uri.parse('https://fci-library.me/api/Borrow/history/$userId');
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          borrowedBooks = data;
          isLoadingBorrowed = false;
        });
      } else {
        debugPrint('Error fetching borrowed books: ${response.body}');
      }
    } catch (e) {
      debugPrint('Exception fetching borrowed books: $e');
      setState(() => isLoadingBorrowed = false);
    }
  }

  Uint8List? getImageFromBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      while (base64String!.length % 4 != 0) {
        base64String += '=';
      }
      return base64Decode(base64String);
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBEECB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SettingsScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.brown),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 1),
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.brown.shade300,
              child: const Icon(Icons.person_off_rounded, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text(email,
                style: const TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE0C496),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.manage_accounts),
              label: const Text("Edit Profile"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserProfileEdit()));
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFF2DEB3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      isLoadingFavorites
                          ? const Center(child: CircularProgressIndicator())
                          : _buildSection("Your Saved Books", favoriteBooks),
                      const SizedBox(height: 15),
                      isLoadingBorrowed
                          ? const Center(child: CircularProgressIndicator())
                          : _buildSection("What You Borrow", borrowedBooks),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<dynamic> books) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFFBEECB),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 150,
                    child: books.isEmpty
                        ? const Center(child: Text("No books available"))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              final imageData = book is String
                                  ? null
                                  : getImageFromBase64(book['image']);
                              final bookName = book is String
                                  ? "Book ${index + 1}"
                                  : book['name'] ?? "Unnamed Book";

                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.brown.shade200,
                                      image: imageData != null
                                          ? DecorationImage(
                                              image: MemoryImage(imageData),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        bookName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              offset: Offset(1, 1),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
