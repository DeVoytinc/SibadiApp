import 'package:flutter/material.dart';

class CommonStatement {
  const CommonStatement({
    required this.disciplineName,
    required this.disciplineType,
    required this.id,
    required this.color,
  });

  final String disciplineName;
  final String disciplineType;
  final String id;
  final Color color;

  @override
  String toString() => '$disciplineType, $disciplineName';

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CommonStatement &&
        other.disciplineType == disciplineType &&
        other.disciplineName == disciplineName;
  }

  @override
  int get hashCode => Object.hash(disciplineName, disciplineType);
}
