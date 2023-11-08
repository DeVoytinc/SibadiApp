import 'dart:async';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/screens/services_screen/bibly_screen.dart';
import '../../logic/ConnetionCheck.dart';

enum bibilyAuthStates { Waiting,  Authorized, notAuthorized}

class BibliyAuthScreen extends StatefulWidget {
  const BibliyAuthScreen({super.key});

  @override
  State<BibliyAuthScreen> createState() => _BibliyAuthScreenState();
}

class _BibliyAuthScreenState extends State<BibliyAuthScreen> {

  
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Библиотека"),
      ),
      body: AuthoriseWiget()
    );
  }

  Widget AuthoriseWiget() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Авторизация",
                style: TextStyle(
                  fontSize: 24,
                ),
              )
            ),
            Container(height: 30,),
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(),
                labelText: 'Логин (Фамилия)',
              ),
            ),
            Container(height: 20,),
            TextField(
              controller: passController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(),
                labelText: 'Пароль (Номер читательского билета)',
              ),
            ),
            Container(height: 20,),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context, 
                    new MaterialPageRoute(builder: (BuildContext context) => 
                      BiblyScreen(login: loginController.text, pass: passController.text)
                    )
                  );
                }, 
                child: Text("Вход")
              )
            )
          ],
        ),
      ),
    );  
  }
}