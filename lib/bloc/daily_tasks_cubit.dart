import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/daily_tasks_model.dart';
import 'package:garap/widgets/mini_switch_button_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DailyTasksCubit extends Cubit<DailyTasksModel> {
  DailyTasksCubit()
      : super(
          DailyTasksModel(
            tasksView: const [],
            day: DateFormat('EEEE').format(
              DateTime.now(),
            ),
          ),
        );
  //////////
  //getter//
  //////////
  TextEditingController get taskController => state.taskController;
  TextEditingController get descriptionController =>
      state.descriptionController;
  bool get onSunday => state.onSunday;
  bool get onMonday => state.onMonday;
  bool get onTuesday => state.onTuesday;
  bool get onWednesday => state.onWednesday;
  bool get onThursday => state.onThursday;
  bool get onFriday => state.onFriday;
  bool get onSaturday => state.onSaturday;
  Box<dynamic> get tasksBox => state.tasksBox;
  String get day => state.day;
  Box<dynamic> get dbDay => state.dbDay;
  bool get isDispose => state.isDispose;
  List<Map<String, dynamic>> get tasksView => state.tasksView;
  //////////
  //setter//
  //////////

  //////////////////////////////////////////////////////////////////////
  //setter ini mungkin tidak akan diperlukan setelah kode dimodifikasi//
  //////////////////////////////////////////////////////////////////////
  set tasksView(List<Map<String, dynamic>> value) {
    emit(DailyTasksModel(
      tasksView: value,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: state.onMonday,
      onTuesday: state.onTuesday,
      onWednesday: state.onWednesday,
      onThursday: state.onThursday,
      onFriday: state.onFriday,
      onSaturday: state.onSaturday,
    ));
  }

  set onSunday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: value,
      onMonday: state.onMonday,
      onTuesday: state.onTuesday,
      onWednesday: state.onWednesday,
      onThursday: state.onThursday,
      onFriday: state.onFriday,
      onSaturday: state.onSaturday,
    ));
  }

  set onMonday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: value,
      onTuesday: state.onTuesday,
      onWednesday: state.onWednesday,
      onThursday: state.onThursday,
      onFriday: state.onFriday,
      onSaturday: state.onSaturday,
    ));
  }

  set onTuesday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: state.onMonday,
      onTuesday: value,
      onWednesday: state.onWednesday,
      onThursday: state.onThursday,
      onFriday: state.onFriday,
      onSaturday: state.onSaturday,
    ));
  }

  set onWednesday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: state.onMonday,
      onTuesday: state.onTuesday,
      onWednesday: value,
      onThursday: state.onThursday,
      onFriday: state.onFriday,
      onSaturday: state.onSaturday,
    ));
  }

  set onThursday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: state.onMonday,
      onTuesday: state.onTuesday,
      onWednesday: state.onWednesday,
      onThursday: value,
      onFriday: state.onFriday,
      onSaturday: state.onSaturday,
    ));
  }

  set onFriday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: state.onMonday,
      onTuesday: state.onTuesday,
      onWednesday: state.onWednesday,
      onThursday: state.onThursday,
      onFriday: value,
      onSaturday: state.onSaturday,
    ));
  }

  set onSaturday(bool value) {
    emit(DailyTasksModel(
      tasksView: state.tasksView,
      day: state.day,
      onSunday: state.onSunday,
      onMonday: state.onMonday,
      onTuesday: state.onTuesday,
      onWednesday: state.onWednesday,
      onThursday: state.onThursday,
      onFriday: state.onFriday,
      onSaturday: value,
    ));
  }

  set isDispose(bool value) {
    emit(DailyTasksModel(
        tasksView: state.tasksView, day: state.day, isDispose: value));
  }

  set day(String value) {
    emit(DailyTasksModel(tasksView: state.tasksView, day: value));
  }

  void refreshTasksView() {
    final List<Map<String, dynamic>> data = state.tasksBox.keys
        .map((key) {
          final item = state.tasksBox.get(key);
          return {
            'key': key,
            'status': item['status'],
            'task': item['task'],
            'description': item['description'],
            'sunday': item['sunday'],
            'monday': item['monday'],
            'tuesday': item['tuesday'],
            'wednesday': item['wednesday'],
            'thursday': item['thursday'],
            'friday': item['friday'],
            'saturday': item['saturday'],
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    emit(DailyTasksModel(tasksView: data.reversed.toList(), day: state.day));
    emit(DailyTasksModel(
        tasksView: state.tasksView.where((element) {
          switch (state.day.toLowerCase()) {
            case 'sunday':
              return element['sunday'];

            case 'monday':
              return element['monday'];

            case 'tuesday':
              return element['tuesday'];

            case 'wednesday':
              return element['wednesday'];

            case 'thursday':
              return element['thursday'];

            case 'friday':
              return element['friday'];

            default:
              return element['saturday'];
          }
        }).toList(),
        day: state.day));

    state.tasksView.sort((now, next) {
      var a = (now['status']) ? 1 : 0;
      var b = (next['status']) ? 1 : 0;
      return a.compareTo(b);
    });
  }

  Future<void> updateDay() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // print('day periodic run');
        if (state.isDispose == true) {
          timer.cancel();
        } else {
          emit(DailyTasksModel(
              tasksView: state.tasksView,
              day: DateFormat('EEEE').format(DateTime.now())));
        }
      },
    );
  }

  void updateDbDay() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // print('dbDay periodic run');
        if (state.isDispose == true) {
          timer.cancel();
        } else {
          state.dbDay.put('day_box', DateFormat('EEEE').format(DateTime.now()));
        }
      },
    );
  }

  Future<void> editTask(int itemKey, Map<String, dynamic> data) async {
    await state.tasksBox.put(itemKey, data);
  }

  Future<void> _addTask(Map<String, dynamic> data) async {
    await state.tasksBox.add(data);
  }

  Future<void> deleteTask(int itemKey) async {
    await state.tasksBox.delete(itemKey);
  }

  void showTaskForm(
    int? itemKey,
    BuildContext context,
    // bool taskStatus,
    [
    String taskName = '',
    String description = '',
  ]) {
    TextEditingController taskController =
        TextEditingController(text: taskName);
    TextEditingController descriptionController =
        TextEditingController(text: description);
    if (context.mounted) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    maxLength: 13,
                    controller: taskController,
                    decoration: const InputDecoration(label: Text('Task')),
                  ),
                  TextField(
                    maxLength: 100,
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(label: Text('Description')),
                  ),
                  //tombol untuk user agar bisa memilih hari apa saja tugas dikerjakan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //////////
                      //sunday//
                      //////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor: (state.onSunday)
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey[300],
                                  value: state.onSunday,
                                  onChanged: () {
                                    // state.onSunday = !state.onSunday;
                                    emit(DailyTasksModel(
                                      tasksView: state.tasksView,
                                      day: state.day,
                                      onSunday: !state.onSunday,
                                      onMonday: state.onMonday,
                                      onTuesday: state.onTuesday,
                                      onWednesday: state.onWednesday,
                                      onThursday: state.onThursday,
                                      onFriday: state.onFriday,
                                      onSaturday: state.onSaturday,
                                    ));
                                    setState(() {});
                                  },
                                  buttonText: 'Sun'),
                        ),
                      ),
                      //////////
                      //monday//
                      //////////
                      Padding(
                          padding: const EdgeInsets.all(2),
                          child: StatefulBuilder(
                            builder: (context, setState) =>
                                MiniSwitchButtonWidget(
                                    buttonColor: (state.onMonday)
                                        ? Colors.lightGreenAccent[400]
                                        : Colors.grey[300],
                                    value: state.onMonday,
                                    onChanged: () {
                                      // provider.onMonday = !provider.onMonday;
                                      emit(DailyTasksModel(
                                        tasksView: state.tasksView,
                                        day: state.day,
                                        onSunday: state.onSunday,
                                        onMonday: !state.onMonday,
                                        onTuesday: state.onTuesday,
                                        onWednesday: state.onWednesday,
                                        onThursday: state.onThursday,
                                        onFriday: state.onFriday,
                                        onSaturday: state.onSaturday,
                                      ));
                                      setState(() {});
                                    },
                                    buttonText: 'Mon'),
                          )),
                      ///////////
                      //tuesday//
                      ///////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor: (state.onTuesday)
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey[300],
                                  value: state.onTuesday,
                                  onChanged: () {
                                    // provider.onTuesday = !provider.onTuesday;
                                    emit(DailyTasksModel(
                                      tasksView: state.tasksView,
                                      day: state.day,
                                      onSunday: state.onSunday,
                                      onMonday: state.onMonday,
                                      onTuesday: !state.onTuesday,
                                      onWednesday: state.onWednesday,
                                      onThursday: state.onThursday,
                                      onFriday: state.onFriday,
                                      onSaturday: state.onSaturday,
                                    ));
                                    setState(() {});
                                  },
                                  buttonText: 'Tue'),
                        ),
                      ),
                      /////////////
                      //wednesday//
                      /////////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor: (state.onWednesday)
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey[300],
                                  value: state.onWednesday,
                                  onChanged: () {
                                    // provider.onWednesday = !provider.onWednesday;
                                    emit(DailyTasksModel(
                                      tasksView: state.tasksView,
                                      day: state.day,
                                      onSunday: state.onSunday,
                                      onMonday: state.onMonday,
                                      onTuesday: state.onTuesday,
                                      onWednesday: !state.onWednesday,
                                      onThursday: state.onThursday,
                                      onFriday: state.onFriday,
                                      onSaturday: state.onSaturday,
                                    ));
                                    setState(() {});
                                  },
                                  buttonText: 'Wed'),
                        ),
                      ),
                      ////////////
                      //thursday//
                      ////////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor: (state.onThursday)
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey[300],
                                  value: state.onThursday,
                                  onChanged: () {
                                    // provider.onThursday = !provider.onThursday;
                                    emit(DailyTasksModel(
                                      tasksView: state.tasksView,
                                      day: state.day,
                                      onSunday: state.onSunday,
                                      onMonday: state.onMonday,
                                      onTuesday: state.onTuesday,
                                      onWednesday: state.onWednesday,
                                      onThursday: !state.onThursday,
                                      onFriday: state.onFriday,
                                      onSaturday: state.onSaturday,
                                    ));
                                    setState(() {});
                                  },
                                  buttonText: 'Thu'),
                        ),
                      ),
                      //////////
                      //friday//
                      //////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor: (state.onFriday)
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey[300],
                                  value: state.onFriday,
                                  onChanged: () {
                                    // provider.onFriday = !provider.onFriday;
                                    emit(DailyTasksModel(
                                      tasksView: state.tasksView,
                                      day: state.day,
                                      onSunday: state.onSunday,
                                      onMonday: state.onMonday,
                                      onTuesday: state.onTuesday,
                                      onWednesday: state.onWednesday,
                                      onThursday: state.onThursday,
                                      onFriday: !state.onFriday,
                                      onSaturday: state.onSaturday,
                                    ));
                                    setState(() {});
                                  },
                                  buttonText: 'Fri'),
                        ),
                      ),
                      ////////////
                      //saturday//
                      ////////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor: (state.onSaturday)
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey[300],
                                  value: state.onSaturday,
                                  onChanged: () {
                                    // provider.onSaturday = !provider.onSaturday;
                                    emit(DailyTasksModel(
                                      tasksView: state.tasksView,
                                      day: state.day,
                                      onSunday: state.onSunday,
                                      onMonday: state.onMonday,
                                      onTuesday: state.onTuesday,
                                      onWednesday: state.onWednesday,
                                      onThursday: state.onThursday,
                                      onFriday: state.onFriday,
                                      onSaturday: !state.onSaturday,
                                    ));
                                    setState(() {});
                                  },
                                  buttonText: 'Sat'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onPressed: () async {
                          if (taskController.text.isNotEmpty) {
                            //jika user memilih untuk mengedit daftar tugas
                            if (itemKey != null) {
                              await editTask(
                                itemKey,
                                {
                                  'status':
                                      state.tasksBox.getAt(itemKey)['status'],
                                  'task': taskController.text,
                                  'description': descriptionController.text,
                                  'sunday': onSunday,
                                  'monday': onMonday,
                                  'tuesday': onTuesday,
                                  'wednesday': onWednesday,
                                  'thursday': onThursday,
                                  'friday': onFriday,
                                  'saturday': onSaturday
                                },
                              );
                              //jika user memilih untuk menambah daftar tugas
                            } else {
                              await _addTask(
                                {
                                  'status': false,
                                  'task': taskController.text,
                                  'description': descriptionController.text,
                                  'sunday': onSunday,
                                  'monday': onMonday,
                                  'tuesday': onTuesday,
                                  'wednesday': onWednesday,
                                  'thursday': onThursday,
                                  'friday': onFriday,
                                  'saturday': onSaturday
                                },
                              );
                            }
                          }
                          onSunday = false;
                          onMonday = false;
                          onTuesday = false;
                          onWednesday = false;
                          onThursday = false;
                          onFriday = false;
                          onSaturday = false;
                          refreshTasksView();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Edit')),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
