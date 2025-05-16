import 'package:flutter/material.dart';
import 'package:library_app/screens/register_screen.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRemember = false;
  bool isShowPassword = true;
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
                height: 165,
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
                          height: 76,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: const Color(0xFFE0C496),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Text(
                            "Welcome To FCI Library !",
                            style: TextStyle(
                                color: AppConstants.primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        const Text(
                          "Here where your ideas born..\n Find your book easier Now!",
                          style: TextStyle(
                              color: AppConstants.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                              color: const Color(0xFFFAE5AE),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Login".toUpperCase(),
                                style: const TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 26,
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
                                          const EdgeInsets.symmetric(vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
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
                                height: 26,
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
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(vertical: 20),
                                      fillColor: const Color(0xFFB08E62),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isShowPassword = ! isShowPassword ;
                                          });

                                        },
                                        icon:  Icon(
                                          isShowPassword ? Icons.visibility : Icons.visibility_off_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFB08E62),
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            color: AppConstants.primaryColor,
                                          ))),
                                  keyboardType: TextInputType.emailAddress,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: isRemember,

                                        fillColor: const WidgetStatePropertyAll(
                                            Colors.white),
                                        // activeColor: AppConstants.primaryColor,
                                        checkColor: AppConstants.primaryColor,
                                        onChanged: (value) {
                                          setState(() {
                                            isRemember = value! ;
                                          });
                                        },
                                      ),
                                      const Text(
                                        "Remember me",
                                        style: TextStyle(
                                            color: AppConstants.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Forgot Password ?",
                                      style: TextStyle(
                                          color: AppConstants.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 70,
                                child: ElevatedButton(
                                    onPressed: () {
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: const WidgetStatePropertyAll(
                                        Color(0xFFF9EDCA),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(23),
                                        ),
                                      ),
                                       elevation: const WidgetStatePropertyAll(5),
                                    ),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppConstants.primaryColor),
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account ? ",
                                    style: TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                          const RegisterScreen()));

                                    },
                                    style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                                    ),
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
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
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Image.asset("assets/images/logo.png" ,width: MediaQuery.of(context).size.width * 0.5,height: 150,)),

        ],
      ),
    );
  }
}
