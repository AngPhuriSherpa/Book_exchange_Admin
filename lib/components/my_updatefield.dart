import 'package:flutter/material.dart';

class MyUpdateField extends StatefulWidget {
  const MyUpdateField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.keyboard});
  final TextEditingController controller;
  final labelText;
  final keyboard;

  @override
  State<MyUpdateField> createState() => _MyUpdateFieldState();
}

class _MyUpdateFieldState extends State<MyUpdateField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        enabled: widget.controller.text.contains('@') ? false : true,
        controller: widget.controller,
        keyboardType: widget.keyboard,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
