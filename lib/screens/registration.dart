import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../firebase/firebase_auth_user.dart';
import 'choose_group.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Регистрация',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 94, 255)
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextField(
                
                controller: emailController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Почта',
                  labelStyle: TextStyle(color: Colors.black54)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextField(
                controller: passwordController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Пароль',
                  labelStyle: TextStyle(color: Colors.black54)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if(emailController.text.contains(' ')){
                    emailController.text.replaceAll(' ', '');
                  }
                  User? user = await Auth().registerWithEmailAndPAssword(emailController.text, passwordController.text);
                  
                  
                  if (user != null){

                    await FirebaseFirestore.instance.collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .set({
                        'User ID': FirebaseAuth.instance.currentUser?.uid,
                        'Email' : FirebaseAuth.instance.currentUser?.email,
                        'Display Name' : FirebaseAuth.instance.currentUser?.displayName,
                      });
                      
                    

                    Navigator.push(
                      context, 
                      new MaterialPageRoute(builder: (BuildContext context) => 
                        new ChooseGroup()
                      )
                    );
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Не удалось зарегистрировать',);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 94, 255),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Center(
                  child: Text('Зарегистрироваться',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context,);
              },
              child: Text(
                'Назад',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          ],
        ),
      )
    );
  }
}