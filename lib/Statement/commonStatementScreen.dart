import 'package:flutter/material.dart';
import 'package:untitled1/Statement/statement.dart';
import 'package:untitled1/logic/StatementParser.dart';

import 'commonStatementItem.dart';

class CommonStatementScreen extends StatefulWidget {
  const CommonStatementScreen({super.key, required this.inputdata,});
  
  final CommonStatement inputdata;

  @override
  State<CommonStatementScreen> createState() => _CommonStatementScreenState();
}

class _CommonStatementScreenState extends State<CommonStatementScreen> {
//late List<DiscipStatementData>  discipdata = [];
  List<bool> asdf = [];
  bool showInfo = false;
  bool isKursash = false;

  String discipType = '';
  String teacherName= '';
  StatementParser statementParser = StatementParser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statementParser.init(context, 2);
  }

  Widget KTmarks(int index, String text, String mark1, String mark2){
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 20,
            child: Center(child: Text(text))),
          Expanded(
            flex: 13,
            child: Center(child: Text(mark1))),
          Expanded(
            flex: 13,
            child: Center(child: Text(mark2))),
          Expanded(
            flex: 13, 
            child: Container()),
        ],
      )
    );
  }

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    //getData();
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          widget.inputdata.disciplineName,
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              showInfo = !showInfo;
            }),
            icon: Icon(Icons.info_outline)
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            height: showInfo ? 150 : 0,
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Кафедра"),
                      )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Цифровые технологии"),
                      )),
                ],)),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Преподаватель"),
                      )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(teacherName),
                      )),
                ],)),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Тип"),
                      )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(discipType),
                      )),
                ],)),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Дата экзамена"),
                      )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("13.02.2023"),
                      )),
                ],)),

                
              ]
            ),
          ),
          Container(
            height: 50,
            color: Theme.of(context).canvasColor,
            child: isKursash ? 
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text('№'))),
                  Expanded(
                    flex: 4,
                    child: Center(child: Text('Зачетка'))),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Center(child: Text(' Итог')),
                    )),
                ]
              ) :
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(child: Text('№'))),
                  Expanded(
                    flex: 3,
                    child: Center(child: Text('Зачетка'))),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text('КТ1'))),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text('КТ2'))),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Center(child: Text('Итог')),
                    )),
                ]
              ),
          ),
          FutureBuilder(
            future: statementParser.getGroupData(widget.inputdata),
            builder: (context, AsyncSnapshot snapshot){
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: statementParser.currentGroupStatement.length,
                  itemBuilder: (BuildContext context, int index){
                    return CommonStatementItem(inputdata: statementParser.currentGroupStatement[index]);
                    
                  }
                ),
              );
            } 
          ),
        ],
      ),
    );
  }
}