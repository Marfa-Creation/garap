import 'package:flutter/material.dart';
import 'package:garap/bloc/daily_tasks_cubit.dart';
import 'package:garap/view/daily_tasks/daily_tasks_settings_view.dart';

class DailyTasksView extends StatefulWidget {
  const DailyTasksView({super.key});

  @override
  State<DailyTasksView> createState() => _DailyTasksViewState();
}

class _DailyTasksViewState extends State<DailyTasksView> {
  DailyTasksCubit provider = DailyTasksCubit();

  ////////////
  //override//
  ////////////
  @override
  initState() {
    provider.isDispose = false;
    provider.updateDay();
    if (provider.day != provider.dbDay.get('day_box') &&
        provider.tasksBox.length > 0) {
      for (var i = 0; i < provider.tasksBox.length; i++) {
        provider.tasksBox.putAt(i, {
          'status': false,
          'task': provider.tasksBox.getAt(i)['task'],
          'description': provider.tasksBox.getAt(i)['description'],
          'sunday': provider.tasksBox.getAt(i)['sunday'],
          'monday': provider.tasksBox.getAt(i)['monday'],
          'tuesday': provider.tasksBox.getAt(i)['tuesday'],
          'wednesday': provider.tasksBox.getAt(i)['wednesday'],
          'thursday': provider.tasksBox.getAt(i)['thursday'],
          'friday': provider.tasksBox.getAt(i)['friday'],
          'saturday': provider.tasksBox.getAt(i)['saturday'],
        });
      }
    }
    provider.tasksBox.watch().listen(
      (event) {
        provider.refreshTasksView();
      },
    );
    provider.updateDbDay();
    provider.refreshTasksView();
    super.initState();
  }

  @override
  dispose() {
    provider.isDispose = true;
    super.dispose();
  }

  //////////
  //Method//
  //////////

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
        builder: (context, snaphots) => ListView.builder(
          itemCount: provider.tasksView.length,
          itemBuilder: (context, index) {
            var currentTask = provider.tasksView[index];
            return Card(
              child: CheckboxListTile(
                value: currentTask['status'],
                onChanged: (value) async {
                  await provider.editTask(
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
                        'status: ${(currentTask['status'] ? 'Complete' : 'Uncomplete')}')
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
