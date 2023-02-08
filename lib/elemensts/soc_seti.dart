import 'package:flutter/material.dart';

class SocSeti extends StatelessWidget {
  final String imagePath;
  const SocSeti({
    super.key,
    required this.imagePath,
  });


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(imagePath,
        height: 55,
        ) ,
      ),
    );
  }
}
