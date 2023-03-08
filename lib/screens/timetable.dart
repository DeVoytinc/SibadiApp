import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../elemensts/raspisanieDay.dart';
import '../main.dart';
import '../screens/choose_group.dart';
import '../elemensts/timetableElement.dart';
import '../elemensts/lesson.dart';

import 'dart:io';


String groupLink = selectedGroup.link;
String? raspisjson = '';
bool isConnected = false;
bool newrasp = false;

class TimeTable extends StatefulWidget{
  TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with SingleTickerProviderStateMixin{

  List<Lesson> raspisanie = <Lesson>[];
  Map<DateTime, List<Lesson>> raspPerDate = Map();
  TextEditingController customTextController = TextEditingController();
  // DateTime threeMonthAgo = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).subtract(Duration(days: 13 * 7 + (7 - DateTime.now().weekday)));
  DateTime threeMonthAgo = DateTime(
    DateTime.now().year, DateTime.now().month, 
    DateTime.now().day).subtract(Duration(days: 13 * 7 + (DateTime.now().weekday - 1)));
  DateTime threeMonthBefore = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: 13 * 7 + (7 - DateTime.now().weekday)));
  //DateTime selectedDate = DateTime.now();
  DateTime curDate = DateTime.now();
  int selectedIndex = ((26 * 7) / 2).round() + DateTime.now().weekday -8;
  List indexesWithDate = [];
  List<String> listOfDays = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  PageController daysController = PageController(viewportFraction: 1, initialPage: 13);
  PageController raspController = PageController(
    viewportFraction: 1, 
    initialPage: ((26 * 7) / 2).round() + DateTime.now().weekday -8);
  int daypageindex = 13;
  int previousRaspIndex = 0;
  int listpageindex = 0;
  bool userinputrasp = true;
  bool userinputcalendar = true;

  getData() async {

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnected = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      isConnected = false;
    }

    selectedIndex = indexesWithDate.indexOf(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
    raspController = PageController(viewportFraction: 1, initialPage: selectedIndex);
    previousRaspIndex = selectedIndex;
    raspisanie.clear();
    if( (!isConnected && !raspisjson!.isEmpty) || newrasp == true){
      final jsonmap = jsonDecode(raspisjson!);
      var rasplist = jsonmap['data']['rasp'];
      //var firstIndex = Lesson.fromJson(rasplist).
      for (int i = 0; i < rasplist.length; i++){
        raspisanie.add(Lesson.fromJson(rasplist[i]));
      }
      var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere((element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
      for (int j = firstIndexForRasp; j < raspisanie.length; j++){
          raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie.where((element) => 
          element.date == raspisanie[j].date).toList();
      }
      return raspPerDate;
    }
    if (isConnected){
      String groupnumber = groupLink.replaceAll('?group=', '');
      Uri uri = Uri.parse('https://umu.sibadi.org/api/Rasp?idGroup=${groupnumber}');
      final response =
      await http.Client().get(uri);
      if (response.statusCode == 200) {
        newrasp = true;
        raspisjson = response.body;
        setRaspisanie();
        final jsonmap = jsonDecode(response.body);
        var rasplist = jsonmap['data']['rasp'];
        //var firstIndex = Lesson.fromJson(rasplist).
        for (int i = 0; i < rasplist.length; i++){
          raspisanie.add(Lesson.fromJson(rasplist[i]));
        }
        var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere((element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
        for (int j = firstIndexForRasp; j < raspisanie.length; j++){
            raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie.where((element) => 
            element.date == raspisanie[j].date).toList();
        }
      }
      else{
        final jsonmap = jsonDecode(raspisjson!);
        var rasplist = jsonmap['data']['rasp'];
        //var firstIndex = Lesson.fromJson(rasplist).
        for (int i = 0; i < rasplist.length; i++){
          raspisanie.add(Lesson.fromJson(rasplist[i]));
        }
        var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere((element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
        for (int j = firstIndexForRasp; j < raspisanie.length; j++){
            raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie.where((element) => 
            element.date == raspisanie[j].date).toList();
        }
      }

    }
    return raspPerDate;
  }


  void _changeSelectedIndex(int i){
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



  Widget RaspisanieDayConstructor(int index){
    
    //List<List<DateTime>> nowPeriod = getWeeksPeriodDate();
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

  Widget HorizontalCalendar(){
    return Container(
      height: 80,
      width: double.infinity,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: daysController,
        onPageChanged:(value) => setState(() {
          userinputrasp = false;
          if (value < daypageindex && userinputcalendar){
            //selectedIndex -= 7;
            //_changeSelectedIndex(selectedIndex - 7);
            raspController.jumpToPage(selectedIndex-7);
          }
          else if (value > daypageindex && userinputcalendar){
            //selectedIndex += 7;
            //_changeSelectedIndex(selectedIndex + 7);
            raspController.jumpToPage(selectedIndex+7);
          }
          userinputcalendar = true;
          userinputrasp = true;
          daypageindex = value;
        }
        ),
        // physics: BouncingScrollPhysics(
        //   parent: AlwaysScrollableScrollPhysics(),
        // ),
        itemCount: 26, 
        itemBuilder: (BuildContext context, int index) {  
          //tempforCreatingCalendar = tempforCreatingCalendar + 7;
          //print(index);
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

  Widget TimeTableLessonElement(DateTime date, int listindex){
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), 
                        color: Theme.of(context).canvasColor
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // raspPerDate[date]![listindex].customName != '' ? 
                                    // raspPerDate[date]![listindex].customName :
                                    raspPerDate[date]![listindex].disciplineName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      //color: Colors.black,
                                    )
                                  ),
                                  Text(
                                    textAlign: TextAlign.left,
                                    raspPerDate[date]![listindex].lessonType+ ', ' 
                                    + raspPerDate[date]![listindex].teacherName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white60,

                                    )
                                  ),
                                  Text(
                                    textAlign: TextAlign.left,
                                    raspPerDate[date]![listindex].auditory,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white60,
                                    )
                                  ),
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
    indexesWithDate = List.generate(count, (index) => threeMonthAgo.add(Duration(days: index)));
    int tempforCreatingCalendar = 0;
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.pop(context, 'Cancel');},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            HorizontalCalendar(),
            FutureBuilder(
              future: raspPerDate.isEmpty ? getData() : null,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData){
                  return Expanded(
                    child: Container(
                          child: Column(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).canvasColor,
                                highlightColor: Color.fromARGB(55, 27, 24, 36),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topRight,
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft ,
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).canvasColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).canvasColor,
                                highlightColor: Color.fromARGB(55, 27, 24, 36),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    height: 100, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).canvasColor,
                                highlightColor: Color.fromARGB(55, 27, 24, 36),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topRight,
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft ,
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).canvasColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).canvasColor,
                                highlightColor: Color.fromARGB(55, 27, 24, 36),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    height: 100, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).canvasColor,
                                highlightColor: Color.fromARGB(55, 27, 24, 36),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.topRight,
                                        width: 50,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft ,
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).canvasColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Theme.of(context).canvasColor,
                                highlightColor: Color.fromARGB(55, 27, 24, 36),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    height: 100, 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ),
                  );
                }
                else {
                  return Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: raspController,
                      onPageChanged:(value)  {
                        print(indexesWithDate[value]);
                        if (value < previousRaspIndex && previousRaspIndex % 7 == 0 && userinputrasp){
                          userinputcalendar = false;
                            daysController.previousPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                        }
                        if (value > previousRaspIndex && previousRaspIndex % 7 == 6 && userinputrasp){
                            userinputcalendar = false;
                            daysController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease);
                        }
                        //userinputcalendar = true;
                        userinputrasp = true;
                        _changeSelectedIndex(value);
                        previousRaspIndex = value;
                        },
                      // physics: BouncingScrollPhysics(
                      //   parent: AlwaysScrollableScrollPhysics(),
                      // ),
                      itemCount: 26*7, 
                      itemBuilder: (BuildContext context, int index) {
                        //print(indexesWithDate[index]);
                        var date = indexesWithDate[index];
                        List<Lesson>? lesson = raspPerDate[date];
                        if (!raspPerDate.containsKey(date)){
                          return Center(
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                Lottie.network(
                                  'https://assets4.lottiefiles.com/packages/lf20_uk2qyv3i.json',
                                  height: 300,
                                ),
                                Text('Пар нет, отдыхай!'),
                                Expanded(child: Container()),
                              ],
                            ));
                        }
                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: raspPerDate[date]?.length,
                            itemBuilder: (BuildContext context, int listindex){
                              
                              Widget timeElement;
                              if (listindex == 0 || (listindex > 0 && raspPerDate[date]?[listindex -1].startTime 
                              != raspPerDate[date]![listindex].startTime)){
                                timeElement = TimetableTimeElement(
                                  timeLesson: raspPerDate[date]![listindex].startTime + ' - ' + raspPerDate[date]![listindex].finishTime,
                                  lessonNumber: raspPerDate[date]![listindex].lessonNumber,
                                  color: raspPerDate[date]![listindex].color,
                                );
                              } else {
                                timeElement = Container();
                              }
                              return Column(
                                children: [
                                  timeElement,
                                  TimeTableLessonElement(date, listindex),
                                ]
                              );
                            }
                          ),
                        );
                      }
                    ),
                  );
                }
              }
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        //     Icons.settings,
        //     size: 35,
        //     color: myblue,
        //     ),
        // ),
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            child: Center(
              child: Text(
                'Расписание',
                // style: TextStyle(
                //   //color: myblue,
                //   fontSize: 25,
                //   fontWeight: FontWeight.bold,
                //   ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}