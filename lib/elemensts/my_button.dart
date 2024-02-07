import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => runApp(const MyApp()),
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
