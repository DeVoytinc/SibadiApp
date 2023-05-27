import 'package:flutter/material.dart';
import 'package:untitled1/Settings/StatementSettings.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';

import '../logic/ConnetionCheck.dart';
import '../logic/StatementParser.dart';
import 'PersonalStateMent.dart';
import 'commonStatementScreen.dart';

String groupLink = selectedGroup.link;
String zachetkaNumber = selectedZachetka.kod;

class TopTabBarStatement extends StatefulWidget{
  TopTabBarStatement({Key? key}) : super(key: key);

  @override
  _TopTabBarStatementState createState() => _TopTabBarStatementState();
}

class _TopTabBarStatementState extends State<TopTabBarStatement> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  int semNumber = DateTime.now().month > 6 ? 1 : 2;
  StatementParser statementParser = StatementParser();

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
    statementParser.init(context, semNumber);
    //statementParser.init();
    _tabController = TabController(length: 2, vsync: this);
    //getData();
  }
  
  

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    statementParser.disciplines.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child: TabBarView(
           controller: _tabController,
           children: [
            isConnected ? 
            FutureBuilder(
              future: statementParser.getListOfDisciplines(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  return Container(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: statementParser.disciplines.length,
                      itemBuilder: (BuildContext context, int index){
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: (() => goToNextPage(context, statementParser.disciplines[index])),
                                
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
                                                  statementParser.disciplines[index].disciplineName,
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
                                                    color: statementParser.disciplines[index].color),
                                                  child: Center(
                                                    child: Text(
                                                      statementParser.disciplines[index].disciplineType,
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
              )
              : Center(child: Container(child: Text("Нет подключения к интернету"),)),
              //Container(),
              FutureBuilder(
                future: statementParser.getPersonalData(),
                builder: (context, AsyncSnapshot snapshot){
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: statementParser.personalStatement.length,
                      itemBuilder: (BuildContext context, int index){
                        return PersonalStatementItem( inputdata: statementParser.personalStatement[index],);
                      }
                    );
                  }
                }
              )
              
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
       ],
      ),
      ),
      
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 18, 21, 27),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
            //color: Colors.white,
            child: TabBar(
              
              indicatorColor: Colors.blue,
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Общая',
                    style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: 20,
                    ),
                    //textScaleFactor: 1.3,
                  ),
                ),
                Tab(
                  child: Text(
                    'Личная',
                    style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                // Tab(
                //   child: Text(
                //     'Долги',
                //     style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(icon: Icon(Icons.settings_rounded), onPressed: (){Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => StatementSettings())
                  ),
              ); },),
            ),
          ),
          Expanded(
            child: Center(
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
                      fontSize: 23
                    ),),
                  );
                }).toList(),
                onChanged: (_sem) {
                  setState(() {
                    semNumber = _sem == 'Осень' ? 1 : 2;
                    statementParser.semNumber = semNumber;
                    print(statementParser.semNumber);
                  });
                },
              ),
              ),
            ),
          ),
          Expanded(child: Container()),
        

        ],)
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