import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garap/view/daily_tasks/daily_tasks_view.dart';
import 'package:garap/view/onetime_tasks_view.dart';
import 'package:garap/view/restwork_timer_view.dart';
import 'package:garap/widgets/menu_card_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  ////////////
  //Variable//
  ////////////
  String title = 'One-time tasks';
  Box<dynamic> tasksBox = Hive.box('one_time_task_box');
  late TabController tabController;
  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ////////////
  //Override//
  ////////////
  @override
  void initState() {
    debugging();
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    taskController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  //////////
  //Method//
  //////////
  Future<void> debugging() async {}

  Future<void> addTask(Map<String, dynamic> data) async {
    await tasksBox.add(data);
  }

  Future<void> showAddTaskForm(BuildContext context) async {
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
                            //if user create new data
                            addTask(
                              {
                                'task': taskController.text,
                                'description': descriptionController.text
                              },
                            );
                            taskController.text = '';
                            descriptionController.text = '';

                            Navigator.pop(context);
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

  List<String> tabs = const [
    'Menu',
    'Daily Tasks',
    'Onetime Tasks',
  ];
  int current = 0;
  final ScrollController controller = ScrollController();

  //Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 23, 23),
        title: const Text('Garap',
            style: TextStyle(color: Color.fromARGB(255, 238, 238, 238))),
      ),
      body: RawScrollbar(
        thumbVisibility: false,
        thumbColor: const Color.fromARGB(255, 23, 23, 23),
        controller: controller,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: ListView(controller: controller, children: [
                Row(
                  children: [
                    //MenuCardWidget untuk menuju ke `DailyTasksView`
                    MenuCardWidget(
                      color: Colors.red,
                      text: const Text(
                        'Daily Tasks',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(
                        Icons.event_available,
                        size: 100,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DailyTasksView()));
                      },
                    ),
                    const SizedBox(width: 20),
                    //MenuCardWidget untuk menuju ke `OnetimeTasksView`
                    MenuCardWidget(
                      color: Colors.red,
                      text: const Text(
                        'Onetime Tasks',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(
                        Icons.event,
                        size: 100,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OneTimeTasksView()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    //MenuCardWidget untuk menuju ke`TimerView`
                    MenuCardWidget(
                      color: Colors.green,
                      text: const Text(
                        'Restwork Timer',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      icon: const Icon(
                        Icons.timer,
                        size: 100,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RestworkTimerView()));
                      },
                    ),
                    const SizedBox(width: 20),
                    const MenuCardWidget(),
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    MenuCardWidget(),
                    SizedBox(width: 20),
                    MenuCardWidget(),
                  ],
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    MenuCardWidget(),
                    SizedBox(width: 20),
                    MenuCardWidget(),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
