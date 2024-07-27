import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

@immutable
class DailyTasksModel {
  DailyTasksModel({
    required this.tasksView,
    required this.tasksSettingsView,
    required this.day,
    required this.isDispose,
    required this.onEvery,
  });

  final List<Map<String, dynamic>> tasksView;
  final String day;
  final bool isDispose;
  final Set<Days> onEvery;
  final List<Map<String, dynamic>> tasksSettingsView;
  final Box<dynamic> dbDay = Hive.box('day_box');
  final Box<dynamic> tasksBox = Hive.box('daily_task_box');

  DailyTasksModel copyWith({
    List<Map<String, dynamic>>? tasksView,
    List<Map<String, dynamic>>? tasksSettingsView,
    String? day,
    bool? isDispose,
    Set<Days>? onEvery,
  }) {
    return DailyTasksModel(
      tasksSettingsView: tasksSettingsView ?? this.tasksSettingsView,
      tasksView: tasksView ?? this.tasksView,
      day: day ?? this.day,
      isDispose: isDispose ?? this.isDispose,
      onEvery: onEvery ?? this.onEvery,
    );
  }
}

enum Days { sunday, monday, tuesday, wednesday, thursday, friday, saturday }
