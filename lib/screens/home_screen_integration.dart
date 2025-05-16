import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:library_app/models/author_model.dart';
import 'package:library_app/screens/book_details_integration.dart';
import 'package:library_app/screens/book_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenInt extends StatefulWidget {
  const HomeScreenInt({super.key});

  @override
  State<HomeScreenInt> createState() => _HomeScreenIntState();
}

class _HomeScreenIntState extends State<HomeScreenInt> {
  List<Book> books = [];
  bool isLoading = true;
  // نص البحث
  final TextEditingController _searchController = TextEditingController();

// نتائج البحث
  List<Book> _searchResults = [];

// للتحكم بظهور اللائحة
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchAllBooks();
  }

  Future<void> fetchAllBooks() async {
    const url = 'https://fci-library.me/api/book';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          books = data.map((bookJson) => Book.fromJson(bookJson)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<Author>> fetchAuthors() async {
    final response =
        await http.get(Uri.parse('https://fci-library.me/api/authors'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Author.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }

  Future<void> _searchBooksByName(String name) async {
    setState(() => _isSearching = true);

    final uri = Uri.parse('https://fci-library.me/api/book/search')
        .replace(queryParameters: {'name': name});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _searchResults = data.map((j) => Book.fromJson(j)).toList();
      });
    } else {
      // في حالة خطأ، نمسح النتائج أو نظهر رسالة
      setState(() => _searchResults = []);
    }

    setState(() => _isSearching = false);
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final results = books
        .where((book) => book.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double logoHeight = screenWidth * 0.25;
    final double logoWidth = screenWidth * 0.42;
    // المسافة من اليسار لتوسيط اللوجو
    final double leftOffset = (screenWidth - logoWidth) / 2;
    // ارتفاع اللوجو
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: const Color(0xFFD8A353)),
        backgroundColor: const Color(0xFFFFF8E0),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFFD8A353)),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            color: const Color(0xFFFFF8E0),
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.12),
              child: Stack(
                clipBehavior:
                    Clip.none, // للسماح للوجو بالخروج من حدود الـ Container
                children: [
                  // 1. صندوق المحتوى — الخلفية
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color(0xFFFBEECB),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(),
                        const SizedBox(height: 20),
                        _buildSearchResults(screenWidth),
                        _buildCategorySection(),
                        const SizedBox(height: 20),
                        const Text(
                          "Picks For You",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF332417),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2DEB3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                _buildBookBox("General Box", screenWidth),
                                const SizedBox(height: 20),
                                _buildBookBox("Favourite Box", screenWidth),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Authors",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF2DEB3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildAuthorsRow(screenWidth),
                            )),
                      ],
                    ),
                  ),

                  // 2. اللوجو المطابق للـ Container — متراكب بدون مسافة
                  Positioned(
                    top: -logoHeight / 1.3,
                    left: leftOffset,
                    child: SizedBox(
                      width: screenWidth * 0.42,
                      height: logoHeight, // عرف قيمة logoHeight مسبقًا
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE0C496),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (text) {
            _onSearchChanged(text);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Titles, Authors or Topics',
            icon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                final text = _searchController.text.trim();
                if (text.isNotEmpty) {
                  _searchBooksByName(text);
                }
              },
            ),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (text) {
            if (text.trim().isNotEmpty) {
              _searchBooksByName(text.trim());
            }
          },
        ));
  }

  Widget _buildSearchResults(double screenWidth) {
    if (_searchResults.isEmpty) {
      return const SizedBox(); // أو رسالة "لا توجد نتائج"
    } else {
      return SizedBox(
        height: screenWidth * 0.45,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final book = _searchResults[index];
            final imageBytes = _decodeBase64Image(book.image);
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailsIntegration(
                        book: book,
                        bookId: book.id,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: imageBytes != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:
                                  Image.memory(imageBytes, fit: BoxFit.cover),
                            )
                          : const Icon(Icons.image_not_supported, size: 80),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: screenWidth * 0.25,
                      child: Text(
                        book.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: [
              "Data analysis",
              "Programming fundamentals",
              "Operating system",
              "Machine learning",
              "Network",
              "Logical thinking",
              "Big Data",
              "Math",
              "Cyber security",
              "Algorithms",
            ]
                .map((category) => Chip(
                      label: Text(category,
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xFF553C28))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      backgroundColor: const Color(0xFFEED9AB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }

  Widget _buildBookBox(String title, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF553C28))),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: screenWidth * 0.45,
          child: books.isEmpty
              ? const Center(child: Text("No books found"))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    final imageBytes = _decodeBase64Image(book.image);
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailsIntegration(
                                book: book,
                                bookId: book.id,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.33,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: imageBytes != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.memory(
                                        imageBytes,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.image_not_supported,
                                      size: 80,
                                      color: Colors.grey,
                                    ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: Text(
                                book.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }

  // Widget _buildAuthorsRow() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       _buildAuthorAvatar("assets/author1.png", "Martin Fowler"),
  //       _buildAuthorAvatar("assets/author2.png", "Scott Meyers"),
  //       _buildAuthorAvatar("assets/author3.png", "Bjarne Stroustrup"),
  //       _buildAuthorAvatar("assets/author4.png", "Bruce Eckel"),
  //     ],
  //   );
  // }

  // Widget _buildAuthorAvatar(String imagePath, String name) {
  //   return Column(
  //     children: [
  //       CircleAvatar(
  //         radius: 30,
  //         backgroundImage: AssetImage(imagePath),
  //       ),
  //       const SizedBox(height: 5),
  //       Text(name, style: const TextStyle(fontSize: 12))
  //     ],
  //   );
  // }

  Widget _buildAuthorsRow(double screenWidth) {
    return FutureBuilder<List<Author>>(
      future: fetchAuthors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading authors'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No authors found'));
        } else {
          final authors = snapshot.data!;
          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: authors.length,
              itemBuilder: (context, index) {
                final author = authors[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(author.image),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        author.name,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Uint8List? _decodeBase64Image(String? base64String) {
    try {
      if (base64String == null || base64String.trim().isEmpty) return null;
      if (base64String.contains(',')) {
        base64String = base64String.split(',').last;
      }
      return base64Decode(base64String);
    } catch (_) {
      return null;
    }
  }
}
