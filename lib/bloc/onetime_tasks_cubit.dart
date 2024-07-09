import 'package:flutter/material.dart';
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
  //setter//
  //////////
  // set taskController(String value) {
  //   state.taskController.text = value;
  //   emit(
  //     OnetimeTasksModel(
  //       tasksView: state.tasksView,
  //       taskController: state.taskController,
  //       descriptionController: state.descriptionController,
  //     ),
  //   );
  // }

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

    // state.tasksView = data.reversed.toList();
    emit(
      OnetimeTasksModel(
        tasksView: data.reversed.toList(),
      ),
    );
  }

  Future<void> _addTask(Map<String, dynamic> data) async {
    await state.tasksBox.add(data);
  }

  Future<void> _editTask(int itemKey, Map<String, dynamic> data) async {
    await state.tasksBox.put(itemKey, data);
  }

  Future<void> deleteTask(int itemKey) async {
    await state.tasksBox.delete(itemKey);
  }

  void showEditTaskForm(
      int itemKey, BuildContext context, String taskName, String description) {
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
              height: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.cyan[200],
                borderRadius: const BorderRadius.only(
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
                    decoration: const InputDecoration(label: Text('Task')),
                  ),
                  TextField(
                    maxLength: 100,
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(label: Text('Description')),
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
                            await _editTask(itemKey, {
                              'task': taskController.text,
                              'description': descriptionController.text,
                            });

                            refreshTaskView();
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
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

  void showAddTaskForm(BuildContext context) {
    TextEditingController taskController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

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
              height: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.cyan[200],
                borderRadius: const BorderRadius.only(
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
                    decoration: const InputDecoration(label: Text('Task')),
                  ),
                  TextField(
                    maxLength: 100,
                    controller: descriptionController,
                    decoration:
                        const InputDecoration(label: Text('Description')),
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
                            await _addTask({
                              'task': taskController.text,
                              'description': descriptionController.text,
                            });

                            // state.taskController.text = '';
                            // state.descriptionController.text = '';
                            refreshTaskView();
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: const Text('Add')),
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
