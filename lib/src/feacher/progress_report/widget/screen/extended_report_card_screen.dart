import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:untitled1/src/feacher/progress_report/model/discipline_model.dart';
import 'package:windows1251/windows1251.dart';

String groupLink = selectedGroup.link;
String zachetkaNumber = selectedZachetka.kod;

class CommonStatementForDisc extends StatefulWidget {
  const CommonStatementForDisc({super.key});

  @override
  _CommonStatementForDiscState createState() => _CommonStatementForDiscState();
}

class _CommonStatementForDiscState extends State<CommonStatementForDisc>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<CommonStatement3> disciplines = <CommonStatement3>[];

  Future<List<CommonStatement3>> getData() async {
    if (disciplines.isNotEmpty) {
      return disciplines;
    }
    final client = http.Client();
    final response = await client.get(
      Uri.parse(
        'https://umu.sibadi.org/Ved/TotalVed.aspx?year=2022-2023&sem=1&id=$zachetkaNumber',
      ),
    );

    if (response.statusCode == 200) {
      final document = parse(response.body, encoding: 'utf-8');
      final table =
          document.getElementsByClassName('dxeHyperlink_MaterialCompact');
      for (int i = 0; i < table.length; i = i + 2) {
        final String type = windows1251.decode(
          table[i]
              .parentNode!
              .parentNode!
              .nodes
              .toList()[1]
              .nodes
              .toList()[0]
              .text!
              .codeUnits,
        );
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
        disciplines.add(
          CommonStatement3(
            disciplineName: windows1251.decode(table[i].text.codeUnits),
            disciplineType: type,
            color: cl,
          ),
        );
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
  Widget build(BuildContext context) => Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("loading"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: disciplines.length,
                    itemBuilder: (BuildContext context, int index) => Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: mygrey,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 7),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 10,
                                              child: Container(
                                                margin: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: Text(
                                                  disciplines[index]
                                                      .disciplineName,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12,
                                                  ),
                                                  color:
                                                      disciplines[index].color,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    disciplines[index]
                                                        .disciplineType,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(top: 18.0),
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
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                indicatorColor: myblue,
                controller: _tabController,
                tabs: const <Widget>[
                  Tab(
                    child: Text(
                      'Общая',
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Личная',
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Зачетка',
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
