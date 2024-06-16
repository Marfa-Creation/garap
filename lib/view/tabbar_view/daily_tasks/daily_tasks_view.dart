import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DailyTasksView extends StatefulWidget {
  final Function(void Function(void Function()))? callback;
  const DailyTasksView({this.callback, super.key});

  @override
  State<DailyTasksView> createState() => _DailyTasksViewState();
}

class _DailyTasksViewState extends State<DailyTasksView> {
  List<Map<String, dynamic>> tasksView = [];
  Box<dynamic> tasksBox = Hive.box('daily_task_list');
  String day = DateFormat('EEEE').format(DateTime.now());
  Box<dynamic> dbDay = Hive.box('day');

  ////////////
  //override//
  ////////////
  @override
  initState() {
    checkDay();
    if (day != dbDay.get('day') && tasksBox.length > 0) {
      print('reset status');
      for (var i = 0; i < tasksBox.length; i++) {
        print('loop ke $i');
        tasksBox.putAt(i, {
          'status': false,
          'task': tasksBox.getAt(i)['task'],
          'description': tasksBox.getAt(i)['description'],
          'sunday': tasksBox.getAt(i)['sunday'],
          'monday': tasksBox.getAt(i)['monday'],
          'tuesday': tasksBox.getAt(i)['tuesday'],
          'wednesday': tasksBox.getAt(i)['wednesday'],
          'thursday': tasksBox.getAt(i)['thursday'],
          'friday': tasksBox.getAt(i)['friday'],
          'saturday': tasksBox.getAt(i)['saturday'],
        });
      }
    }
    tasksBox.watch().listen(
      (event) {
        print('database changed');
        refreshTasksView();
      },
    );
    // updateDbDay();
    updateDbDay();
    refreshTasksView();
    super.initState();
  }

  //////////
  //Method//
  //////////

  void debugging() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      print(tasksBox.length);
    });
  }

  void refreshTasksView() {
    final List<Map<String, dynamic>> data = tasksBox.keys
        .map((key) {
          final item = tasksBox.get(key);
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

    tasksView = data.reversed.toList();

    tasksView = tasksView.where((element) {
      switch (day.toLowerCase()) {
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
    }).toList();

    tasksView.sort((now, next) {
      var a = (now['status']) ? 1 : 0;
      var b = (next['status']) ? 1 : 0;
      return a.compareTo(b);
    });

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> checkDay() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        day = DateFormat('EEEE').format(DateTime.now());
      },
    );
  }

  void updateDbDay() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        dbDay.put('day', DateFormat('EEEE').format(DateTime.now()));
      },
    );
  }

  Future<void> editTask(int itemKey, Map<String, dynamic> data) async {
    await tasksBox.put(itemKey, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tasksView.length,
        itemBuilder: (context, index) {
          var currentTask = tasksView[index];
          return Card(
            child: CheckboxListTile(
              value: currentTask['status'],
              onChanged: (value) async {
                await editTask(
                  currentTask['key'],
                  {
                    'status': !currentTask['status'],
                    'task': currentTask['task'],
                    'description': currentTask['description'],
                    'sunday': currentTask['sunday'],
                    'monday': currentTask['monday'],
                    'tuesday': currentTask['tuesday'],
                    'wednesday': currentTask['wednesday'],
                    'thursday': currentTask['thursday'],
                    'friday': currentTask['friday'],
                    'saturday': currentTask['saturday'],
                  },
                );
              },
              title: Text(currentTask['task']),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' - ${currentTask['description']}'),
                  Text(
                      'status: ${(currentTask['status'] ? 'selesai' : 'belum')}')
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
