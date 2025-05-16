import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool isPassword;
  final bool isNumber;
  final IconData? icon;
  final String? Function(String?)? validator;
  final String? errorText;
  final Widget? suffixIcon;
  final String? Function(String?)? passwordChecker;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.isPassword = false,
    this.isNumber = false,
    this.icon,
    this.validator,
    this.errorText,
    this.suffixIcon,
    this.passwordChecker,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false; // تم نقله خارج build

  @override
  void initState() {
    super.initState();
    isObscure = widget
        .isPassword; // تأكد من تعيين القيمة الافتراضية بناءً على isPassword
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
      keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        if (widget.passwordChecker != null) {
          return widget.passwordChecker!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.grey.shade200, // لون محايد أفضل
        prefixIcon:
            widget.icon != null ? Icon(widget.icon, color: Colors.black) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
              )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500),
        errorText: widget.errorText,
      ),
    );
  }
}
