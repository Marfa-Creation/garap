import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@immutable
class DailyTasksModel {
  DailyTasksModel({
    required this.tasksView,
    required this.day,
    this.isDispose = false,
    this.onSunday = false,
    this.onMonday = false,
    this.onTuesday = false,
    this.onWednesday = false,
    this.onThursday = false,
    this.onFriday = false,
    this.onSaturday = false,
  });

  final List<Map<String, dynamic>> tasksView;
  final String day;
  final Box<dynamic> tasksBox = Hive.box('daily_task_box');
  final Box<dynamic> dbDay = Hive.box('day_box');
  final bool isDispose;
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final bool onSunday;
  final bool onMonday;
  final bool onTuesday;
  final bool onWednesday;
  final bool onThursday;
  final bool onFriday;
  final bool onSaturday;
}
