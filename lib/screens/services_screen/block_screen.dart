import 'package:flutter/material.dart';

class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Этот сервис пока недоступен',
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}