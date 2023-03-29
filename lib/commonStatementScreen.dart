
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:untitled1/elemensts/discipMarks.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/statement.dart';
import 'package:http/http.dart' as http;
import 'package:windows1251/windows1251.dart';

class CommonStatementScreen extends StatefulWidget {
  const CommonStatementScreen({super.key, required this.inputdata,});
  
  final CommonStatement inputdata;

  @override
  State<CommonStatementScreen> createState() => _CommonStatementScreenState();
}

class _CommonStatementScreenState extends State<CommonStatementScreen> {
late List<DiscipStatementData>  discipdata = [];
  List<bool> asdf = [];
  bool showInfo = false;
  bool isKursash = false;

  String discipType = '';
  String teacherName= '';

getData() async {
    var client = http.Client();
    final response =
    await client.get(Uri.parse('https://umu.sibadi.org/Ved/Ved.aspx?id=${widget.inputdata.id}'));
    
    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var zachetkatable = document.getElementById('ctl00_MainContent_ucVedBox_TableVedFixed_DXMainTable');
      var markstable = document.getElementById('ctl00_MainContent_ucVedBox_TableVed_DXMainTable');
      discipType = windows1251.decode(document.getElementById('ctl00_MainContent_ucVedBox_lblTypeVed')!.text.codeUnits);
      teacherName = windows1251.decode(document.getElementById('ctl00_MainContent_ucVedBox_lblPrep')!.text.codeUnits);
      int itemcount = zachetkatable!.nodes[1].nodes.length;
      asdf = List.generate(itemcount, (index) => false);
      if (discipType == 'Курсовой проект' || discipType == 'Курсовая работа'){
        setState(() {
          isKursash = true;
        });
        for(int i = 1; i < zachetkatable.nodes[1].nodes.length-1; i++){
          discipdata.add(DiscipStatementData(
            number: zachetkatable.nodes[1].nodes[i].nodes[1].text ?? '', 
            zachetka: windows1251.decode(zachetkatable.nodes[1].nodes[i].nodes[2].text!.codeUnits), 
            result: windows1251.decode(markstable!.nodes[1].nodes[i+2].nodes[2].text!.codeUnits), 
            marksKT1: null, marksKT2: null, 
            discType: discipType,
            teacherName: teacherName,
            )
          );
        }
      }
      else{
        for(int i = 1; i < zachetkatable.nodes[1].nodes.length-1; i++){
          KontrolPoint kt1 = KontrolPoint(
            lection: markstable!.nodes[1].nodes[i+2].nodes[1].text.toString(), 
            practic: markstable.nodes[1].nodes[i+2].nodes[2].text.toString(), 
            lab: markstable.nodes[1].nodes[i+2].nodes[3].text.toString(), 
            other: markstable.nodes[1].nodes[i+2].nodes[4].text.toString(), 
            result: markstable.nodes[1].nodes[i+2].nodes[5].text.toString()
          );
          KontrolPoint kt2 = KontrolPoint(
            lection: markstable.nodes[1].nodes[i+2].nodes[6].text.toString(), 
            practic: markstable.nodes[1].nodes[i+2].nodes[7].text.toString(), 
            lab: markstable.nodes[1].nodes[i+2].nodes[8].text.toString(), 
            other: markstable.nodes[1].nodes[i+2].nodes[9].text.toString(), 
            result: markstable.nodes[1].nodes[i+2].nodes[10].text.toString()
          );
          discipdata.add(DiscipStatementData(
            number: zachetkatable.nodes[1].nodes[i].nodes[1].text ?? '', 
            zachetka: windows1251.decode(zachetkatable.nodes[1].nodes[i].nodes[2].text!.codeUnits), 
            marksKT1: kt1, 
            marksKT2: kt2, 
            result: markstable.nodes[1].nodes[i+2].nodes[12].text.toString(),
            discType: discipType,
            teacherName: teacherName,
            ));
        }

      }
      //print(itemcount);
      return discipdata;
      }
      //disciplines.add('хуй');    
    return discipdata;
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
  String dropdownValue = list.first;
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
            future: discipdata.isNotEmpty ? null : getData(),
            builder: (context, AsyncSnapshot snapshot){
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: discipdata.length,
                  itemBuilder: (BuildContext context, int index){
                    // Color colorForMark;
                    // if(result == null){
                    //   colorForMark = result >= 90 ? mygreenDark :
                    //     result >= 75 ? Colors.orange :
                    //     result >= 50 ? Color.fromARGB(255, 214, 195, 18) :
                    //     myredDark;
                    // }
                    // else{
                    //   colorForMark = result >= 90 ? mygreenDark :
                    //     result >= 75 ? Colors.orange :
                    //     result >= 50 ? Color.fromARGB(255, 214, 195, 18) :
                    //     myredDark;
                    // }
                  if (discipType == 'Курсовой проект' || discipType == 'Курсовая работа'){
                    return Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15), 
                                    bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                                child: Center(child: Text(discipdata[index].number)),
                              )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 8,
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15), 
                                        bottomRight: Radius.circular(asdf[index] ? 0 : 15.0),
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(asdf[index] ? 0 : 15.0),
                                      ), 
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Center(child: Text(discipdata[index].zachetka))),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            //color: Theme.of(context).,
                                            decoration: BoxDecoration(
                                              color: discipdata[index].result == 'Отл' ? Theme.of(context).colorScheme.tertiary :
                                              discipdata[index].result == 'Хор' ? Theme.of(context).colorScheme.background : 
                                              discipdata[index].result == 'Удв' ? Theme.of(context).colorScheme.surface :
                                              Theme.of(context).colorScheme.scrim,
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                            ),
                                            child: Center(child: Text(discipdata[index].result)))),
                                      ]
                                    ),
                                  ),
                                  index == discipdata.length - 1 ? SizedBox(height: 200,) : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                    ///////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////
                    ///////////////////////////////////////////////////////////
                    else{
                      int? result = int.parse(discipdata[index].result == '' ? '-1' : discipdata[index].result);
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15), 
                                    bottomRight: Radius.circular(15),
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                  ),
                                ),
                                child: Center(child: Text(discipdata[index].number)),
                              )
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 8,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  asdf[index] = !asdf[index];
                                }),
                                child: Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                      //height: asdf ? 100.0 : 50.0,
                                      height: 50,
                                      //color: Theme.of(context).canvasColor,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                          borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15), 
                                          bottomRight: Radius.circular(asdf[index] ? 0 : 15.0),
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(asdf[index] ? 0 : 15.0),
                                        ),
                                      ),
                                      
                                      //duration: Duration(milliseconds: 400),
                  
                                      // 5 - 90 и больше
                                      // 4 - 75 и больше
                                      // 3 - 50 и больше
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Center(child: Text(discipdata[index].zachetka))),
                                          Expanded(
                                            flex: 2,
                                            child: Center(child: Text(discipdata[index].marksKT1!.result.toString()))),
                                          Expanded(
                                            flex: 2,
                                            child: Center(child: Text(discipdata[index].marksKT2!.result.toString()))),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: 
                                                
                                                  result >= 90 ? Theme.of(context).colorScheme.tertiary :
                                                  result >= 75 ? Theme.of(context).colorScheme.surface :
                                                  result >= 50 ? Theme.of(context).colorScheme.background :
                                                  Theme.of(context).colorScheme.scrim,
                                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                              ),
                                              child: Center(child: Text(discipdata[index].result, style: TextStyle(color: Colors.white),)))),
                                        ]
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                      height: asdf[index] ? 140.0 : 0,
                                      //color: Theme.of(context).canvasColor,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(asdf[index] ? 15 : 0), 
                                          topRight: Radius.circular(asdf[index] ? 0 : 15),
                                          bottomLeft: Radius.circular(asdf[index] ? 15 : 0),
                                          topLeft: Radius.circular(asdf[index] ? 0 : 15),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          AnimatedPadding(
                                            duration: Duration(milliseconds: 700),
                                            curve: Curves.ease,
                                            padding: asdf[index] ? 
                                              EdgeInsets.symmetric(horizontal: 10) :
                                              EdgeInsets.symmetric(horizontal: 350),
                                            child: Container(
                                              color: Theme.of(context).dividerColor,
                                              height: 1,
                                            ),
                                          ),
                                          KTmarks(index, 'лек.', 
                                            discipdata[index].marksKT1!.lection, 
                                            discipdata[index].marksKT2!.lection
                                          ),
                                          AnimatedPadding(
                                            duration: Duration(milliseconds: 700),
                                            curve: Curves.ease,
                                            padding: asdf[index] ? 
                                              EdgeInsets.symmetric(horizontal: 10) :
                                              EdgeInsets.symmetric(horizontal: 350),
                                            child: Container(
                                              color: Theme.of(context).dividerColor,
                                              height: 1,
                                            ),
                                          ),
                                          KTmarks(index, 'пр.', 
                                            discipdata[index].marksKT1!.practic, 
                                            discipdata[index].marksKT2!.practic
                                          ),
                                          AnimatedPadding(
                                            duration: Duration(milliseconds: 700),
                                            curve: Curves.ease,
                                            padding: asdf[index] ? 
                                              EdgeInsets.symmetric(horizontal: 10) :
                                              EdgeInsets.symmetric(horizontal: 350),
                                            child: Container(
                                              color: Theme.of(context).dividerColor,
                                              height: 1,
                                            ),
                                          ),
                                          KTmarks(index, 'лаб.', 
                                            discipdata[index].marksKT1!.lab, 
                                            discipdata[index].marksKT2!.lab
                                          ),
                                          AnimatedPadding(
                                            duration: Duration(milliseconds: 700),
                                            curve: Curves.ease,
                                            padding: asdf[index] ? 
                                              EdgeInsets.symmetric(horizontal: 10) :
                                              EdgeInsets.symmetric(horizontal: 350),
                                            child: Container(
                                              color: Theme.of(context).dividerColor,
                                              height: 1,
                                            ),
                                          ),
                                          KTmarks(index, 'др.', 
                                            discipdata[index].marksKT1!.other, 
                                            discipdata[index].marksKT2!.other
                                          ),
                                          //SizedBox(height: 10,)
                                        ]
                                      ),
                            
                                    ),
                                    index == discipdata.length - 1 ? SizedBox(height: 200,) : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    
                      
                    }
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