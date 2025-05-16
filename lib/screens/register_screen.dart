import 'package:flutter/material.dart';

import '../constants.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  final List<String> academicYears = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];
  String? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFBEECB),
                      borderRadius: BorderRadius.circular(25)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF2DEB3),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Register".toUpperCase(),
                                style: const TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: nameController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      // labelText: "Email",
                                      hintText: "Name",
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your name";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: emailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      // labelText: "Email",
                                      hintText: "Email",
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter an email";
                                    } else if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                        .hasMatch(value)) {
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: studentEmailController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      // labelText: "Email",
                                      hintText: "Student Email",
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value != null &&
                                        value.isNotEmpty &&
                                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                                            .hasMatch(value)) {
                                      return "Please enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: phoneController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      // labelText: "Email",
                                      hintText: "Phone Number",
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter phone number";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: isShowPassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      // labelText: "Email",
                                      hintText: "Password",
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Colors.black,
                                        size: 30,
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
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter password";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: isShowConfirmPassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      // labelText: "Email",
                                      hintText: "Confirm Password",
                                      filled: true,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isShowConfirmPassword =
                                                !isShowConfirmPassword;
                                          });
                                        },
                                        icon: Icon(
                                          isShowConfirmPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter confirm password";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: DropdownButtonFormField<String>(
                                  value: selectedYear,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 5),
                                    fillColor: const Color(0xFFB08E62),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFB08E62),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFB08E62),
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                          color: AppConstants.primaryColor,
                                        )),
                                  ),
                                  hint: const Text('Academic Year'),
                                  isExpanded: true,
                                  iconEnabledColor: Colors.black,
                                  dropdownColor:
                                      AppConstants.scaffoldBackgroundColor,
                                  items: academicYears.map((String year) {
                                    return DropdownMenuItem<String>(
                                      value: year,
                                      child: Text(year),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedYear = newValue;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: 70,
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                        Color(0xFFF9EDCA),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(23),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Create Account",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppConstants.primaryColor),
                                    )),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account ? ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    style: ButtonStyle(
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)))),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          // Positioned(
          //     top: 15,
          //     left: 0,
          //     right: 0,
          //     child: Image.asset("assets/images/logo.png" ,width: MediaQuery.of(context).size.width * 0.5,height: 120,)),
        ],
      ),
    );
  }
}
