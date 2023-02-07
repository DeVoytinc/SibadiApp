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
         // border: Border.all(  color:  Color.fromARGB(255, 255, 255, 255),),
          borderRadius: BorderRadius.circular(16),
          //color:  Color.fromARGB(255, 255, 255, 255),
    
        ),
        child: Image.asset(imagePath,
        // color: Color.fromARGB(255, 60, 116, 213),
        height: 55,
        ) ,
      ),
    );
  }
}
