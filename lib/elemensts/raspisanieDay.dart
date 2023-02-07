import 'package:flutter/material.dart';
import 'package:untitled1/mycolors.dart';
import 'package:untitled1/screens/timetable.dart';


class WeekForCalendar extends StatelessWidget{
  late List<DateTime> week;
  bool selected = false;

  WeekForCalendar({
    super.key,
    required this.week,
    this.selected = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
      ],
    );
  }

}

class RaspisanieDay extends StatelessWidget {
  final int daynumber;
  final String dayname;
  final int index;
  DateTime date;
  bool selected = false;

  RaspisanieDay({
    super.key,
    required this.daynumber,
    required this.dayname,
    required this.index,
    required this.date,
    //this.curDate = false,
    this.selected = false,

  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 5),
      //padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : Theme.of(context).canvasColor,
        //color: curDate ? myblue : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: 
          date.day == DateTime.now().day && 
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year 
          ?
          Colors.white : Theme.of(context).canvasColor,
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                daynumber.toString(),
                style: TextStyle(
                  //color: selected ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
            )
          ),
          Expanded(
            child: Center(
              child: Text(
                dayname,
                style: TextStyle(
                  //color: selected ? Colors.white : Colors.black,
                ),
              ),
            )
          ),
        ],
      )
    );
  }
}
