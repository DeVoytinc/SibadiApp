import 'package:flutter/material.dart';
import 'package:untitled1/elemensts/raspisanieDay.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/elemensts/timetableElement.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled1/screens/choose_group.dart';


String groupLink = selectedGroup.link;

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
  DateTime threeMonthAgo = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).subtract(Duration(days: 13 * 7 - (DateTime.now().weekday - 2)));
  DateTime threeMonthBefore = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(Duration(days: 13 * 7 + (7 - DateTime.now().weekday)));
  //DateTime selectedDate = DateTime.now();
  DateTime curDate = DateTime.now();
  int selectedIndex = ((26 * 7) / 2).round() + DateTime.now().weekday - 8;
  List indexesWithDate = [];
  List<String> listOfDays = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  PageController daysController = PageController(viewportFraction: 1, initialPage: 12);
  PageController raspController = PageController(viewportFraction: 1, initialPage: ((26 * 7) / 2).round());
  int daypageindex = 0;
  int listpageindex = 0;

  getData() async {
    raspisanie.clear();
    String groupnumber = groupLink.replaceAll('?group=', '');
    Uri uri = Uri.parse('https://umu.sibadi.org/api/Rasp?idGroup=${groupnumber}');
    final response =
    await http.Client().get(uri);
    if (response.statusCode == 200) {
      final jsonmap = jsonDecode(response.body);
      var rasplist = jsonmap['data']['rasp'];
      //var firstIndex = Lesson.fromJson(rasplist).
      for (int i = 0; i < rasplist.length; i++){
        raspisanie.add(Lesson.fromJson(rasplist[i]));
      }

      var firstIndexForRasp = raspisanie.indexOf(raspisanie.firstWhere((element) => DateTime.parse(element.date).isAfter(threeMonthAgo)));
      

        for (int j = firstIndexForRasp; j < raspisanie.length; j++){
          
          //raspPerDate = 
            raspPerDate[DateTime.parse(raspisanie[j].date)] = raspisanie.where((element) => element.date == raspisanie[j].date).toList();
        
      }
    }
    return raspPerDate;
  }


  void _changeSelectedIndex(int i){
    setState(() {
      selectedIndex = i;
      raspController.animateToPage(selectedIndex, duration: Duration(milliseconds: 300), curve: Curves.ease);
      //print(indexesWithDate[i+ 1]);
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
            Container(
                height: 80,
                width: double.infinity,
                color: Theme.of(context).canvasColor,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: daysController,
                  onPageChanged:(value) => setState(() {
                    if (value < daypageindex){
                      //selectedIndex = selectedIndex - 7;
                      daypageindex = value;
                      _changeSelectedIndex(selectedIndex - 7);
                      raspController.jumpToPage(selectedIndex);
                    }
                    else if (value > daypageindex){
                      //selectedIndex = selectedIndex + 7;
                      daypageindex = value;
                      _changeSelectedIndex(selectedIndex + 7);
                      raspController.jumpToPage(selectedIndex);
                    }
                    else {

                    }
                  }),
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
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
                // 4 число с 10 до 6, 5 число с 10 до 3-5
              ),
              FutureBuilder(
                future: raspPerDate.isEmpty ? getData() : null,
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
                        //controller: PageController(viewportFraction: 1, initialPage: ((26 * 7) / 2).round() - 3),
                        controller: raspController,
                        onPageChanged:(value)  {
                          //_changeSelectedIndex(value);
                          print(indexesWithDate[value]);
                          },
                        physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: 26*7, 
                        itemBuilder: (BuildContext context, int index) {
                          //daynum++;
                        //int daynum = index % 7;
                        print(indexesWithDate[index]);
                        //return Raspis(indexesWithDate[index]);
                        var date = indexesWithDate[index];
                        if (!raspPerDate.containsKey(date)) {
      return Container(); 
    }
    List<Lesson>? lesson = raspPerDate[date];
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
                                              raspPerDate[date]![listindex].customName != '' ? 
                                              raspPerDate[date]![listindex].customName :
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
                                    // Column(
                                    //   children: [
                                    //     Container(
                                    //       width: 40,
                                    //       child: IconButton(
                                    //         onPressed: () {
                                    //           showDialog(
                                    //             context: context,
                                    //             builder: ((context) {
                                    //               customTextController.text = raspPerDate[date]![listindex].disciplineName;
                                    //               return AlertDialog(
                                    //                 title: Text("Редактировать предмет"),
                                    //                 //content: Text("Would you like to continue learning how to use Flutter alerts?"),
                                    //                 content: TextFormField(
                                    //                   controller: customTextController,
                                    //                   //initialValue: raspPerDate[selectedIndex][index].disciplineName,
                                    //                   ),
                                    //                 actions: [
                                    //                   //cancelButton,
                                    //                   TextButton(
                                    //                     child: Text("Continue"),
                                    //                     onPressed:  () {
                                    //                       setState(() {
                                    //                         raspPerDate[date]?[listindex].customName = customTextController.text;
                                    //                         Navigator.pop(context, 'Cancel');
                                                            
                                    //                       });
                                    //                     },
                                    //                   ),
                                    //                 ],
                                    //               );
                                    //             })
                                    //         );
                                    //         },
                                    //         icon: Icon(Icons.more_vert)
                                    //         ),
                                    //     ),
                                    //   ],
                                    // )
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
  late String date;

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
    date = json['дата'];
    disciplineName = disciplineName.substring(4);
  }

  @override
  String toString() {
    return '$lessonType, $disciplineName';
  }
}