import 'package:flutter/material.dart';
import 'package:untitled1/PersonalStateMent.dart';
import 'package:untitled1/commonStatementScreen.dart';
import 'package:untitled1/mycolors.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:untitled1/screens/timetable.dart';
import 'package:windows1251/windows1251.dart';

String groupLink = selectedGroup.link;
String zachetkaNumber = selectedZachetka.kod;

class TopTabBarStatement extends StatefulWidget{
  TopTabBarStatement({Key? key}) : super(key: key);

  @override
  _TopTabBarStatementState createState() => _TopTabBarStatementState();
}

class _TopTabBarStatementState extends State<TopTabBarStatement> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  List<CommonStatement> disciplines = <CommonStatement>[];

  int semNumber = 1;

  getData() async {
    // if (disciplines.isNotEmpty) {
    //   return disciplines;
    // }
    disciplines.clear();
    var client = http.Client();
    final response =
    await client.get(Uri.parse('https://umu.sibadi.org/Ved/TotalVed.aspx?year=2022-2023&sem=${semNumber.toString()}&id=${zachetkaNumber}'));
    
    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var table = document.getElementsByClassName('dxeHyperlink_MaterialCompact');
      //var table2 = document.getElementsByClassName('dxgvDataRow_MaterialCompact dxgvDataRowAlt_MaterialCompact');
      for(int i = 0; i < table.length; i= i + 2){
        String type = windows1251.decode(table[i].parentNode!.parentNode!.nodes.toList()[1].nodes.toList()[0].text!.codeUnits);
        Color cl = Theme.of(context).colorScheme.tertiary;
        if (type == "Экзамен") {
          cl = Theme.of(context).colorScheme.surface;
        }
        if (type == "Курсовая работа") {
          cl = Theme.of(context).colorScheme.scrim;
        }
        if (type == "Курсовой проект") {
          cl = Theme.of(context).colorScheme.scrim;
        }
        disciplines.add(CommonStatement(
          disciplineName: windows1251.decode(table[i].text.codeUnits), 
          disciplineType: type, 
          color: cl,
          id: table[i].attributes.values.last.split('id=')[1],
          ));
      }
      //disciplines.add('хуй');
      return disciplines;
    }
    return disciplines;
  }

  void goBack(BuildContext context){
    Navigator.pop(context);
  }

  void goToNextPage(BuildContext context, CommonStatement discip){
    Navigator.push(
      context, 
      new MaterialPageRoute(builder: (BuildContext context) => 
        new CommonStatementScreen(inputdata: discip)
      )
    );
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
        // child: TabBarView(
        //   controller: _tabController,
        //   children: [
        
        child: isConnected ? FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
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
                          child: GestureDetector(
                            onTap: (() => goToNextPage(context, disciplines[index])),
                            
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), 
                                color: Color.fromARGB(255, 180, 180, 180),
                                //color: disciplines[index].color,
                                ),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Container(
                                                  
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10), 
                                    color: Theme.of(context).canvasColor,
                                  ),
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
                                                //color: Color.fromARGB(255, 196, 196, 196),
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
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12), 
                                                color: disciplines[index].color),
                                              child: Center(
                                                child: Text(
                                                  disciplines[index].disciplineType,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(255, 255, 255, 255),
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
                        )
                      ]
                    );
                  }
                  ),
              );
            }
            }
          ) :
          Center(child: Container(child: Text("Нет подключения к интернету"),))
      //     ListView(
      //       children: [
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //       ],
      //     ),
      //     ListView(
      //       children: [
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //         PersonalStatementItem(),
      //       ],
      //     )
      // ],
     // ),
      ),
      
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 18, 21, 27),
        title: 
        // Padding(
        //   padding: const EdgeInsets.only(top: 18.0),
        //   child: 
         Center(
             child: 
            Text(
              'Ведомость',
              // style: TextStyle(
              //   //color: myblue,
              //   fontSize: 25,
              //   fontWeight: FontWeight.bold,
              //   ),
            ),
           ),
        // ),
        // actions: [
        //   TextButton(
        //     onPressed: (){
        //       setState(() {
        //         semNumber = semNumber == 1 ? 2 : 1;
        //       });
        //     }, 
        //     child: Text(semNumber == 1 ? '1' : '2')
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight - 10),
          child: Container(
          //color: Color.fromARGB(255, 18, 21, 27),
          child: DropdownButton<String>(
            iconEnabledColor: Colors.white,
            
            dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
            value: semNumber == 1 ? 'Осень' : 'Весна',
            items: <String>['Весна', 'Осень'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontSize: 20
                ),),
              );
            }).toList(),
            onChanged: (_sem) {
              setState(() {
                semNumber = _sem == 'Осень' ? 1 : 2;
              });
            },
          ),
          // child: TabBar(
          //   //labelColor: Colors.white,
          //   indicatorColor: myblue,
          //   controller: _tabController,
          //   // ignore: prefer_const_literals_to_create_immutables
          //   tabs: <Widget>[
          //     // ignore: prefer_const_constructors
          //     Tab(
          //       child: const Text(
          //         'Общая',
          //         textScaleFactor: 1.3,
          //         style: TextStyle(
          //           color: Color.fromARGB(255, 196, 196, 196),
          //         ),
          //       ),
          //     ),
          //     // ignore: prefer_const_constructors
          //     Tab(
          //       child:const Text(
          //         'Личная',
          //         textScaleFactor: 1.3,
          //         style: TextStyle(
          //           color: Color.fromARGB(255, 196, 196, 196),
          //         ),
          //       ),
          //     ),
          //     // ignore: prefer_const_constructors
          //     Tab(
          //       child:const Text(
          //         'Зачетка',
          //         textScaleFactor: 1.3,
          //         style: TextStyle(
          //           color: Color.fromARGB(255, 196, 196, 196),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          )
        ),
      ),
    );
  }

}
class CommonStatement {
  const CommonStatement({
    required this.disciplineName,
    required this.disciplineType,
    required this.id,
    required this.color,
  });

  final String disciplineName;
  final String disciplineType;
  final String id;
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
    return other is CommonStatement && other.disciplineType == disciplineType && other.disciplineName == disciplineName;
  }

  @override
  int get hashCode => Object.hash(disciplineName, disciplineType);
}