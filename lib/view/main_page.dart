import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garap/view/daily_tasks/daily_tasks_view.dart';
import 'package:garap/view/onetime_tasks_view.dart';
import 'package:garap/view/restwork_timer_view.dart';
import 'package:garap/widgets/menu_card_widget.dart';

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
  // Box<dynamic> tasksBox = Hive.box('one_time_task_box');
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
  final ScrollController controller = ScrollController();

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
                            builder: (context) => const OneTimeTasksView(),
                          ),
                        );
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
                            builder: (context) => const RestworkTimerView(),
                          ),
                        );
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
