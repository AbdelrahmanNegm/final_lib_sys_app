import 'package:flutter/material.dart';


import '../constants.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("assets/images/logo.png"),
            const Text(
              "Learn How To Learn !",
              style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 55,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 80,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      AppConstants.primaryColor,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold, color: Colors.white),
                  )),
            ),
            const SizedBox(height: 40,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 80,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));

                  },
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(
                      AppConstants.buttonsColor,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold, color: Colors.black),
                  )),
            ),
            const SizedBox(height: 75,),
          ],
        ),
      ),
    );
  }
}
