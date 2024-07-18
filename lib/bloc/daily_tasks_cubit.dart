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
            day: DateFormat('EEEE').format(DateTime.now()),
            onEvery: const {},
            isDispose: false,
          ),
        );

  //////////
  //getter//
  //////////
  Box<dynamic> get tasksBox => state.tasksBox;
  String get day => state.day;
  Box<dynamic> get dbDay => state.dbDay;
  bool get isDispose => state.isDispose;
  List<Map<String, dynamic>> get tasksView => state.tasksView;

  set onEvery(Set<Days> value) {
    emit(
      state.copyWith(onEvery: value),
    );
  }

  set isDispose(bool value) {
    emit(DailyTasksModel(
        tasksView: state.tasksView,
        day: state.day,
        isDispose: value,
        onEvery: state.onEvery));
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

    emit(state.copyWith(tasksView: data.reversed.toList()));
    emit(
      state.copyWith(
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
      ),
    );

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
          emit(state.copyWith(day: DateFormat('EEEE').format(DateTime.now())));
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
    BuildContext context, [
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
                    maxLength: 30,
                    controller: taskController,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 23, 23, 23)),
                    decoration: const InputDecoration(
                        label: Text(
                      'Task',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  TextField(
                    maxLength: 100,
                    controller: descriptionController,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 23, 23, 23)),
                    decoration: const InputDecoration(
                        label: Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
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
                                  buttonColor:
                                      (state.onEvery.contains(Days.sunday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.sunday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery.contains(Days.sunday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.sunday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.sunday)),
                                      );
                                    }
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
                                  buttonColor:
                                      (state.onEvery.contains(Days.monday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.monday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery.contains(Days.monday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.monday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.monday)),
                                      );
                                    }
                                    setState(() {});
                                  },
                                  buttonText: 'Mon'),
                        ),
                      ),
                      ///////////
                      //tuesday//
                      ///////////
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: StatefulBuilder(
                          builder: (context, setState) =>
                              MiniSwitchButtonWidget(
                                  buttonColor:
                                      (state.onEvery.contains(Days.tuesday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.tuesday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery.contains(Days.tuesday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.tuesday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.tuesday)),
                                      );
                                    }
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
                                  buttonColor:
                                      (state.onEvery.contains(Days.wednesday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.wednesday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery
                                            .contains(Days.wednesday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.wednesday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.wednesday)),
                                      );
                                    }
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
                                  buttonColor:
                                      (state.onEvery.contains(Days.thursday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.thursday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery.contains(Days.thursday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.thursday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.thursday)),
                                      );
                                    }
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
                                  buttonColor:
                                      (state.onEvery.contains(Days.friday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.friday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery.contains(Days.friday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.friday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.friday)),
                                      );
                                    }
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
                                  buttonColor:
                                      (state.onEvery.contains(Days.saturday))
                                          ? Colors.lightGreenAccent[400]
                                          : Colors.grey[300],
                                  value: state.onEvery.contains(Days.saturday),
                                  onChanged: () {
                                    //jika tombol sedang dalam kondisi mati, maka if dijalankan
                                    if (state.onEvery.contains(Days.saturday) ==
                                        false) {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..add(Days.saturday)),
                                      );
                                      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
                                    } else {
                                      emit(
                                        state.copyWith(
                                            onEvery: state.onEvery.toSet()
                                              ..remove(Days.saturday)),
                                      );
                                    }
                                    setState(() {});
                                  },
                                  buttonText: 'Sat',),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 68, 68, 68),
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
                                  'sunday': state.onEvery.contains(Days.sunday),
                                  'monday': state.onEvery.contains(Days.monday),
                                  'tuesday':
                                      state.onEvery.contains(Days.tuesday),
                                  'wednesday':
                                      state.onEvery.contains(Days.wednesday),
                                  'thursday':
                                      state.onEvery.contains(Days.thursday),
                                  'friday': state.onEvery.contains(Days.friday),
                                  'saturday':
                                      state.onEvery.contains(Days.saturday),
                                },
                              );
                              //jika user memilih untuk menambah daftar tugas
                            } else {
                              await _addTask(
                                {
                                  'status': false,
                                  'task': taskController.text,
                                  'description': descriptionController.text,
                                  'sunday': state.onEvery.contains(Days.sunday),
                                  'monday': state.onEvery.contains(Days.monday),
                                  'tuesday':
                                      state.onEvery.contains(Days.tuesday),
                                  'wednesday':
                                      state.onEvery.contains(Days.wednesday),
                                  'thursday':
                                      state.onEvery.contains(Days.thursday),
                                  'friday': state.onEvery.contains(Days.friday),
                                  'saturday':
                                      state.onEvery.contains(Days.saturday),
                                },
                              );
                            }
                          }
                          refreshTasksView();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Edit',
                            style: TextStyle(
                                color: Color.fromARGB(255, 238, 238, 238)))),
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
