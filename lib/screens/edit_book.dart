import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditBookScreen extends StatefulWidget {
  final int bookId;

  const EditBookScreen({super.key, required this.bookId, required book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final titleController = TextEditingController();
  final pagesController = TextEditingController();
  final languageController = TextEditingController();
  final authorController = TextEditingController();
  final codeController = TextEditingController();
  final departmentController = TextEditingController();
  final availabilityController = TextEditingController();

  String? bookImageBase64;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookDetails();
  }

  Future<void> fetchBookDetails() async {
    try {
      final response = await Dio().get(
        'https://fci-library.me/api/book/${widget.bookId}',
      );
      if (response.statusCode == 200) {
        final book = response.data;
        setState(() {
          titleController.text = book['name'] ?? '';
          pagesController.text = book['pages']?.toString() ?? '';
          languageController.text = book['language'] ?? '';
          authorController.text =
              (book['authorNames'] as List<dynamic>?)?.join(', ') ?? '';
          codeController.text = book['code'] ?? '';
          departmentController.text = book['department'] ?? '';
          availabilityController.text =
              book['isAvailable'] == true ? 'Available' : 'Not Available';
          bookImageBase64 = book['image'];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        bookImageBase64 = base64Encode(bytes);
      });
    }
  }

  Uint8List? getImageFromBase64(String? base64Str) {
    if (base64Str == null || base64Str.isEmpty) return null;
    try {
      return base64Decode(base64Str);
    } catch (e) {
      print('Error decoding image: $e');
      return null;
    }
  }

  Future<void> updateBook() async {
    try {
      final response = await Dio().put(
        'https://fci-library.me/api/Book/update/${widget.bookId}',
        data: {
          "name": titleController.text.trim(),
          "pages": int.tryParse(pagesController.text.trim()) ?? 0,
          "language": languageController.text.trim(),
          "authorNames":
              authorController.text.split(',').map((e) => e.trim()).toList(),
          "code": codeController.text.trim(),
          "department": departmentController.text.trim(),
          "isAvailable":
              availabilityController.text.toLowerCase().contains("available"),
          "image": bookImageBase64 ?? "",
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book updated successfully!')),
        );
        Navigator.pop(context, true);
      } else {
        throw Exception('Failed to update');
      }
    } catch (e) {
      print('Error updating book: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating book: $e')),
      );
    }
  }

  Widget buildEditableField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE0C496),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9E5C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.brown),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Edit Book', style: TextStyle(color: Colors.brown)),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 180,
                            width: 120,
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            child: bookImageBase64 != null &&
                                    bookImageBase64!.isNotEmpty
                                ? Image.memory(
                                    getImageFromBase64(bookImageBase64!)!,
                                    fit: BoxFit.cover)
                                : Image.asset('assets/images/book1.jpeg',
                                    fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: const Text('Upload Photo',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildEditableField("Title", titleController),
                  buildEditableField("Pages", pagesController,
                      type: TextInputType.number),
                  buildEditableField("Language", languageController),
                  buildEditableField("Author", authorController),
                  buildEditableField("Code", codeController),
                  buildEditableField("Department", departmentController),
                  buildEditableField("Availability", availabilityController),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: updateBook,
                    icon: const Icon(Icons.check),
                    label: const Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
