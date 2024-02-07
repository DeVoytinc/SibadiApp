import 'package:flutter/material.dart';
import 'package:untitled1/elemensts/discipMarks.dart';
import 'package:untitled1/logic/StatementParser.dart';
import 'package:untitled1/src/feacher/progress_report/model/general_report_card_model.dart';
import 'package:untitled1/src/feacher/progress_report/widget/component/general_report_card_item.dart';

class CommonStatementScreen extends StatefulWidget {
  const CommonStatementScreen({
    required this.inputdata,
    super.key,
  });

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
  String teacherName = '';
  StatementParser statementParser = StatementParser();

  late Future<List<DiscipStatementData>> _getGroupData;

  @override
  void initState() {
    super.initState();
    //statementParser.init(context, 2);
    _getGroupData = getGroupData();
  }

  Future<List<DiscipStatementData>> getGroupData() async =>
      statementParser.getGroupData(widget.inputdata);

  Widget ktMarks(int index, String text, String mark1, String mark2) =>
      Expanded(
        child: Row(
          children: [
            Expanded(flex: 20, child: Center(child: Text(text))),
            Expanded(flex: 13, child: Center(child: Text(mark1))),
            Expanded(flex: 13, child: Center(child: Text(mark2))),
            Expanded(flex: 13, child: Container()),
          ],
        ),
      );

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.inputdata.disciplineName,
          ),
          actions: [
            IconButton(
              onPressed: () => setState(() {
                showInfo = !showInfo;
              }),
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        body: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              height: showInfo ? 150 : 0,
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Кафедра"),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Цифровые технологии"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Преподаватель"),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(teacherName),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Тип"),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(discipType),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Дата экзамена"),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("13.02.2023"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              color: Theme.of(context).canvasColor,
              child: isKursash
                  ? const Row(
                      children: [
                        Expanded(child: Center(child: Text('№'))),
                        Expanded(
                          flex: 4,
                          child: Center(child: Text('Зачетка')),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Center(child: Text(' Итог')),
                          ),
                        ),
                      ],
                    )
                  : const Row(
                      children: [
                        Expanded(child: Center(child: Text('№'))),
                        Expanded(
                          flex: 3,
                          child: Center(child: Text('Зачетка')),
                        ),
                        Expanded(flex: 2, child: Center(child: Text('КТ1'))),
                        Expanded(flex: 2, child: Center(child: Text('КТ2'))),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Center(child: Text('Итог')),
                          ),
                        ),
                      ],
                    ),
            ),
            FutureBuilder(
              future: _getGroupData,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  case ConnectionState.active:
                    return const CircularProgressIndicator();
                  case ConnectionState.none:
                    return const CircularProgressIndicator();
                  case ConnectionState.done:
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CommonStatementItem(
                          inputdata: snapshot.data![index],
                        ),
                      ),
                    );
                  default:
                    return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      );
}
