import 'package:flutter/material.dart';

import '../main.dart';
class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => runApp(MyApp()),
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8)

        ) ,
        child: const Center(
          child: Text('Вход',
            style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

        ),
      ),
    );
  }
}
