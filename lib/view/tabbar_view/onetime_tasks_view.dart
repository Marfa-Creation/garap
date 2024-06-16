import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
export 'package:garap/view/main_page.dart';

class OneTimeTasksView extends StatefulWidget {
  const OneTimeTasksView({super.key});

  @override
  State<OneTimeTasksView> createState() => _OneTimeTasksViewState();
}

class _OneTimeTasksViewState extends State<OneTimeTasksView> {
  ////////////
  //Override//
  ////////////
  @override
  initState() {
    tasksBox.watch().listen((event) {
      refreshTaskView();
      if (mounted) {
        setState(() {});
      }
    });
    refreshTaskView();
    super.initState();
  }

  ////////////
  //variabel//
  ////////////
  List<Map<String, dynamic>> tasksView = [];
  Box<dynamic> tasksBox = Hive.box('one_time_task_list');
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  //////////
  //Method//
  //////////

  void refreshTaskView() {
    for (var i = 0; i < tasksBox.length; i++) {
      tasksBox.delete(i);
    }
    if (!Hive.isBoxOpen('one_time_task_list')) {
      print('box tidak terbuka');
    }

    final List<Map<String, dynamic>> data = tasksBox.keys
        .map((key) {
          final item = tasksBox.get(key);
          return {
            'key': key,
            'task': item['task'],
            'description': item['description']
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    tasksView = data.reversed.toList();
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    await tasksBox.add(data);
  }

  Future<void> editTask(int? itemKey, Map<String, dynamic> data) async {
    await tasksBox.put(itemKey, data);
  }

  Future<void> deleteTask(int itemKey) async {
    await tasksBox.delete(itemKey);
  }

  //method untuk membuka formulir penambahan data tugas
  void showEditTaskForm(BuildContext context, int itemKey) {
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
                            await editTask(itemKey, {
                              'task': taskController.text,
                              'description': descriptionController.text
                            });

                            taskController.text = '';
                            descriptionController.text = '';
                            refreshTaskView();

                            // ignore: use_build_context_synchronously
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasksView.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> currentdata = tasksView[index];
          return Card(
            child: ListTile(
              title: Text(
                currentdata['task'],
              ),
              subtitle: Text(
                ' - ${currentdata['description']}',
              ),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 4 / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Edit task Button
                    IconButton(
                      onPressed: () {
                        taskController.text = currentdata['task'];
                        descriptionController.text = currentdata['description'];
                        showEditTaskForm(context, currentdata['key']);
                        refreshTaskView();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    //Delete task button
                    IconButton(
                      onPressed: () {
                        deleteTask(currentdata['key']);
                        refreshTaskView();
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
