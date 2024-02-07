import 'package:flutter/material.dart';

class CommonStatement3 {
  const CommonStatement3({
    required this.disciplineName,
    required this.disciplineType,
    required this.color,
  });

  final String disciplineName;
  final String disciplineType;
  final Color color;

  @override
  String toString() {
    return '$disciplineType, $disciplineName';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CommonStatement3 && other.disciplineType == disciplineType && other.disciplineName == disciplineName;
  }

  @override
  int get hashCode => Object.hash(disciplineName, disciplineType);
}