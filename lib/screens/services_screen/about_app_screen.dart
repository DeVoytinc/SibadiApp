import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('O приложении', style: TextStyle(fontSize: 17),),
            SizedBox(height: 5,),
            Text('Приложение разработано студентами для студентов (в основном), пока здесь много багов, и само приложение сырое, но мы его улучшаем :)'),
          ],
        ),
      ),
    );
  }
}