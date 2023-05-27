import 'package:flutter/material.dart';
//import 'package:intl/date_symbol_data_file.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:untitled1/Raspisanie/ChooseRaspisanie.dart';
import 'package:untitled1/Raspisanie/ShimmerRaspisanie.dart';
import 'package:untitled1/Raspisanie/getAudsInRaspisanie.dart';
import 'dart:convert';
import 'raspisanieDay.dart';
import '../logic/ConnetionCheck.dart';
import '../main.dart';
import '../screens/choose_group.dart';
import '../elemensts/timetableElement.dart';
import '../elemensts/lesson.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String groupLink = selectedGroup.link;
BaseList selectedRaspis = BaseList(
    name: selectedGroup.name, id: int.parse(selectedGroup.link), tabIndex: 0);
//int idForRasp = int.parse(selectedGroup.link);
//String nameofCurRaspis = selectedGroup.name;
String? raspisjson = '';
//bool isConnected = false;
bool newrasp = false;
//int tabIndex = 0;
List<BaseList> savedRaspis = [selectedRaspis];
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

class TimeTable extends StatefulWidget {
  TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable>
    with SingleTickerProviderStateMixin {
  late Future getdataofraspisanieFunc;

  List<IconData> dropdownIcons = [
    Icons.groups,
    Icons.apartment,
    Icons.school,
  ];

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
  List<DateTime> indexesWithDate = [];
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
  bool raspisIsLoad = false;

  getData() async {
    // if (raspPerDate.isNotEmpty){
    //   return raspPerDate;
    // }
    isConnected = await CheckConnection();
    selectedIndex = indexesWithDate.indexOf(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
    raspController =
        PageController(viewportFraction: 1, initialPage: selectedIndex);
    previousRaspIndex = selectedIndex;
    raspisanie.clear();
    raspisjson = await getRaspisanie();
    Duration durationfromlastsave;
    if (dateFromLastSave != null){
      durationfromlastsave = DateTime.now().difference(dateFromLastSave!);
    }
    else{
      durationfromlastsave = Duration.zero;
    }
    if ((durationfromlastsave < Duration(hours: 12) && raspisjson!.isNotEmpty) || newrasp == true) {
      final jsonmap = jsonDecode(raspisjson!);
      var rasplist = jsonmap['data']['rasp'];
      for (int i = 0; i < rasplist.length; i++) {
        raspisanie.add(Lesson.fromJson(rasplist[i]));
      }
      var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere(
          (element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
      for (int j = firstIndexForRasp; j < raspisanie.length; j++) {
        raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie
            .where((element) => element.date == raspisanie[j].date)
            .toList();
      }
      return raspPerDate;
    }
    if (isConnected) {
      Uri uri = Uri.parse(
          urls[selectedRaspis.tabIndex] + selectedRaspis.id.toString());
      final response = await http.Client().get(uri);
      if (response.statusCode == 200) {
        newrasp = true;
        raspisjson = response.body;
        setRaspisanie(response.body, DateTime.now());
        final jsonmap = jsonDecode(raspisjson!);
        var rasplist = jsonmap['data']['rasp'];
        //var firstIndex = Lesson.fromJson(rasplist).
        for (int i = 0; i < rasplist.length; i++) {
          raspisanie.add(Lesson.fromJson(rasplist[i]));
        }
        var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere(
            (element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
        for (int j = firstIndexForRasp; j < raspisanie.length; j++) {
          raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie
              .where((element) => element.date == raspisanie[j].date)
              .toList();
        }
      } else {
        final jsonmap = jsonDecode(raspisjson!);
        var rasplist = jsonmap['data']['rasp'];
        //var firstIndex = Lesson.fromJson(rasplist).
        for (int i = 0; i < rasplist.length; i++) {
          raspisanie.add(Lesson.fromJson(rasplist[i]));
        }
        var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere(
            (element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
        for (int j = firstIndexForRasp; j < raspisanie.length; j++) {
          raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie
              .where((element) => element.date == raspisanie[j].date)
              .toList();
        }
      }
    }
    return raspPerDate;
  }

  void changeSortTabIndex(int i) {
    setState(() {
      //tabIndex = i;
      //getListInRaspisanie(urlsForSort[tabIndex]);
      //raspPerDate.clear();
    });
  }

  void _changeSelectedRaspisanie(BaseList base) {
    setState(() {
      selectedRaspis = base;
      newrasp = false;
      raspPerDate.clear();
      getdataofraspisanieFunc = getData();
      //tabIndex = tab;
    });
  }

  void _changeSelectedIndex(int i) {
    raspisIsLoad = true;
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
    initializeDateFormatting();
    getdataofraspisanieFunc = getData();
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
      height: 70,
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
                                          (selectedRaspis.tabIndex == 2
                                              ? raspPerDate[date]![listindex]
                                                  .groupname
                                              : raspPerDate[date]![listindex]
                                                  .teacherName),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white60,
                                      )),
                                  Text(
                                      textAlign: TextAlign.left,
                                      selectedRaspis.tabIndex == 1
                                          ? raspPerDate[date]![listindex]
                                              .groupname
                                          : raspPerDate[date]![listindex]
                                              .auditory,
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
    if (savedRaspis.isEmpty) {
      savedRaspis.add(selectedRaspis);
    }

    int count = threeMonthBefore.difference(threeMonthAgo).inDays;
    indexesWithDate = List.generate(
        count, (index) => threeMonthAgo.add(Duration(days: index)));

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
                future: getdataofraspisanieFunc,
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Expanded(
                        child: ShimmerRaspisanie(),
                      );
                    default:
                      return Expanded(
                        child: Column(
                          children: [
                            HorizontalCalendar(),
                            Expanded(
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                      child: AnimationLimiter(
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                raspPerDate[date]?.length,
                                            itemBuilder: (BuildContext context,
                                                int listindex) {
                                              Widget timeElement;
                                              if (listindex == 0 ||
                                                  (listindex > 0 &&
                                                      raspPerDate[date]?[
                                                                  listindex - 1]
                                                              .startTime !=
                                                          raspPerDate[date]![
                                                                  listindex]
                                                              .startTime)) {
                                                timeElement =
                                                    TimetableTimeElement(
                                                  timeLesson: raspPerDate[
                                                              date]![listindex]
                                                          .startTime +
                                                      ' - ' +
                                                      raspPerDate[date]![
                                                              listindex]
                                                          .finishTime,
                                                  lessonNumber: raspPerDate[
                                                          date]![listindex]
                                                      .lessonNumber,
                                                  color: raspPerDate[date]![
                                                          listindex]
                                                      .color,
                                                );
                                              } else {
                                                timeElement = Container();
                                              }
                                              if (!raspisIsLoad) {
                                                return Column(children: [
                                                  animItem(
                                                      timeElement, listindex),
                                                  animItem(
                                                      TimeTableLessonElement(
                                                          date, listindex),
                                                      listindex),
                                                ]);
                                              } else {
                                                return Column(children: [
                                                  timeElement,
                                                  TimeTableLessonElement(
                                                      date, listindex),
                                                ]);
                                              }
                                            }),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    //default: return Text('Что-то пошло не так');
                  }
                }),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              //isExpanded: true,
              alignment: AlignmentDirectional.center,
              hint: Row(
                children: [
                  Text(
                    selectedRaspis.name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              ),
              icon: SizedBox(),
              underline: SizedBox(),
              isDense: true,
              items:
                List.generate(savedRaspis.length + 1, (int index) {
                if (index < savedRaspis.length) {
                  return DropdownMenuItem(
                    value: index.toString(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          savedRaspis[index].name,
                          textAlign: TextAlign.center,
                        ),
                        Icon(dropdownIcons[savedRaspis[index].tabIndex])
                      ],
                    ),
                  );
                } else {
                  return const DropdownMenuItem(
                    value: 'search',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Найти расписание',
                          textAlign: TextAlign.center,
                        ),
                        Icon(Icons.search)
                      ],
                    ),
                  );
                }
              }),
              onChanged: (Object? value) {
                if (value == 'search') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: ((context) => ChooseRaspisanie(
                              funct: _changeSelectedRaspisanie,
                            ))),
                  );
                } else {
                  if (value == selectedGroup.link) {
                    selectedRaspis = savedRaspis[int.parse(value.toString())];
                  }
                  _changeSelectedRaspisanie(
                      savedRaspis[int.parse(value.toString())]);
                }
              },
            ),
            Text(
              DateFormat.MMMM('RU').format(indexesWithDate[selectedIndex]).capitalize(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            //IconButton(onPressed: (){}, icon: Icon(Icons.date_range_outlined))
            //DatePickerDialog(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate)
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //       showDatePicker(
        //         context: context, 
        //         firstDate: indexesWithDate.first, 
        //         initialDate: indexesWithDate.last, 
        //         lastDate: indexesWithDate.last,
        //       ).then((date) => _changeSelectedIndex(indexesWithDate.indexOf(date!)));
        //     }, 
        //     icon: Icon(Icons.date_range_outlined)),
        // ],
      ),
    );
  }
}

Widget animItem(Widget child, int index) {
  //double _w = MediaQuery.of(context).size.width;
  return AnimationConfiguration.staggeredList(
    position: index,
    delay: Duration(milliseconds: 100),
    child: SlideAnimation(
      duration: Duration(milliseconds: 2500),
      curve: Curves.fastLinearToSlowEaseIn,
      horizontalOffset: 30,
      verticalOffset: 300.0,
      child: FlipAnimation(
        duration: Duration(milliseconds: 3000),
        curve: Curves.fastLinearToSlowEaseIn,
        flipAxis: FlipAxis.y,
        child: child,
      ),
    ),
  );
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}