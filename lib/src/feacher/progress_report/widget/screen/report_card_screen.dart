import 'package:flutter/material.dart';
import 'package:untitled1/elemensts/discipMarks.dart';
import 'package:untitled1/logic/ConnetionCheck.dart';
import 'package:untitled1/logic/StatementParser.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/screens/choose_zachetkanumber.dart';
import 'package:untitled1/src/feacher/progress_report/model/general_report_card_model.dart';
import 'package:untitled1/src/feacher/progress_report/widget/component/general_report_cart_page.dart';
import 'package:untitled1/src/feacher/progress_report/widget/component/personal_report_card_page.dart';

String groupLink = selectedGroup.link;
String zachetkaNumber = selectedZachetka.kod;

class TopTabBarStatement extends StatefulWidget {
  const TopTabBarStatement({super.key});

  @override
  _TopTabBarStatementState createState() => _TopTabBarStatementState();
}

class _TopTabBarStatementState extends State<TopTabBarStatement>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int semNumber = DateTime.now().month > 6 ? 1 : 2;
  StatementParser statementParser = StatementParser();

  late Future<dynamic> getPersonalData;

  Future<List<DiscipStatementData>> getGroup() async =>
      statementParser.getPersonalData();

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  void goToNextPage(BuildContext context, CommonStatement discip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            CommonStatementScreen(inputdata: discip),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    statementParser.init(context, semNumber);
    //statementParser.init();
    getPersonalData = getGroup();
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
  Widget build(BuildContext context) => Scaffold(
        body: TabBarView(
          controller: _tabController,
          children: [
            if (isConnected)
              FutureBuilder(
                future: statementParser.getListOfDisciplines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (statementParser.disciplines.isEmpty) {
                      return const Center(
                        child: Text('Ведомости пока нет'),
                      );
                    } else if (selectedZachetka.kod == '?' &&
                        selectedZachetka.name == '?') {
                      return Center(
                        child: Column(
                          children: [
                            const Text(
                              'Выбери номер своей зачетки чтобы ведомость появилась',
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<dynamic>(
                                    builder: (BuildContext context) =>
                                        ChooseZachetca(),
                                  ),
                                );
                              },
                              child: const Text('Выбрать зачетку'),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: statementParser.disciplines.length,
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => goToNextPage(
                                context,
                                statementParser.disciplines[index],
                              ),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 180, 180, 180),
                                  //color: disciplines[index].color,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Text(
                                                statementParser
                                                    .disciplines[index]
                                                    .disciplineName,
                                                style: const TextStyle(
                                                  fontSize: 18,
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
                                                color: statementParser
                                                    .disciplines[index].color,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  statementParser
                                                      .disciplines[index]
                                                      .disciplineType,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromARGB(
                                                      255,
                                                      255,
                                                      255,
                                                      255,
                                                    ),
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
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            else
              const Center(
                child: Text("Нет подключения к интернету"),
              ),
            // Container(),
            FutureBuilder(
              future: getPersonalData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: statementParser.personalStatement.length,
                    itemBuilder: (BuildContext context, int index) =>
                        PersonalStatementItem(
                      inputdata: statementParser.personalStatement[index],
                    ),
                  );
                }
              },
            ),
          ],
        ),
        appBar: AppBar(
          //backgroundColor: Color.fromARGB(255, 18, 21, 27),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: TabBar(
              indicatorColor: Colors.blue,
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Общая',
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                              fontSize: 20,
                            ),
                    //textScaleFactor: 1.3,
                  ),
                ),
                Tab(
                  child: Text(
                    'Личная',
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                              fontSize: 20,
                            ),
                  ),
                ),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: DropdownButton<String>(
                    iconEnabledColor: Colors.white,
                    dropdownColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    value: semNumber == 1 ? 'Осень' : 'Весна',
                    items: <String>['Весна', 'Осень']
                        .map(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle
                                  ?.copyWith(fontSize: 23),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (_sem) {
                      setState(() {
                        semNumber = _sem == 'Осень' ? 1 : 2;
                        statementParser.semNumber = semNumber;
                      });
                    },
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      );
}
