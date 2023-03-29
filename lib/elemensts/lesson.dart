import 'package:flutter/material.dart';

import '../main.dart';
import '../mycolors.dart';

class Lesson {

  late String disciplineName;
  //String customName = '';
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

  Map<String, dynamic> toJson() => {
        'дисциплина': disciplineName,
        'тип занятия': lessonType,
        'начало': startTime,
        'конец': finishTime,
        'преподаватель': teacherName,
        'аудитория': auditory,
        'деньНедели': daynumber,
        'номерЗанятия': lessonNumber,
        'дата': date,
        
  };

  @override
  String toString() {
    return '$lessonType, $disciplineName';
  }
}