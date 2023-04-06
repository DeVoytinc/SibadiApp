import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/elemensts/soc_seti.dart';
import 'package:windows1251/windows1251.dart';
import 'package:html/parser.dart';

import 'choose_group.dart';

List<Group> groups = [];

getGroups() async {
  groups.clear();
  Uri uri = Uri.parse('https://umu.sibadi.org/Ved/');
  var fackindexes = {
    0 : [52, 'АДПГС'], 
    1 : [54, 'АТНиСТ'], 
    2 : [43, 'ЗФ'], 
    3 : [50, 'ИМА'], 
    4 : [53, 'ИСЭиУ']
  };
  for (int i = 0; i < fackindexes.length; i++){
    final response =
    await http.Client().post(uri, headers: {'cookie':'cmbFacultetsSaveValue=${fackindexes[i]![0]}'});

    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var table = document.getElementsByClassName('dxeHyperlink_MaterialCompact');
      //List<String> groups = [];
      for(int j = 0; j < table.length; j++){
        groups.add(Group(
          link: table[j].attributes.values.last.replaceAll('?group=', ''), 
          name: windows1251.decode(table[j].text.codeUnits),
          fack: fackindexes[i]![1].toString(),
          )
        );
      }
    }
  }
}

class Autorisation extends StatefulWidget {
  //Autorisation({super.key});
  Autorisation() : super();

  @override
  AutorisationState createState() => AutorisationState();
}



class AutorisationState extends State<Autorisation>{

  static String _displayStringForOption(Group option) => option.name;

  void goToNextPage(BuildContext context){
    Navigator.push(
      context, 
      new MaterialPageRoute(builder: (BuildContext context) => 
        new ChooseGroup()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    getGroups();
    return Scaffold(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    //backgroundColor: Color.,
    body: Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        //color:  Color.fromARGB(255, 245, 245, 245),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.all(8),
              child: Image.asset(
                'lib/images/Exclude.png',
                alignment: Alignment.bottomCenter,
                scale: 6,
                color: Color.fromARGB(255, 0, 119, 255),
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
                  textStyle: TextStyle(
                    fontSize: 38,
                    // fontWeight: FontWeight.w300,
                    color:  Color.fromARGB(255, 20, 106, 255),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              //color: Colors.red,
                child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_hxart9lz.json',
                  height: 350,
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
              onPressed: () {
                goToNextPage(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 0, 94, 255)),
                padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 20)),
                //elevation: MaterialStatePropertyAll<double>(100),
                //shape:  MaterialStatePropertyAll<OutlinedBorder>(OutlinedBorder(side: )),
                ),
              child: const Center(
                child: Text('Вход',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ),
          ),
          Expanded(child: Container(
            //color: Colors.black,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                Expanded(child: Divider(
                  thickness: 1,
                  color:Color.fromARGB(255, 175, 175, 175),
                ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Социальные сети',
                    style: TextStyle(
                      color: Color.fromARGB(255, 175, 175, 175),
                    ),
                  ),
                ),

                Expanded(child: Divider(
                  thickness: 1,
                  color:Color.fromARGB(255, 175, 175, 175),
                ),
                ),

              ],
            ),
          ),

          //const SizedBox(height: 20),

          //Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                //яндекс дзен
                SocSeti(imagePath: 'lib/images/vk.png', url: 'https://vk.com/sibadilife',),
                //const SizedBox(width: 10,),
                // vk
                SocSeti(imagePath: 'lib/images/TikTok.png', url: 'https://www.tiktok.com/@sibadilife',),
                //const SizedBox(width: 10,),

                //tiktok
                SocSeti(imagePath: 'lib/images/YouTube.png', url: 'https://www.youtube.com/user/sibaditv',),
                //const SizedBox(width: 10,),

                //telegram
                SocSeti(imagePath: 'lib/images/Telegram.png', url: 'https://t.me/sibadilife',),

              ],
            ),
          ),

          //Expanded(child: Container(color: Color.fromARGB(255, 255, 255, 255),))
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
  String toString() {
    return '$name, $link';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Group && other.name == name && other.link == link;
  }

  Group.fromJson(Map<String, dynamic> json)
      : link = json['kod'],
        name = json['name'],
        fack = json['fack'];

  Map<String, dynamic> toJson() => {
        'kod': link,
        'name': name,
        'fack': fack,
      };

  @override
  int get hashCode => Object.hash(link, name);
}
