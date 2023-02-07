import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/screens/autorizationWiget.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/screens/choose_group.dart';
import 'package:windows1251/windows1251.dart';
import 'package:html/parser.dart';

late Zachetka selectedZachetka;
late List<Zachetka> zachetki = [];

class ChooseZachetca extends StatefulWidget{
  ChooseZachetca({Key? key}) : super(key: key);

  @override
  _ChooseZachetcaState createState() => _ChooseZachetcaState();
}

class _ChooseZachetcaState extends State<ChooseZachetca> with SingleTickerProviderStateMixin{

  void goBack(BuildContext context){
    Navigator.pop(context);
  }

  void goToNextPage(BuildContext context){
    Navigator.push(
      context, 
      new MaterialPageRoute(builder: (BuildContext context) => 
        new MyApp()
      )
    );
  }

  getZachetcki() async {
    zachetki.clear();
    Uri uri = Uri.parse('https://umu.sibadi.org/Totals/Totals.aspx?group=${selectedGroup.link}');

    final response =
    await http.Client().get(uri);

    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var table = document.getElementsByClassName('TitleVedInf');
      for(int i = 3; i < table.length; i++){
        var a = table[i].getElementsByTagName('a');
        zachetki.add(Zachetka(name: windows1251.decode(a[0].text.codeUnits), kod: a[0].attributes.values.first.split('id=')[1]));
      }
    }
    
  }

  @override
  void initState() {
    setState(() {
      //getData(selectedDate);
    });
    super.initState();
  }
  //var searchGroups = groups;
  //late Group selectedGroup;
  
   @override
  Widget build(BuildContext context) {
    getZachetcki();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 60, 116, 213),
          // The search area here
        title: Center(
          child: Text("Номер зачётки",
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.white,),
          onPressed: () {
            goBack(context);
          },
        ),
       actions: [Padding(
         padding: const EdgeInsets.all(14.0),
         child: Icon(Icons.arrow_back,
            color: Color.fromARGB(255, 60, 116, 213),
            ),
       ),
        ]
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: getZachetcki(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: zachetki.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          selectedZachetka = zachetki[index];
                          setSelectedZachetka();
                          //runApp(MyApp());
                          goToNextPage(context);
                        },
                        child: Container( 
                              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                              decoration: BoxDecoration (
                              borderRadius: BorderRadius.circular(6),
                              color: Color.fromARGB(255, 60, 116, 213),
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
                                          style: TextStyle(
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
                      );
                    }
                  );
                  
                }
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
  String toString() {
    return '$name, $kod';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Group && other.name == name && other.link == kod;
  }

  Zachetka.fromJson(Map<String, dynamic> json)
      : kod = json['kod'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'kod': kod,
        'name': name,
      };

  @override
  int get hashCode => Object.hash(kod, name);
}