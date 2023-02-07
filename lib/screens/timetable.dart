
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/elemensts/my_grup.dart';
import 'package:untitled1/elemensts/raspisanieDay.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/elemensts/timetableElement.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:untitled1/screens/choose_group.dart';

import 'autorizationWiget.dart';

//String groupLink = '?group=13226';
String groupLink = selectedGroup.link;
int selectedIndex = 0;


class TimeTable extends StatefulWidget{
  TimeTable({Key? key}) : super(key: key);

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with SingleTickerProviderStateMixin{
  //late TabController _tabController;

  //GlobalKey TimeTableKey = new GlobalKey();
  List<Lesson> raspisanie = <Lesson>[];
  List<List<Lesson>> raspPerDate = [[],[],[],[],[],[],[]];
  TextEditingController customTextController = TextEditingController();

  getData(DateTime date) async {
    raspisanie.clear();
    String groupnumber = groupLink.replaceAll('?group=', '');
    Uri uri = Uri.parse('https://umu.sibadi.org/api/Rasp?idGroup=${groupnumber}&sdate=${date.year}-${date.month}-${date.day}');
    //Uri uri = Uri.parse('https://umu.sibadi.org/api/Rasp?idGroup=$groupnumber');
    //print('https://umu.sibadi.org/api/Rasp?idGroup=13412&sdate=${date.year}-${date.month}-${date.day}');
    final response =
    await http.Client().get(uri);
    if (response.statusCode == 200) {
      final jsonmap = jsonDecode(response.body);
      var rasplist = jsonmap['data']['rasp'];
      for (int i = 0; i < rasplist.length; i++){
        raspisanie.add(Lesson.fromJson(rasplist[i]));
      }
      generateRaspisaniePerDate();
      return raspisanie;
    }
    return raspisanie;
  }

  generateRaspisaniePerDate(){
    for (int i = 0; i < 7; i++)
    {
      raspPerDate[i].clear();
      for (int j=0; j < raspisanie.length; j++){
        if (raspisanie[j].daynumber == i + 1){
          raspPerDate[i].add(raspisanie[j]);
        }
      }
    }
  }

  void _changeSelectedIndex(int i){
    setState(() {
      selectedIndex = i;
      
    });
  }

  DateTime selectedDate = DateTime.now();
  DateTime curDate = DateTime.now();
  int selectedIndex = DateTime.now().weekday - 1;

  @override
  void initState() {
    setState(() {
      //getData(selectedDate);
    });
    super.initState();
  }

  DateTime mostRecentWeekday(DateTime date, int weekday){
    return DateTime(date.year, date.month, date.day - (date.weekday - 1));
  }

  List<DateTime> getWeek(DateTime data){
    DateTime monday = mostRecentWeekday(data, 1);
    //print(monday);
    List<DateTime> week = List.generate(7, (int index) => monday.add(Duration(days: index)), growable: false);
    return week;
  }

  List<List<DateTime>> getWeeksPeriodDate(){
    List<List<DateTime>> period = [];
    for( int i = 13; i > 0; i--){
      period.add(getWeek(curDate.subtract(Duration(days: 7 * i))));
    }
    for( int i = 0; i < 13; i++){
      period.add(getWeek(curDate.add(Duration(days: 7 * i))));
    }
    return period;
  }

  List<String> listOfDays = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  ScrollController scrollController = new ScrollController();

  Widget RaspisanieDayConstructor(int index, int indexday){
    List<List<DateTime>> nowPeriod = getWeeksPeriodDate();
    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedDate = nowPeriod[index][indexday];
          //getData(nowPeriod[index][indexday]);
          _changeSelectedIndex(indexday);
        },
        child: RaspisanieDay(
          daynumber: nowPeriod[index][indexday].day, 
          dayname: listOfDays[nowPeriod[index][indexday].weekday-1], 
          index: indexday,
          date: nowPeriod[index][indexday],
          selected: selectedIndex == indexday,
          ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {Navigator.pop(context, 'Cancel');},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );
    
    return Scaffold(
      
      //backgroundColor: mybackground,
      body: Container(
        child: Column(
          children: [
            Container(
                height: 80,
                width: double.infinity,
                color: Theme.of(context).canvasColor,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(viewportFraction: 1, initialPage: 13),
                  //onPageChanged:(value) => ,/////////////////////////////////////////////////////////////////////
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: 26, 
                  itemBuilder: (BuildContext context, int index) {  
                  
                    //print(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          RaspisanieDayConstructor(index, 0),
                          RaspisanieDayConstructor(index, 1),
                          RaspisanieDayConstructor(index, 2),
                          RaspisanieDayConstructor(index, 3),
                          RaspisanieDayConstructor(index, 4),
                          RaspisanieDayConstructor(index, 5),
                          RaspisanieDayConstructor(index, 6),
                          
                        ],
                      ),
                    );
                  },
                ),
                // 4 число с 10 до 6, 5 число с 10 до 3-5
              ),
              FutureBuilder(
                future: getData(selectedDate),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData){
                    return Expanded(
                      child: Center(
                        // child: Text("loading"),
                        child: CircularProgressIndicator(),
                        ),
                    );
                  }
                  else {
                    //int daynum = 0;
                    return Expanded(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: PageController(viewportFraction: 1, initialPage: ((26 * 7) / 2).round() + 1),
                        onPageChanged:(value) => _changeSelectedIndex(value % 7),
                        physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: 26 * 7, 
                        itemBuilder: (BuildContext context, int index) {
                          //daynum++;
                        int daynum = index % 7;
                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: raspPerDate[daynum].length,
                            itemBuilder: (BuildContext context, int listindex){
                              Widget timeElement;
                              if (listindex == 0 || (listindex > 0 && raspPerDate[daynum][listindex -1].startTime 
                              != raspPerDate[daynum][listindex].startTime)){
                                timeElement = TimetableTimeElement(
                                  timeLesson: raspPerDate[daynum][listindex].startTime + ' - ' + raspPerDate[daynum][listindex].finishTime,
                                  lessonNumber: raspPerDate[daynum][listindex].lessonNumber,
                                  color: raspPerDate[daynum][listindex].color,
                                );
                              } else {
                                timeElement = Container();
                              }
                              return Column(
                                children: [
                                  timeElement,
                                  Container(
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
                                                color: raspPerDate[daynum][listindex].color,
                                              ),
                                              child: IntrinsicHeight(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8.0),
                                                  child: Expanded(
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
                                                                      raspPerDate[daynum][listindex].customName != '' ? 
                                                                      raspPerDate[daynum][listindex].customName :
                                                                      raspPerDate[daynum][listindex].disciplineName,
                                                                      style: TextStyle(
                                                                        fontSize: 18,
                                                                        //color: Colors.black,
                                                                      )
                                                                    ),
                                                                    Text(
                                                                      textAlign: TextAlign.left,
                                                                      raspPerDate[daynum][listindex].lessonType+ ', ' 
                                                                      + raspPerDate[daynum][listindex].teacherName,
                                                                      style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: Colors.white60,
                            
                                                                      )
                                                                    ),
                                                                    Text(
                                                                      textAlign: TextAlign.left,
                                                                      raspPerDate[daynum][listindex].auditory,
                                                                      style: TextStyle(
                                                                        fontSize: 16,
                                                                        color: Colors.white60,
                            
                                                                      )
                                                                    ),
                                                                  ],
                                                                ),          
                                                              ),
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  width: 40,
                                                                  child: IconButton(
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: ((context) {
                                                                          customTextController.text = raspPerDate[daynum][listindex].disciplineName;
                                                                          return AlertDialog(
                                                                            title: Text("Редактировать предмет"),
                                                                            //content: Text("Would you like to continue learning how to use Flutter alerts?"),
                                                                            content: TextFormField(
                                                                              controller: customTextController,
                                                                              //initialValue: raspPerDate[selectedIndex][index].disciplineName,
                                                                              ),
                                                                            actions: [
                                                                              cancelButton,
                                                                              TextButton(
                                                                                child: Text("Continue"),
                                                                                onPressed:  () {
                                                                                  setState(() {
                                                                                    raspPerDate[daynum][listindex].customName = customTextController.text;
                                                                                    Navigator.pop(context, 'Cancel');
                                                                                    
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        })
                                                                    );
                                                                    },
                                                                    icon: Icon(Icons.more_vert)
                                                                    ),
                                                                ),
                                                                Expanded(child: Container())
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        
                                                      ),
                                                    )
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
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

        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            size: 35,
            color: myblue,
            ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Center(
            child: Text(
              'Расписание',
              style: TextStyle(
                color: myblue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                ),
            ),
          ),
        ),
      ),
    );
  }

}


