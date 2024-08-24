import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garap/bloc/daily_tasks_cubit.dart';
import 'package:garap/view/daily_tasks/daily_tasks_settings_view.dart';

class DailyTasksView extends StatefulWidget {
  const DailyTasksView({super.key});

  @override
  State<DailyTasksView> createState() => _DailyTasksViewState();
}

class _DailyTasksViewState extends State<DailyTasksView> {
  ////////////
  //variable//
  ////////////
  final DailyTasksCubit provider = DailyTasksCubit();
  late final StreamSubscription boxListener;
  ////////////
  //override//
  ////////////
  @override
  initState() {
    provider.checkIsDayChanged();
    boxListener = provider.tasksBox.watch().listen(
      (event) {
        provider.refreshTasksView();
      },
    );
    provider.refreshTasksView();
    super.initState();
  }

  @override
  dispose() {
    provider.isDispose = true;
    boxListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 23, 23),
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
        ),
        title: const Text(
          'Daily Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
        ),
        actions: [
          //tombol untuk pergi ke halaman pengaturan untuk `DailyTasks`
          IconButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DailyTasksSettingsView()));
            },
            icon: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: provider.tasksBox.watch(),
        builder: (context, snaphots) => (provider.tasksView.isEmpty)
            ? const Center(
                child: Text(
                  'there is no task for today',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: provider.tasksView.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> currentTask = provider.tasksView[index];
                  return StatefulBuilder(
                    builder: (context, setState) => Stack(
                      children: [
                        Positioned.fill(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;
                              final height = constraints.maxHeight;
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: AnimatedContainer(
                                  margin: const EdgeInsets.all(2.5),
                                  duration: const Duration(milliseconds: 300),
                                  width: (currentTask['status']) ? width : 0,
                                  height: height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 79, 249, 113),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 238, 238),
                              borderRadius: BorderRadius.circular(10)),
                          child: CheckboxListTile(
                            activeColor:
                                const Color.fromARGB(255, 79, 249, 113),
                            checkColor:
                                const Color.fromARGB(255, 238, 238, 238),
                            value: currentTask['status'],
                            onChanged: (value) async {
                              provider.switchTaskStatus(currentTask);
                            },
                            title: Text(currentTask['task']),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' - ${currentTask['description']}'),
                                Text(
                                  'Do At ${(currentTask['hourDate'].toString().length > 1) ? '${currentTask['hourDate']}' : '0${currentTask['hourDate']}'}:${(currentTask['minuteDate'].toString().length > 1) ? '${currentTask['minuteDate']}' : '0${currentTask['minuteDate']}'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
