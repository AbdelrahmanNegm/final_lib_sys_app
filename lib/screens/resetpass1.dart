import 'package:flutter/material.dart';

void main() {
  runApp(ResetPassword1());
}

class ResetPassword1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResetPasswordScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
  final Color lightBeige = Color(0xffFFF8E0);
  final Color darkBeige = Color(0xFFB28F60);
  final Color cream = Color(0xFFFBEECB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBeige,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.brown),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Reset Password Form",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: darkBeige,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "your @email address",
                          hintStyle: TextStyle(color: Color(0xffB28F63)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: cream,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff332417).withOpacity(0.8),
                            offset: Offset(2, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // TODO: Add reset password logic
                        },
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.brown[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
