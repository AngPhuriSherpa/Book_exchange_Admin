import 'package:flutter/material.dart';

Future<void> showErrorMessage(
  BuildContext context,
  String title,
  String content,
) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              title.split('-').join(' '),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Text(content),
            const Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    },
  );
}
