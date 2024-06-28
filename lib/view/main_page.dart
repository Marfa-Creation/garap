import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garap/riverpod/providers.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:garap/view/tabbar_view/daily_tasks/daily_tasks_view.dart';
import 'package:garap/view/tabbar_view/daily_tasks/tasks_settings_view.dart';
import 'package:garap/view/tabbar_view/onetime_tasks_view.dart';
import 'package:garap/view/tabbar_view/timer_view.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  ////////////
  //Variable//
  ////////////
  String title = 'One-time tasks';
  Box<dynamic> tasksBox = Hive.box('one_time_task_list');
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
void dispose(){
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
                    // controller: taskController,
                    decoration: const InputDecoration(label: Text('Task')),
                  ),
                TextField(
                    maxLength: 100,
                    // controller: descriptionController,
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

  //Widget
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //Mentapkan tab yang secara standar dibuka
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 23, 23, 23),
          actions: [
            ListenableBuilder(
              listenable: tabController,
              builder: (context, child) {
                final currentIndex = tabController.index;

                if (currentIndex == 0) {
                  return IconButton(
                    onPressed: () async {
                      showAddTaskForm(context);
                    },
                    icon: const Icon(Icons.add,color: Color.fromARGB(255, 238, 238, 238),),
                  );
                } else if (currentIndex == 1) {
                  return IconButton(
                    onPressed: () {
                      ref.watch(audioMode.notifier).state =
                          !ref.watch(audioMode.notifier).state;
                      setState(() {});
                    },
                    icon: Icon((ref.watch(audioMode.notifier).state)
                        ? Icons.volume_up
                        : Icons.volume_off),
                    color: const Color.fromARGB(255, 238, 238, 238),
                  );
                } else if (currentIndex == 2) {
                  return IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TasksSettingsView(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings, color: Color.fromARGB(255, 238, 238, 238),),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
          title: ListenableBuilder(
            listenable: tabController,
            builder: (context, _) {
              final currentIndex = tabController.index;

              if (currentIndex == 0) {
                return const Text(
                  'OneTime Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                );
              } else if (currentIndex == 1) {
                return const Text(
                  'RestWork Timer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                );
              } else {
                return const Text(
                  'Daily Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                );
              }
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: Color.fromARGB(255, 68, 68, 68),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: tabController,
              isScrollable: true,
              tabs: const [
                Tab(
                  child: Icon(
                    Icons.one_x_mobiledata,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.timer_outlined,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.event,
                    color: Color.fromARGB(255, 238, 238, 238),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            OneTimeTasksView(),
            TimerView(),
            DailyTasksView(),
          ],
        ),
      ),
    );
  }
}
