import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerWithEmailAndPAssword(
  String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithEmailAndPassword(
  String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    
  }

  Future<void> signOut() async {
    _auth.signOut();
  }
}


class FireAuth extends StatefulWidget {
  const FireAuth({super.key});

  @override
  State<FireAuth> createState() => _FireAuthState();
}

class _FireAuthState extends State<FireAuth> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
                "Для некоторых наших сервисов необходима дополнительная авторизация сделайте это через Google аккаунт или почту с паролем"),
            SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Почта',
              ),
              onChanged: ((value) {}),
            ),
            //Text('Пароль'),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Пароль',
              ),
              onChanged: ((value) {}),
            ),
            SizedBox(height: 30,),

            ElevatedButton(
              onPressed: () {
                Auth().signInWithEmailAndPassword(emailController.text, passwordController.text);
              },
              child: Text('Вход'),
              style: ElevatedButton.styleFrom(fixedSize: Size(150, 30)),
            ),
            ElevatedButton(
              onPressed: () {
                Auth().registerWithEmailAndPAssword(
              emailController.text, passwordController.text);
              }, 
              child: Text('Регистрация'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 30)
              ),
            ),
            Expanded(child: Container()),
            Divider(color: Colors.white54,),
            // TODO: изменить иконку
            IconButton(onPressed: () {
              Auth().registerWithEmailAndPAssword(
              emailController.text, passwordController.text);
            }, 
            icon: Icon(Icons.auto_stories_sharp))
          ],
        ),
      )),
    );
  }
}
