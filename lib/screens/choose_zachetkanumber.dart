import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/main.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:windows1251/windows1251.dart';

late Zachetka selectedZachetka;
late List<Zachetka> zachetki = [];

class ChooseZachetca extends StatefulWidget {
  const ChooseZachetca({super.key});

  @override
  _ChooseZachetcaState createState() => _ChooseZachetcaState();
}

Future<List<Zachetka>> getZachetcki() async {
  zachetki.clear();
  final Uri uri = Uri.parse(
    'https://umu.sibadi.org/Totals/Totals.aspx?group=${selectedGroup.link}',
  );

  final response = await http.Client().get(uri);

  if (response.statusCode == 200) {
    final document = parse(response.body, encoding: 'utf-8');
    final table = document.getElementsByClassName('TitleVedInf');
    for (int i = 3; i < table.length; i++) {
      final a = table[i].getElementsByTagName('a');
      zachetki.add(
        Zachetka(
          name: windows1251.decode(a[0].text.codeUnits),
          kod: a[0].attributes.values.first.split('id=')[1],
        ),
      );
    }
  }
  return zachetki;
}

class _ChooseZachetcaState extends State<ChooseZachetca>
    with SingleTickerProviderStateMixin {
  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void goToNextPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const MyHomePage(),
      ),
      (Route<dynamic> route) => false,
    );
    //);
  }

  @override
  void initState() {
    setState(() {
      //getData(selectedDate);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getZachetcki();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 106, 255),
        title: const Center(
          child: Text(
            "Номер зачётки",
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            goBack(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 20, 106, 255),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getZachetcki(),
              builder: (context, snapshot) => ListView.builder(
                controller: ScrollController(),
                itemCount: zachetki.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    selectedZachetka = zachetki[index];
                    setSelectedZachetka();
                    //runApp(MyApp());
                    goToNextPage(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 20, 106, 255),
                    ),
                    height: 70,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(
                                zachetki[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Zachetka {
  const Zachetka({
    required this.kod,
    required this.name,
  });

  final String kod;
  final String name;

  @override
  String toString() => '$name, $kod';

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Group && other.name == name && other.link == kod;
  }

  Zachetka.fromJson(Map<String, dynamic> json)
      : kod = json['kod'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        'kod': kod,
        'name': name,
      };

  @override
  int get hashCode => Object.hash(kod, name);
}
