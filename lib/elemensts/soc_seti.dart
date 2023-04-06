import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocSeti extends StatelessWidget {
  final String imagePath;
  final String url;
  const SocSeti({
    super.key,
    required this.imagePath,
    required this.url
  });


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(imagePath,
          height: 55,
          ) ,
        ),
      ),
    );
  }
}

