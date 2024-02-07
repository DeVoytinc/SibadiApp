import 'package:flutter/material.dart';
import 'package:untitled1/main.dart';
import 'package:untitled1/mycolors.dart';

class Lesson {
  late String disciplineName;
  //String customName = '';
  late String lessonType;
  late String startTime;
  late String finishTime;
  late String teacherName;
  late String auditory;
  late String groupname;
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

  Lesson.fromJson(Map<String, dynamic> json) {
    disciplineName = json['дисциплина'] as String;
    if (disciplineName.startsWith('пр.')) {
      lessonType = 'Практика';
      color = dartMode ? myyellow : myyellowDark;
    } else if (disciplineName.startsWith('лаб')) {
      lessonType = 'Лабораторная';
      color = dartMode ? myviolet : myvioletDark;
    } else {
      lessonType = 'Лекция';
      color = dartMode ? mygreen : mygreenDark;
    }
    startTime = json['начало'] as String;
    finishTime = json['конец'] as String;
    teacherName = json['преподаватель'] as String;
    auditory = json['аудитория'] as String;
    groupname = json['группа'] as String;
    daynumber = json['деньНедели'] as int;
    lessonNumber = json['номерЗанятия'] as int;
    date = json['дата'] as String;
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
        'группа': groupname,
      };

  @override
  String toString() => '$lessonType, $disciplineName';
}
