import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UserProfileEdit extends StatefulWidget {
  const UserProfileEdit({super.key});

  @override
  UserProfileEditState createState() => UserProfileEditState();
}

class UserProfileEditState extends State<UserProfileEdit> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  File? _image;
  String? base64Image;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    final url = Uri.parse('https://fci-library.me/api/user/profile/searchid/1');
    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Profile data: $data');

        // معالجة الصورة القادمة من الباك اند
        if (data['image'] != null && data['image'].toString().isNotEmpty) {
          base64Image = data['image'];
        }

        setState(() {
          nameController.text = data['name'] ?? "";
          emailController.text = data['email'] ?? "";
          idController.text = "2051234580@fci.zu.eg"; // ثابت حسب ما كتبت
          phoneController.text = data['phone'] ?? "";
          yearController.text = data['year'].toString();
        });
      } else {
        debugPrint('Error: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } catch (e) {
      debugPrint('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> updateProfile() async {
    final url = Uri.parse('https://fci-library.me/api/User/profile/updateid/1');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "department": "CS",
          "phone": phoneController.text,
          "year": int.parse(yearController.text),
          "image": base64Image, // إرسال الصورة هنا
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Profile updated: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        debugPrint('Update failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${response.body}')),
        );
      }
    } catch (e) {
      debugPrint('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      setState(() {
        _image = imageFile;
        base64Image = base64Encode(bytes); // تحويل إلى base64
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBEECB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.brown),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded, color: Colors.brown),
            onPressed: () {
              updateProfile();
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFBEECB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: const Color(0xffB28F63),
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : base64Image != null
                          ? MemoryImage(base64Decode(base64Image!))
                              as ImageProvider
                          : null,
                  child: _image == null && base64Image == null
                      ? const Text(
                          "Upload your photo",
                          style: TextStyle(color: Colors.white),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(nameController, Icons.person),
              _buildTextField(emailController, Icons.email),
              _buildTextField(idController, Icons.badge, enabled: false),
              _buildTextField(phoneController, Icons.phone),
              _buildTextField(yearController, Icons.calendar_today),
              const SizedBox(height: 30),
              const Text(
                "Please make sure your information is correct so we can contact you...",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, IconData icon,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black54),
          filled: true,
          fillColor: const Color(0xffB28F63),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
