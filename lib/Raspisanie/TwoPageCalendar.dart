import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'raspisanieDay.dart';
import '../screens/choose_group.dart';
import '../elemensts/timetableElement.dart';
import '../elemensts/lesson.dart';
import 'ShimmerRaspisanie.dart';

String groupLink = selectedGroup.link;
int idForRasp = int.parse(selectedGroup.link);
String nameofCurRaspis = selectedGroup.name;
String? raspisjson = '';
bool isConnected = false;
bool newrasp = false;
int tabIndex = 0;
Map<DateTime, List<Lesson>> raspPerDate = Map();

List<String> urlsForSort = [
  'https://umu.sibadi.org/api/raspGrouplist',
  'https://umu.sibadi.org/api/raspAudlist',
  'https://umu.sibadi.org/api/raspTeacherlist',
];

List<String> urls = [
  'https://umu.sibadi.org/api/Rasp?idGroup=',
  'https://umu.sibadi.org/api/Rasp?idAudLine=',
  'https://umu.sibadi.org/api/Rasp?idTeacher=',
];

class TwoPageCalendar extends StatefulWidget {
  TwoPageCalendar({Key? key}) : super(key: key);

  @override
  _TwoPageCalendarState createState() => _TwoPageCalendarState();
}

class _TwoPageCalendarState extends State<TwoPageCalendar>
    with SingleTickerProviderStateMixin {
  bool opening = false;
  List<Lesson> raspisanie = <Lesson>[];
  TextEditingController customTextController = TextEditingController();
  DateTime threeMonthAgo =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(Duration(days: 13 * 7 + (DateTime.now().weekday - 1)));
  DateTime threeMonthBefore =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(Duration(days: 13 * 7 + (7 - DateTime.now().weekday)));
  DateTime curDate = DateTime.now();
  int selectedIndex = ((26 * 7) / 2).round() + DateTime.now().weekday - 1;
  List indexesWithDate = [];
  List<String> listOfDays = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  PageController daysController =
      PageController(viewportFraction: 1, initialPage: 13);
  PageController raspController = PageController(
      viewportFraction: 1,
      initialPage: ((26 * 7) / 2).round() + DateTime.now().weekday - 8);
  int daypageindex = 13;
  int previousRaspIndex = 0;
  int listpageindex = 0;
  bool userinputrasp = true;
  bool userinputcalendar = true;

  void changeSortTabIndex(int i) {
    setState(() {
      tabIndex = i;
      //getListInRaspisanie(urlsForSort[tabIndex]);
      //raspPerDate.clear();
    });
  }

  void changeRaspisID(int i) {
    setState(() {
      idForRasp = i;
      newrasp = false;
      raspPerDate.clear();
      //tabIndex = tab;
    });
  }

  void _changeSelectedIndex(int i) {
    setState(() {
      selectedIndex = i;
    });
  }

  @override
  void initState() {
    setState(() {
      //getData(selectedDate);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget RaspisanieDayConstructor(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _changeSelectedIndex(index);
          raspController.jumpToPage(index);
        },
        child: RaspisanieDay(
          daynumber: indexesWithDate[index].day,
          dayname: listOfDays[indexesWithDate[index].weekday - 1],
          index: index,
          date: indexesWithDate[index],
          selected: selectedIndex == index,
        ),
      ),
    );
  }

  Widget HorizontalCalendar() {
    return Container(
      height: 80,
      width: double.infinity,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: daysController,
        onPageChanged: (value) => setState(() {
          userinputrasp = false;
          if (value < daypageindex && userinputcalendar) {
            raspController.jumpToPage(selectedIndex - 7);
          } else if (value > daypageindex && userinputcalendar) {
            raspController.jumpToPage(selectedIndex + 7);
          }
          userinputcalendar = true;
          userinputrasp = true;
          daypageindex = value;
        }),
        itemCount: 26,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                RaspisanieDayConstructor(0 + 7 * index),
                RaspisanieDayConstructor(1 + 7 * index),
                RaspisanieDayConstructor(2 + 7 * index),
                RaspisanieDayConstructor(3 + 7 * index),
                RaspisanieDayConstructor(4 + 7 * index),
                RaspisanieDayConstructor(5 + 7 * index),
                RaspisanieDayConstructor(6 + 7 * index),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget TimeTableLessonElement(DateTime date, int listindex) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  //color: Theme.of(context).canvasColor,
                  color: raspPerDate[date]![listindex].color,
                ),
                child: IntrinsicHeight(
                  child: Container(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).canvasColor),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      raspPerDate[date]![listindex]
                                          .disciplineName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        //color: Colors.black,
                                      )),
                                  Text(
                                      textAlign: TextAlign.left,
                                      raspPerDate[date]![listindex].lessonType +
                                          ', ' +
                                          raspPerDate[date]![listindex]
                                              .teacherName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white60,
                                      )),
                                  Text(
                                      textAlign: TextAlign.left,
                                      raspPerDate[date]![listindex].auditory,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white60,
                                      )),
                                ],
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

  @override
  Widget build(BuildContext context) {
    int count = threeMonthBefore.difference(threeMonthAgo).inDays;
    indexesWithDate = List.generate(
        count, (index) => threeMonthAgo.add(Duration(days: index)));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          child: Center(
            child: Text(
              'Расписание',
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            HorizontalCalendar(),
            FutureBuilder(
                //future: raspPerDate.isEmpty ? getData() : null,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      child: ShimmerRaspisanie(),
                    );
                  } else {
                    return Expanded(
                      child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: raspController,
                          onPageChanged: (value) {
                            print(indexesWithDate[value]);
                            if (value < previousRaspIndex &&
                                previousRaspIndex % 7 == 0 &&
                                userinputrasp) {
                              userinputcalendar = false;
                              daysController.previousPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            }
                            if (value > previousRaspIndex &&
                                previousRaspIndex % 7 == 6 &&
                                userinputrasp) {
                              userinputcalendar = false;
                              daysController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            }
                            //userinputcalendar = true;
                            userinputrasp = true;
                            _changeSelectedIndex(value);
                            previousRaspIndex = value;
                          },
                          // physics: BouncingScrollPhysics(
                          //   parent: AlwaysScrollableScrollPhysics(),
                          // ),
                          itemCount: 26 * 7,
                          itemBuilder: (BuildContext context, int index) {
                            //print(indexesWithDate[index]);
                            var date = indexesWithDate[index];
                            //List<Lesson>? lesson = raspPerDate[date];
                            if (!raspPerDate.containsKey(date)) {
                              return Center(
                                  child: Column(
                                children: [
                                  Expanded(child: Container()),
                                  isConnected
                                      ? Lottie.network(
                                          'https://assets4.lottiefiles.com/packages/lf20_uk2qyv3i.json',
                                          height: 300,
                                        )
                                      : Container(),
                                  Text('Пар нет, отдыхай!'),
                                  Expanded(child: Container()),
                                ],
                              ));
                            }
                            return Container(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: raspPerDate[date]?.length,
                                  itemBuilder:
                                      (BuildContext context, int listindex) {
                                    Widget timeElement;
                                    if (listindex == 0 || (listindex > 0 && raspPerDate[date]?[listindex - 1].startTime !=
                                                raspPerDate[date]![listindex]
                                                    .startTime)) {
                                      timeElement = TimetableTimeElement(
                                        timeLesson:
                                            raspPerDate[date]![listindex]
                                                    .startTime +
                                                ' - ' +
                                                raspPerDate[date]![listindex]
                                                    .finishTime,
                                        lessonNumber:
                                            raspPerDate[date]![listindex]
                                                .lessonNumber,
                                        color:
                                            raspPerDate[date]![listindex].color,
                                      );
                                    } else {
                                      timeElement = Container();
                                    }
                                    return Column(children: [
                                      timeElement,
                                      TimeTableLessonElement(date, listindex),
                                    ]);
                                  }),
                            );
                          }),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
