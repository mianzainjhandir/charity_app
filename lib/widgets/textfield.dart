import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  final FocusNode _focusNode = FocusNode();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bool isFocused = _focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextField(
          controller: widget.controller,
          focusNode: _focusNode,

          keyboardType: widget.keyboardType,

          obscureText: widget.isPassword
              ? _obscureText
              : false,

          style: const TextStyle(
            fontSize: 14,
          ),

          decoration: InputDecoration(

            hintText: widget.hintText,

            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),

            filled: true,

            fillColor: Colors.grey.shade50,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.deepOrange.shade300,
                width: 1.5,
              ),
            ),

            // Password eye button
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey.shade600,
              ),
            )
                : null,
          ),
        ),

        // Focus hone par message
        if (isFocused) ...[
          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.isPassword
                  ? "Please enter your password"
                  : "Please enter your email address",

              style: TextStyle(
                fontSize: 11,
                color: Colors.deepOrange.shade300,
              ),
            ),
          ),
        ],
      ],
    );
  }
}