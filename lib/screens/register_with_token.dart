import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/constants.dart';
import 'package:library_app/models/form_model_item.dart';
import 'package:library_app/screens/home_screen_integration.dart';
import 'package:library_app/screens/login_screen.dart';

class RegisterScreen22 extends StatefulWidget {
  const RegisterScreen22({super.key});

  @override
  State<RegisterScreen22> createState() => _RegisterScreen22State();
}

class _RegisterScreen22State extends State<RegisterScreen22> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  bool isLoading = false;

  Map<String, int> academicYearsMap = {
    'First Year': 1,
    'Second Year': 2,
    'Third Year': 3,
    'Fourth Year': 4,
  };

  String? selectedYear; // تخزين السنة المختارة

  Future<void> registerUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        phoneController.text.isEmpty ||
        departmentController.text.isEmpty ||
        roleController.text.isEmpty ||
        selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final int? role = int.tryParse(roleController.text);
    final int? year = academicYearsMap[selectedYear];

    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Role must be a valid integer')),
      );
      return;
    }

    if (selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an academic year')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://fci-library.me/api/User/register');

    // استرجاع التوكن من SharedPreferences أو أي مكان آخر
    const String token = 'your_token_here'; // هنا استرجع التوكن المناسب

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'role': role,
          'department': departmentController.text,
          'phone': phoneController.text,
          'year': year,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // إضافة التوكن
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreenInt()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xFFFBEECB)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF2DEB3),
                          borderRadius: BorderRadius.circular(25)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  CustomTextField(
                                      controller: nameController,
                                      label: 'Name',
                                      hint: 'Enter your name',
                                      icon: Icons.person),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                      controller: emailController,
                                      label: 'Email',
                                      hint: 'Enter your email',
                                      icon: Icons.email),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                      controller: passwordController,
                                      label: 'Password',
                                      isPassword: true,
                                      hint: 'Enter your password',
                                      icon: Icons.lock),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                      controller: confirmPasswordController,
                                      label: 'Confirm Password',
                                      isPassword: true,
                                      hint: 'Re-enter your password',
                                      icon: Icons.lock),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                      controller: phoneController,
                                      label: 'Phone',
                                      hint: 'Enter your phone number',
                                      icon: Icons.phone),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                      controller: departmentController,
                                      label: 'Department',
                                      hint: 'Enter your department',
                                      icon: Icons.business),
                                  const SizedBox(height: 15),
                                  CustomTextField(
                                      controller: roleController,
                                      label: 'Role (integer)',
                                      isNumber: true,
                                      hint: 'Enter your role ID',
                                      icon: Icons.assignment_ind),
                                  const SizedBox(height: 15),
                                  DropdownButtonFormField<String>(
                                    value: selectedYear,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedYear = newValue;
                                      });
                                    },
                                    items: academicYearsMap.keys.map((year) {
                                      return DropdownMenuItem<String>(
                                        value: year,
                                        child: Text(year),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      labelText: 'Academic Year',
                                      prefixIcon: const Icon(
                                        Icons.calendar_month,
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFFB28F63),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  isLoading
                                      ? const CircularProgressIndicator()
                                      : ElevatedButton(
                                          onPressed: registerUser,
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFFFBEECB)),
                                          child: const Text(
                                            'Create Account',
                                            style: TextStyle(
                                                color: Color(0xFF553C28)),
                                          )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an Account?'),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                        },
                                        child: const Text("Login",
                                            style: TextStyle(
                                                color: Color(0xFF007B25),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 15,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/logo.png",
              width: MediaQuery.of(context).size.width * 0.5,
              height: 110,
            ),
          ),
        ],
      ),
    );
  }
}
