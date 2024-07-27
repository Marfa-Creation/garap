import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/onetime_tasks_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OnetimeTasksCubit extends Cubit<OnetimeTasksModel> {
  OnetimeTasksCubit()
      : super(
          OnetimeTasksModel(
            tasksView: const [],
          ),
        );

  //////////
  //getter//
  //////////
  Box<dynamic> get tasksBox => state.tasksBox;
  List<Map<String, dynamic>> get tasksView => state.tasksView;

  //digunakan untuk merefresh UI ketika ada penambahan data
  void refreshTaskView() {
    var data = state.tasksBox.keys
        .map((key) {
          var item = state.tasksBox.get(key);
          return {
            'key': key,
            'task': item['task'],
            'description': item['description'],
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    emit(state.copyWith(tasksView: data.reversed.toList()));
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    await state.tasksBox.add(data);
  }

  Future<void> editTask(int itemKey, Map<String, dynamic> data) async {
    await state.tasksBox.put(itemKey, data);
  }

  Future<void> deleteTask(int itemKey) async {
    await state.tasksBox.delete(itemKey);
  }
}
