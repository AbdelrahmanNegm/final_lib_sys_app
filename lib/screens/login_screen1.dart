import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/constants.dart';
import 'package:library_app/screens/home_screen.dart';
import 'package:library_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 120),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFBEECB),
                        borderRadius: BorderRadius.circular(25)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          SizedBox(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFE0C496),
                                  borderRadius: BorderRadius.circular(18)),
                              child: const Center(
                                  child: Text(
                                'Welcome To FCI Library!',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: const Center(
                              child: Text(
                                'Here where your ideas born..',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFAE5AE),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    "Login".toUpperCase(),
                                    style: const TextStyle(
                                        color: AppConstants.primaryColor,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: const TextStyle(
                                            color: AppConstants.buttonsColor),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20),
                                        fillColor: const Color(0xFFB28F63),
                                        prefixIcon: const Icon(
                                          Icons.email_outlined,
                                          color: AppConstants.buttonsColor,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.grey)),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: !isShowPassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: const TextStyle(
                                            color: AppConstants.buttonsColor),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20),
                                        fillColor: const Color(0xFFB28F63),
                                        prefixIcon: const Icon(
                                          Icons.lock_outline,
                                          color: AppConstants.buttonsColor,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isShowPassword = !isShowPassword;
                                            });
                                          },
                                          icon: Icon(
                                            isShowPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off_outlined,
                                            color: AppConstants.primaryColor,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.grey)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      login(emailController.text,
                                          passwordController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFBEECB),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          60),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Don’t Have an Account?",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterScreen()),
                                          );
                                        },
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                              color: Color(0xff57AF6C)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: -15,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/logo.png",
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.245,
              )),
        ],
      ),
    );
  }

  // Login API call
  Future<void> login(String email, String password) async {
    final url = Uri.parse('https://fci-library.me/api/user/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Login successful: $data');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Handle invalid login attempts
        print('Login failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
}
