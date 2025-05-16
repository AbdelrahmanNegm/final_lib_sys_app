import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key, required int bookId});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController shelfController = TextEditingController();
  final TextEditingController assignedYearController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  File? _image;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String convertImageToBase64(File imageFile) {
    List<int> imageBytes = imageFile.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  Future<void> addBook() async {
    try {
      String? base64Image = _image != null ? convertImageToBase64(_image!) : "";

      var data = jsonEncode({
        "name": titleController.text,
        "description": descriptionController.text,
        "shelf": shelfController.text,
        "assignedYear": int.tryParse(assignedYearController.text) ?? 0,
        "isAvailable": availabilityController.text == 'Available',
        "department": departmentController.text,
        "authorNames": authorController.text.split(', '),
        "categoryNames": categoryController.text.split(', '),
        "image": base64Image,
      });

      var response = await http.post(
        Uri.parse('https://fci-library.me/api/Book/add'),
        headers: {"Content-Type": "application/json"},
        body: data,
      );

      if (response.statusCode == 201) {
        print("Book Added Successfully");
        Navigator.pop(context, true);
      } else {
        print("Error adding book: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error adding book: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9E5C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Book', style: TextStyle(color: Colors.brown)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: _image == null
                    ? const Icon(Icons.add_a_photo,
                        size: 50, color: Colors.brown)
                    : Image.file(_image!, height: 100),
              ),
              const SizedBox(height: 10),
              buildEditableField("Title", titleController),
              buildEditableField("Description", descriptionController),
              buildEditableField("Shelf", shelfController),
              buildEditableField("Assigned Year", assignedYearController,
                  keyboardType: TextInputType.number),
              buildEditableField("Department", departmentController),
              buildEditableField("Availability", availabilityController),
              buildEditableField("Authors", authorController),
              buildEditableField("Categories", categoryController),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                ),
                onPressed: addBook,
                child: const Text("Add Book",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Domine")),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFE0C496),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
