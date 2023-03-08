import 'package:flutter/material.dart';

class DiscipStatementData {
  const DiscipStatementData({
    required this.number,
    required this.zachetka,
    required this.marksKT1,
    required this.marksKT2,
    required this.result,
    required this.teacherName,
    required this.discType,
  });

  final String number;
  final String zachetka;
  final KontrolPoint? marksKT1;
  final KontrolPoint? marksKT2;
  final String result;
  final String teacherName;
  final String discType;

}

class KontrolPoint{
  const KontrolPoint({
    required this.lection,
    required this.practic,
    required this.lab,
    required this.other,
    required this.result,
  });

  final String lection;
  final String practic;
  final String lab;
  final String other;
  final String result;

}