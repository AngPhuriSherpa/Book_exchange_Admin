import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog(
    BuildContext context, String title, String message) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );
}
