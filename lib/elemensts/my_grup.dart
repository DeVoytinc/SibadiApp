import 'package:flutter/material.dart';
  
String enteredText = '';
TextEditingController groupTextController = TextEditingController();

class MyGrup extends StatelessWidget {

  const MyGrup({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: groupTextController,
          decoration: InputDecoration(
            hintText: 'Группа',
            hintStyle: TextStyle(color: Colors.grey[500]),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
          ),
        ),
      );
  }
}
