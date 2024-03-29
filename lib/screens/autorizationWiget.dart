import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/firebase/firebase_auth_user.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/registration.dart';
import 'package:windows1251/windows1251.dart';

List<Group> groups = [];

Future<List<Group>> getGroups() async {
  groups.clear();
  final Uri uri = Uri.parse('https://umu.sibadi.org/Ved/');
  final fackindexes = {
    0: [52, 'АДПГС'],
    1: [54, 'АТНиСТ'],
    2: [43, 'ЗФ'],
    3: [50, 'ИМА'],
    4: [53, 'ИСЭиУ'],
  };
  for (int i = 0; i < fackindexes.length; i++) {
    final response = await http.Client().post(uri,
        headers: {'cookie': 'cmbFacultetsSaveValue=${fackindexes[i]![0]}'});

    if (response.statusCode == 200) {
      final document = parse(response.body, encoding: 'utf-8');
      final table =
          document.getElementsByClassName('dxeHyperlink_MaterialCompact');
      //List<String> groups = [];
      for (int j = 0; j < table.length; j++) {
        groups.add(
          Group(
            link: table[j].attributes.values.last.replaceAll('?group=', ''),
            name: windows1251.decode(table[j].text.codeUnits),
            fack: fackindexes[i]![1].toString(),
          ),
        );
      }
    }
  }
  return groups;
}

class Autorisation extends StatefulWidget {
  const Autorisation() : super();

  @override
  AutorisationState createState() => AutorisationState();
}

class AutorisationState extends State<Autorisation> {
  late FToast fToast;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void goToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const ChooseGroup(),
      ),
    );
  }

  Future<void> addDataToFirestore() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'User ID': FirebaseAuth.instance.currentUser?.uid});
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    getGroups();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Image.asset(
                  'lib/images/Exclude.png',
                  alignment: Alignment.bottomCenter,
                  scale: 4.5,
                  color: const Color.fromARGB(255, 0, 119, 255),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                //color: Colors.green,
                child: Text(
                  'Добро пожаловать!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alumniSans(
                    textStyle: const TextStyle(
                      fontSize: 45,
                      // fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 20, 106, 255),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: 'Почта',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black45),
                  labelText: 'Пароль',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  final User? user = await Auth().signInWithEmailAndPassword(
                      emailController.text, passwordController.text);
                  if (user != null) {
                    goToNextPage(context);
                    await addDataToFirestore();
                  } else {
                    await Fluttertoast.showToast(
                      msg: 'Не удалось войти в аккаунт',
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 94, 255),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Center(
                  child: Text(
                    'Войти',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  goToNextPage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 94, 255),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Center(
                  child: Text(
                    'Войти как гость',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const Registration(),
                    ),
                  );
                },
                child: const Text(
                  'Зарегистрироваться',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  //color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class Group {
  const Group({
    required this.link,
    required this.name,
    required this.fack,
  });

  final String link;
  final String name;
  final String fack;

  @override
  String toString() => '$name, $link';

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Group && other.name == name && other.link == link;
  }

  Group.fromJson(Map<String, dynamic> json)
      : link = json['kod'] as String,
        name = json['name'] as String,
        fack = json['fack'] as String;

  Map<String, dynamic> toJson() => {
        'kod': link,
        'name': name,
        'fack': fack,
      };

  @override
  int get hashCode => Object.hash(link, name);
}
