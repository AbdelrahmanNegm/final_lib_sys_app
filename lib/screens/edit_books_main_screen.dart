import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert'; // لتحويل Base64
import 'dart:typed_data';

// import 'package:library_app/screens/edit_book.dart'; // للعمل مع بيانات الذاكرة

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<dynamic> books = [];
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
          books = response.data;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching books: $e');
    }
  }

  Future<void> deleteBook(int bookId) async {
    try {
      var response = await Dio().delete(
        'https://fci-library.me/api/Book/delete/$bookId',
      );

      if (response.statusCode == 200) {
        // حذف الكتاب من القائمة
        setState(() {
          books.removeWhere((book) => book["id"] == bookId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Book deleted successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete book")),
        );
      }
    } catch (e) {
      print('Error deleting book: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting book: $e")),
      );
    }
  }

  Uint8List? getImageFromBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      return base64Decode(base64String);
    } catch (e) {
      print('Error decoding base64 image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8E0),
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.notifications_on),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFFF8E0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: const Color(0xFFE0C496),
                  filled: true,
                  hintText: "Search Titles, Authors, or Topics",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("filter with"),
                Icon(Icons.filter_alt_sharp),
              ],
            ),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Scrollbar(
                      thumbVisibility: true,
                      thickness: 6,
                      radius: const Radius.circular(10),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          var book = books[index];
                          String? imageBase64 = book["imageBase64"];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2DEB3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(book["name"] ?? "Unknown",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const Divider(color: Color(0xFF332417)),
                                      ],
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Pages: ${book["pages"]?.toString() ?? "N/A"}"),
                                        Text(
                                            "Author: ${book["authorNames"]?.join(", ") ?? "Unknown"}"),
                                        Text(
                                            "Language: ${book["language"] ?? "N/A"}"),
                                        Text(
                                            "Department: ${book["department"] ?? "N/A"}"),
                                        const Divider(color: Color(0xFF332417)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFB28F63),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            // استدعاء دالة الحذف هنا
                                            deleteBook(book["id"]);
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Color(0xFF332417)),
                                          label: const Text("Delete",
                                              style: TextStyle(
                                                  color: Color(0xFF332417))),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 45,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF332417),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFFB28F63),
                                                blurRadius: 0,
                                                offset: Offset(2, 0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            // الانتقال إلى شاشة التعديل مع تمرير الكتاب ID
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditBookScreen(
                                                        bookId: book["id"]),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.edit,
                                              color: Color(0xFF332417)),
                                          label: const Text("Edit",
                                              style: TextStyle(
                                                  color: Color(0xFF332417))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF9C7A6B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class EditBookScreen extends StatelessWidget {
  final int bookId;

  const EditBookScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Book"),
        backgroundColor: const Color(0xFFFFF8E0),
      ),
      body: Center(
        child: Text('Editing book with ID: $bookId'),
      ),
    );
  }
}
