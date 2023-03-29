import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled1/PersonalStateMent.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/main.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:windows1251/windows1251.dart';

String groupLink = selectedGroup.link;
String zachetkaNumber = selectedZachetka.kod;

class CommonStatementForDisc extends StatefulWidget{
  CommonStatementForDisc({Key? key}) : super(key: key);

  @override
  _CommonStatementForDiscState createState() => _CommonStatementForDiscState();
}

class _CommonStatementForDiscState extends State<CommonStatementForDisc> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  List<CommonStatement3> disciplines = <CommonStatement3>[];



  getData() async {
    if (disciplines.isNotEmpty) {
      return disciplines;
    }
    var client = http.Client();
    final response =
    await client.get(Uri.parse('https://umu.sibadi.org/Ved/TotalVed.aspx?year=2022-2023&sem=1&id=${zachetkaNumber}'));
    
    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var table = document.getElementsByClassName('dxeHyperlink_MaterialCompact');
      //var table2 = document.getElementsByClassName('dxgvDataRow_MaterialCompact dxgvDataRowAlt_MaterialCompact');
      for(int i = 0; i < table.length; i= i + 2){
        String type = windows1251.decode(table[i].parentNode!.parentNode!.nodes.toList()[1].nodes.toList()[0].text!.codeUnits);
        Color cl = mygreen;
        if (type == "Экзамен") {
          cl = myyellow;
        }
        if (type == "Курсовая работа") {
          cl = myred;
        }
        if (type == "Курсовой проект") {
          cl = myred;
        }
        disciplines.add(CommonStatement3(disciplineName: windows1251.decode(table[i].text.codeUnits), disciplineType: type, color: cl));
      }
      //disciplines.add('хуй');
      return disciplines;
    }
    return disciplines;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    //getData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    disciplines.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //backgroundColor: mybackground,
      body: Container(
        //margin: EdgeInsets.only(top: 20),
        child: TabBarView(
          controller: _tabController,
          children: [
        FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData){
              return Center(
                child: Text("loading"),
                );
            }
            else {
              return Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: disciplines.length,
                  itemBuilder: (BuildContext context, int index){
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: mygrey),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 7),
                                    child: Container(
                        
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 10,
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                child: Text(
                                                  disciplines[index].disciplineName,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  )
                                                  ),
                                                                
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                //margin: EdgeInsets.only(left: 40),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 10),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: disciplines[index].color),
                                                  child: Center(
                                                    child: Text(
                                                      disciplines[index].disciplineType,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //SizedBox(height: 100,)
                            ],
                          ),
                        )
                      ]
                    );
                  }
                  ),
              );

            }
            }
          ),
          // ListView(
          //   children: [
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //     ItemCommonStatement('asfd'),
          //   ],
          // ),
          ListView(
            children: [
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
            ],
          ),
          ListView(
            children: [
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
              PersonalStatementItem(),
            ],
          )
      ],),
      ),
      
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Center(
            child: Text(
              'Ведомость',
              style: TextStyle(
                color: myblue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
          color: Colors.white,
          child: TabBar(
            //labelColor: Colors.white,
            indicatorColor: myblue,
            controller: _tabController,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: <Widget>[
              // ignore: prefer_const_constructors
              Tab(
                child: const Text(
                  'Общая',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 95, 95),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              Tab(
                child:const Text(
                  'Личная',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 95, 95),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
              Tab(
                child:const Text(
                  'Зачетка',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 95, 95),
                  ),
                ),
              ),
            ],
          ),
          )
        ),
      ),
    );
  }

}
class CommonStatement3 {
  const CommonStatement3({
    required this.disciplineName,
    required this.disciplineType,
    required this.color,
  });

  final String disciplineName;
  final String disciplineType;
  final Color color;

  @override
  String toString() {
    return '$disciplineType, $disciplineName';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CommonStatement3 && other.disciplineType == disciplineType && other.disciplineName == disciplineName;
  }

  @override
  int get hashCode => Object.hash(disciplineName, disciplineType);
}