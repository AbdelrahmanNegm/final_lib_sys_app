import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    // انتقل إلى الشاشة التالية بعد 3 ثوانٍ
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/signInScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBEECB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 3),
              opacity: _opacity,
              child: Image.asset('assets/images/logofci.png', height: 200),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: const Text(
                "Learn How To Learn!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
