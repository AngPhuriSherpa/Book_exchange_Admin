import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateField extends StatefulWidget {
  const MyDateField({
    super.key,
    required this.controller,
    required this.labelText,
  });
  final TextEditingController controller;
  final labelText;

  @override
  State<MyDateField> createState() => _MyDateFieldState();
}

class _MyDateFieldState extends State<MyDateField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(1995),
            firstDate: DateTime(1995),
            lastDate: DateTime(2010),
          );
          if (selectedDate != null) {
            final formattedDate = DateFormat.yMMMd().format(selectedDate);
            widget.controller.text = formattedDate;
          }
        },
        child: IgnorePointer(
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }
}
