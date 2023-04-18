import 'package:flutter/material.dart';

class TimetableTimeElement extends StatelessWidget{
  const TimetableTimeElement({
    super.key, 
    required this.lessonNumber, 
    required this.timeLesson,
    required this.color,
  });

  final int lessonNumber;
  final String timeLesson;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topRight,
            width: 45,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            color: color,
            ),
            child: Center(child: Text(
              lessonNumber.toString(),
              style: TextStyle(fontSize: 18, color: Colors.white),
              )),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft ,
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              color: color,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  timeLesson,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    
  }

}