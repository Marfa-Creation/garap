import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

@immutable
class OnetimeTasksModel {
  OnetimeTasksModel({
    required this.tasksView,
  });

  final List<Map<String, dynamic>> tasksView;
  final Box<dynamic> tasksBox = Hive.box('one_time_task_box');
}
