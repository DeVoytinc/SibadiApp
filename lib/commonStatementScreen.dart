
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:untitled1/elemensts/discipMarks.dart';
import 'package:untitled1/statement.dart';
import 'package:http/http.dart' as http;
import 'package:windows1251/windows1251.dart';

class CommonStatementScreen extends StatelessWidget{

late CommonStatement inputdata;
late List<DiscipStatementData>  discipdata = [];

CommonStatementScreen({
  required this.inputdata,
});

getData() async {
    var client = http.Client();
    final response =
    await client.get(Uri.parse('https://umu.sibadi.org/Ved/Ved.aspx?id=${inputdata.id}'));
    
    if (response.statusCode == 200) {
      var document = parse(response.body, encoding:'utf-8');
      var zachetkatable = document.getElementById('ctl00_MainContent_ucVedBox_TableVedFixed_DXMainTable');
      var markstable = document.getElementById('ctl00_MainContent_ucVedBox_TableVed_DXMainTable');
      //var table2 = document.getElementsByClassName('dxgvDataRow_MaterialCompact dxgvDataRowAlt_MaterialCompact');
      int itemcount = zachetkatable!.nodes[1].nodes.length-2;
      for(int i = 1; i < zachetkatable.nodes[1].nodes.length-8; i++){
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
          result: markstable.nodes[1].nodes[i+2].nodes[12].text.toString()
          ));
      }
      //print(itemcount);
      return discipdata;
      }
      //disciplines.add('хуй');    
    return discipdata;
  }

//dxgvDataRow_MaterialCompact dxgvDataRowAlt_MaterialCompact

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(inputdata.disciplineName),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: Theme.of(context).canvasColor,
            child: Row(
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
                  child: Center(child: Text('Итог'))),
              ]
            ),
          ),
          FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot){
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: discipdata.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        color: Theme.of(context).canvasColor,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(child: Text(discipdata[index].number))),
                            Expanded(
                              flex: 3,
                              child: Center(child: Text(discipdata[index].zachetka))),
                            Expanded(
                              flex: 2,
                              child: Center(child: Text(discipdata[index].marksKT1.result.toString()))),
                            Expanded(
                              flex: 2,
                              child: Center(child: Text(discipdata[index].marksKT2.result.toString()))),
                            Expanded(
                              flex: 2,
                              child: Center(child: Text(discipdata[index].result.toString()))),
                          ]
                        ),
                      ),
                    );
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