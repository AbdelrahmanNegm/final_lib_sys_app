import 'package:flutter/material.dart';

void main() => runApp(ResetPassword2());

class ResetPassword2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ResetPasswordPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  void _validatePasswords() {
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      _showMessage("Please fill both fields");
    } else if (password != confirm) {
      _showMessage("Passwords do not match");
    } else {
      _showMessage("Password reset successfully ✅");
      // هنا ممكن تضيف action فعلي لإرسال البيانات للسيرفر
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color lightBeige = Color(0xffFFF8E0);
    final Color darkBeige = Color(0xFFB28F60);
    final Color cream = Color(0xFFFBEECB);

    return Scaffold(
      backgroundColor: lightBeige,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.brown),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'reset password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff553C28),
                ),
              ),
              SizedBox(height: 40),

              // Password Field
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: darkBeige,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color(0xff553C28)),
                    //icon: Icon(Icons.lock_outline, color: Colors.black),
                    icon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Confirm Password Field
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: darkBeige,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _confirmController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'confirm password',
                    hintStyle: TextStyle(color: Color(0xff553C28)),
                    //icon: Icon(Icons.lock_outline, color: Colors.black),
                    icon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 60),

              // Confirm Button
              Container(
                width: 150,
                decoration: BoxDecoration(
                  color: cream,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.7),
                      offset: Offset(2, 4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: _validatePasswords,
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff553C28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
