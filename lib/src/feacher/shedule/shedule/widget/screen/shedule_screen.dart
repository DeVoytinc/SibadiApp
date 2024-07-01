import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/elemensts/timetableElement.dart';
import 'package:untitled1/logic/ConnetionCheck.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/screens/choose_group.dart';
import 'package:untitled1/src/core/widget/horizontal_calendar/horizontal_calendar.dart';
import 'package:untitled1/src/feacher/shedule/choose_shedule/widget/screen/choose_shedule_screen.dart';
import 'package:untitled1/src/feacher/shedule/getAudsInRaspisanie.dart';
import 'package:untitled1/src/feacher/shedule/shedule/model/lesson.dart';
import 'package:untitled1/src/feacher/shedule/shedule/widget/component/shimmer_shedule.dart';

String groupLink = selectedGroup.link;
BaseList selectedRaspis = BaseList(
  name: selectedGroup.name,
  id: int.parse(selectedGroup.link),
  tabIndex: 0,
);
String? raspisjson = '';
bool newrasp = false;
List<BaseList> savedRaspis = [selectedRaspis];
Map<DateTime, List<Lesson>> raspPerDate = {};

List<String> urls = [
  'https://umu.sibadi.org/api/Rasp?idGroup=',
  'https://umu.sibadi.org/api/Rasp?idAudLine=',
  'https://umu.sibadi.org/api/Rasp?idTeacher=',
];

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable>
    with SingleTickerProviderStateMixin {
  late Future<dynamic> getdataofraspisanieFunc;

  List<IconData> dropdownIcons = [
    Icons.groups,
    Icons.apartment,
    Icons.school,
  ];

  List<Lesson> raspisanie = <Lesson>[];
  DateTime threeMonthAgo = DateTime.now().subtract(const Duration(days: 90));
  bool raspisIsLoad = false;

  Future<Map<DateTime, List<Lesson>>> getData() async {
    isConnected = await CheckConnection();
    raspisanie.clear();
    raspisjson = await getRaspisanie();
    Duration durationfromlastsave;
    if (dateFromLastSave != null) {
      durationfromlastsave = DateTime.now().difference(dateFromLastSave!);
    } else {
      durationfromlastsave = Duration.zero;
    }
    if ((durationfromlastsave < const Duration(hours: 12) &&
            raspisjson != null) &&
        newrasp == true) {
      getSheduleFromJson(raspisjson!);
    }
    if (isConnected) {
      final Uri uri = Uri.parse(
        urls[selectedRaspis.tabIndex] + selectedRaspis.id.toString(),
      );
      final response = await http.Client().get(uri);
      if (response.statusCode == 200) {
        newrasp = true;
        raspisjson = response.body;
        await setRaspisanie(response.body, DateTime.now());
        getSheduleFromJson(raspisjson!);
      } else {
        getSheduleFromJson(raspisjson!);
      }
    }
    return raspPerDate;
  }

  Map<DateTime, List<Lesson>> getSheduleFromJson(String json){
    final jsonmap = jsonDecode(json);
        final rasplist = jsonmap['data']['rasp'] as List;
        for (int i = 0; i < rasplist.length; i++) {
          raspisanie.add(Lesson.fromJson(rasplist[i] as Map<String, dynamic>));
        }
        final firstIndexForRasp = raspisanie.indexOf(
          raspisanie.firstWhere(
            (element) => DateTime.parse(element.date).isAfter(threeMonthAgo),
          ),
        );
        for (int j = firstIndexForRasp; j < raspisanie.length; j++) {
          raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie
              .where((element) => element.date == raspisanie[j].date)
              .toList();
        }
        return raspPerDate;
  }

  void _changeSelectedRaspisanie(BaseList base) {
    setState(() {
      selectedRaspis = base;
      newrasp = false;
      raspPerDate.clear();
      getdataofraspisanieFunc = getData();
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    getdataofraspisanieFunc = getData();
  }

  Widget timeTableLessonElement(DateTime date, int listindex) => Container(
        margin: const EdgeInsets.all(10),
        child: IntrinsicHeight(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).canvasColor,
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 15,
                right: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    raspPerDate[date]![listindex].disciplineName,
                    style: const TextStyle(
                      fontSize: 18,
                      //color: Colors.black,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    '${raspPerDate[date]![listindex].lessonType}, ${selectedRaspis.tabIndex == 2 ? raspPerDate[date]![listindex].groupname : raspPerDate[date]![listindex].teacherName}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.left,
                    selectedRaspis.tabIndex == 1
                        ? raspPerDate[date]![listindex].groupname
                        : raspPerDate[date]![listindex].auditory,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (savedRaspis.isEmpty) {
      savedRaspis.add(selectedRaspis);
    }

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: getdataofraspisanieFunc,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Expanded(
                    child: ShimmerShedule(),
                  );
                default:
                  return Expanded(
                    child: HorizontalCalendar(
                      itemBuilder: (BuildContext context, DateTime date) {
                        if (!raspPerDate.containsKey(date)) {
                          return Center(
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                if (isConnected)
                                  Lottie.network(
                                    'https://assets4.lottiefiles.com/packages/lf20_uk2qyv3i.json',
                                    height: 300,
                                  )
                                else
                                  Container(),
                                const Text('Пар нет, отдыхай!'),
                                Expanded(child: Container()),
                              ],
                            ),
                          );
                        }
                        return AnimationLimiter(
                          child: ListView.builder(
                            itemCount: raspPerDate[date]?.length,
                            itemBuilder: (
                              BuildContext context,
                              int listindex,
                            ) {
                              Widget timeElement;
                              if (listindex == 0 ||
                                  (listindex > 0 &&
                                      raspPerDate[date]?[listindex - 1]
                                              .startTime !=
                                          raspPerDate[date]![listindex]
                                              .startTime)) {
                                timeElement = TimetableTimeElement(
                                  timeLesson:
                                      '${raspPerDate[date]![listindex].startTime} - ${raspPerDate[date]![listindex].finishTime}',
                                  lessonNumber: raspPerDate[date]![listindex]
                                      .lessonNumber,
                                  color: raspPerDate[date]![listindex].color,
                                );
                              } else {
                                timeElement = Container();
                              }
                              if (!raspisIsLoad) {
                                return Column(
                                  children: [
                                    animItem(
                                      timeElement,
                                      listindex,
                                    ),
                                    animItem(
                                      timeTableLessonElement(
                                        date,
                                        listindex,
                                      ),
                                      listindex,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    timeElement,
                                    timeTableLessonElement(
                                      date,
                                      listindex,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              alignment: AlignmentDirectional.center,
              hint: Row(
                children: [
                  Text(
                    selectedRaspis.name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
              icon: const SizedBox(),
              underline: const SizedBox(),
              isDense: true,
              items: List.generate(savedRaspis.length + 1, (int index) {
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
                        Icon(dropdownIcons[savedRaspis[index].tabIndex]),
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
                        Icon(Icons.search),
                      ],
                    ),
                  );
                }
              }),
              onChanged: (Object? value) {
                if (value == 'search') {
                  Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (context) => ChooseRaspisanie(
                        funct: _changeSelectedRaspisanie,
                      ),
                    ),
                  );
                } else {
                  if (value == selectedGroup.link) {
                    selectedRaspis = savedRaspis[int.parse(value.toString())];
                  }
                  _changeSelectedRaspisanie(
                    savedRaspis[int.parse(value.toString())],
                  );
                }
              },
            ),
            // Text(
            //   DateFormat.MMMM('RU')
            //       .format(indexesWithDate[selectedIndex])
            //       .capitalize(),
            //   style: const TextStyle(
            //     fontSize: 25,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget animItem(Widget child, int index) =>
    AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        horizontalOffset: 30,
        verticalOffset: 300.0,
        child: FlipAnimation(
          duration: const Duration(milliseconds: 3000),
          curve: Curves.fastLinearToSlowEaseIn,
          flipAxis: FlipAxis.y,
          child: child,
        ),
      ),
    );

extension StringExtension on String {
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}