class Lesson {

  late String disciplineName;
  String customName = '';
  late String lessonType;
  late String startTime;
  late String finishTime;
  late String teacherName;
  late String auditory;
  late int daynumber;
  late int lessonNumber;
  late Color color;

  Lesson({
    required this.disciplineName,
    required this.lessonType,
    required this.startTime,
    required this.finishTime,
    required this.daynumber,
    required this.lessonNumber,
  });

  Lesson.fromJson(Map<String, dynamic> json){
    disciplineName = json['дисциплина'];
    if (disciplineName.startsWith('пр.')){
      lessonType = 'Практика';
      color = dartMode  ? myyellow : myyellowDark;
    }
    else if (disciplineName.startsWith('лаб')){
      lessonType = 'Лабораторная';
      color = dartMode  ? myviolet :  myvioletDark;
    }
    else{
      lessonType = 'Лекция';
      color = dartMode  ? mygreen : mygreenDark;
    }
    startTime = json['начало'];
    finishTime = json['конец'];
    teacherName = json['преподаватель'];
    auditory = json['аудитория'];
    daynumber = json['деньНедели'];
    lessonNumber = json['номерЗанятия'];
    disciplineName = disciplineName.substring(4);
  }

  @override
  String toString() {
    return '$lessonType, $disciplineName';
  }
}