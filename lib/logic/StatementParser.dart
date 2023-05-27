import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:untitled1/elemensts/discipMarks.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:windows1251/windows1251.dart';

import '../Statement/statement.dart';

class StatementParser{

  StatementParser._privateConstructor();

  static final StatementParser _instance = StatementParser._privateConstructor();

  factory StatementParser() {
    return _instance;
  }

  late BuildContext context;
  late int semNumber;
  List<CommonStatement> disciplines = <CommonStatement>[];
  List<DiscipStatementData> currentGroupStatement = [];
  List<List<DiscipStatementData>> allDataForAllDisciplines = [];
  List<DiscipStatementData> personalStatement = [];

  init(BuildContext context, int semNumber){
    this.context = context;
    this.semNumber = semNumber;
  }


  bool getListOfDisciplinesisRunning = false;

  Future<List<CommonStatement>> get _disciplines async{
    if (disciplines.isNotEmpty && disciplines.length != 0){
      return disciplines;
    }

    disciplines = await getListOfDisciplines();

    return disciplines;
  } 

  Future<List<CommonStatement>> getListOfDisciplines() async{
    // if (disciplines.isNotEmpty) {
    //   return disciplines;
    // }
    disciplines.clear();
    var client = http.Client();
    final response =
    await client.get(Uri.parse('https://umu.sibadi.org/Ved/TotalVed.aspx?year=2022-2023&sem=${semNumber.toString()}&id=${zachetkaNumber}'));
    
    List<CommonStatement> resultList = [];

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
        resultList.add(CommonStatement(
          disciplineName: windows1251.decode(table[i].text.codeUnits), 
          disciplineType: type, 
          color: cl,
          id: table[i].attributes.values.last.split('id=')[1],
          ));
      }
      //disciplines.add('хуй');
      disciplines = resultList;
      return resultList;
    }
    return resultList;
  }

  Future<List<DiscipStatementData>> getGroupData(CommonStatement commonStatement) async {
    var client = http.Client();
    final response =
    await client.get(Uri.parse('https://umu.sibadi.org/Ved/Ved.aspx?id=${commonStatement.id}'));
    
    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var zachetkatable = document.getElementById('ctl00_MainContent_ucVedBox_TableVedFixed_DXMainTable');
      var markstable = document.getElementById('ctl00_MainContent_ucVedBox_TableVed_DXMainTable');
      var discipType = windows1251.decode(document.getElementById('ctl00_MainContent_ucVedBox_lblTypeVed')!.text.codeUnits);
      var teacherName = windows1251.decode(document.getElementById('ctl00_MainContent_ucVedBox_lblPrep')!.text.codeUnits);
      //int itemcount = zachetkatable!.nodes[1].nodes.length;
      //print(itemcount);
      print(discipType);
      if (discipType == 'Курсовой проект' || discipType == 'Курсовая работа' || discipType == 'Практика'){
        for(int i = 1; i < zachetkatable!.nodes[1].nodes.length-1; i++){
          currentGroupStatement.add(DiscipStatementData(
            disciplineName: commonStatement.disciplineName,
            number: zachetkatable.nodes[1].nodes[i].nodes[1].text ?? '', 
            zachetka: windows1251.decode(zachetkatable.nodes[1].nodes[i].nodes[2].text!.codeUnits), 
            result: windows1251.decode(markstable!.nodes[1].nodes[i+1].nodes[2].text!.codeUnits), 
            //result: '90', 
            //raiting: '',
            marksKT1: null, marksKT2: null, 
            discType: discipType,
            teacherName: teacherName,
            )
          );
        }
      }
      else{
        for(int i = 1; i < zachetkatable!.nodes[1].nodes.length-1; i++){
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
          currentGroupStatement.add(DiscipStatementData(
            disciplineName: commonStatement.disciplineName,
            number: zachetkatable.nodes[1].nodes[i].nodes[1].text ?? '', 
            zachetka: windows1251.decode(zachetkatable.nodes[1].nodes[i].nodes[2].text!.codeUnits), 
            marksKT1: kt1, 
            marksKT2: kt2, 
            //raiting: markstable.nodes[1].nodes[i+2].nodes[12].text.toString(),
            result: markstable.nodes[1].nodes[i+2].nodes[12].text.toString(),
            discType: discipType,
            teacherName: teacherName,
            ));
        }

      }
      //print(itemcount);
      return currentGroupStatement;
      }
      //disciplines.add('хуй');    
    return currentGroupStatement;
  }

  //List alldiscipData = []; 
  Future<List<DiscipStatementData>> getPersonalData() async {
    allDataForAllDisciplines.clear();
    personalStatement.clear();

    var disc = await _disciplines;
    int zachetkanumber = -1;
    for (var i = 0; i < disc.length; i++) {
      var groupstatement = await getGroupData(disc[i]);
      allDataForAllDisciplines.add(groupstatement);

      if (zachetkanumber == -1){
        for (var j = 0; j < groupstatement.length; j++) {
          if (selectedZachetka.name == groupstatement[j].zachetka){
            zachetkanumber = j;
            personalStatement.add(groupstatement[j]);
            break;
          }
        }
      } else{
        if (selectedZachetka.name == groupstatement[zachetkanumber].zachetka){
          personalStatement.add(groupstatement[zachetkanumber]);
        }
        else{
          for (var j = 0; j < groupstatement.length; j++) {
          if (selectedZachetka.name == groupstatement[j].zachetka){
            zachetkanumber = j;
            personalStatement.add(groupstatement[j]);
            break;
          }
        }
        }
      }
      groupstatement.clear();
    }
    return personalStatement;
  }
  
}