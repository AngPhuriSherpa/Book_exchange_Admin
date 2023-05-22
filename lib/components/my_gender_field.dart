import 'package:flutter/material.dart';

class MyGenderField extends StatefulWidget {
  const MyGenderField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  _MyGenderFieldState createState() => _MyGenderFieldState();
}

class _MyGenderFieldState extends State<MyGenderField> {
  late String _selectedGender = getGender();
  final genderList = <String>["-", "Male", "Female", "Other"];
  String getGender() {
    setState(() {
      if (widget.controller.text == 'Male') {
        _selectedGender = genderList[1];
      } else if (widget.controller.text == 'Female') {
        _selectedGender = genderList[2];
      } else if (widget.controller.text == 'Other') {
        _selectedGender = genderList[3];
      } else if (widget.controller.text == '-') {
        _selectedGender = genderList[0];
      }
    });
    return _selectedGender;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Gender',
            style: TextStyle(fontSize: 18),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: const Text('Gender'),
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                    widget.controller.text = _selectedGender;
                  });
                },
                items: genderList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
