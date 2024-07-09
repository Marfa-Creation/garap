import 'package:flutter/material.dart';
import 'package:garap/bloc/onetime_tasks_cubit.dart';
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
    provider.tasksBox.watch().listen((event) {
      provider.refreshTaskView();
      if (mounted) {
        setState(() {});
      }
    });
    provider.refreshTaskView();
    super.initState();
  }

  ////////////
  //variabel//
  ////////////
  OnetimeTasksCubit provider = OnetimeTasksCubit();
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
          'Onetime Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              provider.showAddTaskForm(context);
            },
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.tasksView.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> currentData = provider.tasksView[index];
          return Card(
            child: ListTile(
              title: Text(
                currentData['task'],
              ),
              subtitle: Text(
                ' - ${currentData['description']}',
              ),
              trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 4 / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //tombol untuk mengedit nama/deskripsi tugas
                    IconButton(
                      onPressed: () {
                        provider.showEditTaskForm(currentData['key'], context,
                            currentData['task'], currentData['description']);
                        provider.refreshTaskView();
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    //tombol untuk menghapus tugas dari daftar
                    IconButton(
                      onPressed: () {
                        provider.deleteTask(currentData['key']);
                        provider.refreshTaskView();
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
