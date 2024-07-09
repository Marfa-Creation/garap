import 'package:flutter/material.dart';
import 'package:garap/bloc/daily_tasks_cubit.dart';

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
              provider.showTaskForm(null, context, );
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
        itemCount: provider.tasksView.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> currentTask = provider.tasksView[index];
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
                        provider.taskController.text = currentTask['task'];
                        provider.descriptionController.text =
                            currentTask['description'];
                        provider.onSunday = currentTask['sunday'];
                        provider.onMonday = currentTask['monday'];
                        provider.onTuesday = currentTask['tuesday'];
                        provider.onWednesday = currentTask['wednesday'];
                        provider.onThursday = currentTask['thursday'];
                        provider.onFriday = currentTask['friday'];
                        provider.onSaturday = currentTask['saturday'];
                        if (context.mounted) {
                          provider.showTaskForm(currentTask['key'], context,
                              currentTask['task'], currentTask['description']);
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
      ),
    );
  }
}
