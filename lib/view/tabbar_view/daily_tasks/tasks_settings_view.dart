import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TasksSettingsView extends StatefulWidget {
  const TasksSettingsView({super.key});

  @override
  State<TasksSettingsView> createState() => _TasksSettingsViewState();
}

class _TasksSettingsViewState extends State<TasksSettingsView> {
  ////////////
  //Override//
  ////////////
  @override
  initState() {
    refreshTasksView();
    super.initState();
  }

  /////////////////////
  //Field declaration//
  /////////////////////
  List<Map<String, dynamic>> tasksView = [];
  Box<dynamic> tasksBox = Hive.box('daily_task_list');
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool onSunday = false;
  bool onMonday = false;
  bool onTuesday = false;
  bool onWednesday = false;
  bool onThursday = false;
  bool onFriday = false;
  bool onSaturday = false;

  ///////////////////////
  //Method decllaration//
  ///////////////////////
  void showAddTaskForm(BuildContext context, int? itemKey) {
    if (context.mounted) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => Padding(
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
                    //menanyakan ke user pada hari apa saja tugas dikerjakan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //sunday
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onSunday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onSunday = !onSunday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Sun',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //////////
                        //monday//
                        //////////
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onMonday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onMonday = !onMonday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Mon',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ///////////
                        //tuesday//
                        ///////////
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onTuesday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onTuesday = !onTuesday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Tue',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /////////////
                        //wednesday//
                        /////////////
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onWednesday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onWednesday = !onWednesday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Wed',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //thursday
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onThursday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onThursday = !onThursday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Thu',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //////////
                        //friday//
                        //////////
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onFriday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onFriday = !onFriday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Fri',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ////////////
                        //saturday//
                        ////////////
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: (onSaturday)
                                  ? Colors.lightGreenAccent[400]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  onSaturday = !onSaturday;
                                  setState(() {});
                                },
                                child: const Center(
                                  child: Text(
                                    'Sat',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
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
                              //if user create new data
                              if (itemKey == null) {
                                await addTask(
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
                              //if user editing data
                              if (itemKey != null) {
                                await editTask(itemKey, {
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
                                });
                              }
                              taskController.text = '';
                              descriptionController.text = '';
                              onSunday = false;
                              onMonday = false;
                              onTuesday = false;
                              onWednesday = false;
                              onThursday = false;
                              onFriday = false;
                              onSaturday = false;
                              refreshTasksView();

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          },
                          child: Text((itemKey == null) ? 'Add' : 'Edit')),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void refreshTasksView() {
    final data = tasksBox.keys
        .map(
          (key) {
            final item = tasksBox.get(key);
            return {
              'key': key,
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
          },
        )
        .cast<Map<String, dynamic>>()
        .toList();

    setState(() {
      tasksView = data.reversed.toList();
    });
  }

  Future<void> addTask(Map<String, dynamic> data) async {
    await tasksBox.add(data);
  }

  Future<void> editTask(int itemKey, Map<String, dynamic> data) async {
    await tasksBox.put(itemKey, data);
  }

  Future<void> deleteTask(int itemKey) async {
    await tasksBox.delete(itemKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 238, 238, 238)),
        actions: [
          IconButton(
            onPressed: () {
              showAddTaskForm(context, null);
            },
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 23, 23, 23),
        title: const Text(
          'Tasks Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: tasksView.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> currentTask = tasksView[index];
          return Card(
            child: ListTile(
              title: Text(currentTask['task']),
              subtitle: Text(' - ${currentTask['description']}'),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 4 / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        taskController.text = currentTask['task'];
                        descriptionController.text = currentTask['description'];
                        onSunday = currentTask['sunday'];
                        onMonday = currentTask['monday'];
                        onTuesday = currentTask['tuesday'];
                        onWednesday = currentTask['wednesday'];
                        onThursday = currentTask['thursday'];
                        onFriday = currentTask['friday'];
                        onSaturday = currentTask['saturday'];
                        if (context.mounted) {
                          showAddTaskForm(context, currentTask['key']);
                        }
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteTask(currentTask['key']);
                        refreshTasksView();
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
