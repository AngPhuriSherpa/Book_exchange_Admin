import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String imagePath;
  final String imageText;
  final Function()? onTap;
  const Tile({
    super.key,
    required this.imagePath,
    required this.imageText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          // borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 36,
               fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(imageText)
          ],
        ),
      ),
    );
  }
}
