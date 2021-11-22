import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventoModel {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  EventoModel({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.teal,
    this.isAllDay = false,
  });

  @override
  String toString() {
    return 'EventoModel(title: $title, description: $description, from: $from, to: $to, backgroundColor: $backgroundColor, isAllDay: $isAllDay)';
  }
}
