import 'package:flutter/material.dart';
import 'package:library_app/screens/login_screen1.dart';
import 'package:library_app/screens/register_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_background.jpeg', // تأكد من إضافة الصورة إلى مجلد assets
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const Spacer(),
              ClipPath(
                clipper: DiagonalClipper(),
                child: Container(
                  height: 350,
                  color: const Color(0xFFFFF8E0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Learn How To Learn !',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF553C28)),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                          text: 'Login',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }),
                      const SizedBox(height: 20),
                      CustomButton(
                          text: 'Register',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          }),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 20),
              // Text(
              //   'Learn How To Learn !',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 20),
              // CustomButton(text: 'Login', onPressed: () {}),
              // SizedBox(height: 10),
              // CustomButton(text: 'Register', onPressed: () {}),
              // SizedBox(height: 40),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * .44,
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
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 100);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF2DEB3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: Color(0xFF553C28)),
          ),
        ),
      ),
    );
  }
}
