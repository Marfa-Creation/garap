import 'package:flutter/material.dart';
import 'package:garap/bloc/daily_tasks_cubit.dart';
import 'package:garap/model/daily_tasks_model.dart';

class DailyTasksSettingsView extends StatefulWidget {
  const DailyTasksSettingsView({super.key});

  @override
  State<DailyTasksSettingsView> createState() => _DailyTasksSettingsViewState();
}

class _DailyTasksSettingsViewState extends State<DailyTasksSettingsView> {
  ////////////
  //Override//
  ////////////
  @override
  initState() {
    provider.refreshTasksView();
    provider.tasksBox.watch().listen((event) {
      provider.refreshTasksView();
    });
    super.initState();
  }

  ////////////
  //variable//
  ////////////
  DailyTasksCubit provider = DailyTasksCubit();

  //////////
  //Method//
  //////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 238, 238, 238)),
        actions: [
          //tombol untuk menambah daftar tugas harian
          IconButton(
            onPressed: () {
              provider.showTaskForm(
                null,
                context,
              );
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
      body: StreamBuilder(
          stream: provider.tasksBox.watch(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: provider.tasksView.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> currentTask =
                    provider.tasksView[index];
                return Card(
                  child: ListTile(
                    title: Text(currentTask['task']),
                    subtitle: Text(' - ${currentTask['description']}'),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width * 4 / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //tombol untuk mengedit pengaturan tugas harian
                          IconButton(
                            onPressed: () {
                              Set<Days> days = {};
                              if (currentTask['sunday'] == true) {
                                days.add(Days.sunday);
                              }
                              if (currentTask['monday'] == true) {
                                days.add(Days.monday);
                              }
                              if (currentTask['tuesday'] == true) {
                                days.add(Days.tuesday);
                              }
                              if (currentTask['wednesday'] == true) {
                                days.add(Days.wednesday);
                              }
                              if (currentTask['thursday'] == true) {
                                days.add(Days.thursday);
                              }
                              if (currentTask['friday'] == true) {
                                days.add(Days.friday);
                              }
                              if (currentTask['saturday'] == true) {
                                days.add(Days.saturday);
                              }
                              provider.onEvery = days;
                              if (context.mounted) {
                                provider.showTaskForm(
                                    currentTask['key'],
                                    context,
                                    currentTask['task'],
                                    currentTask['description']);
                              }
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              provider.deleteTask(currentTask['key']);
                              provider.refreshTasksView();
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
