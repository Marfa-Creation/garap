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
              // provider.showAddTaskForm(context);
              TextEditingController taskController = TextEditingController();
              TextEditingController descriptionController =
                  TextEditingController();

              if (context.mounted) {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Container(
                        height: 250,
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
                              maxLength: 30,
                              controller: taskController,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 23, 23, 23)),
                              decoration: const InputDecoration(
                                  label: Text(
                                'Task',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ),
                            TextField(
                              maxLength: 100,
                              controller: descriptionController,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 23, 23, 23)),
                              decoration: const InputDecoration(
                                label: Text(
                                  'Description',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 68, 68, 68),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                onPressed: () async {
                                  if (taskController.text.isNotEmpty) {
                                    await provider.addTask({
                                      'task': taskController.text,
                                      'description': descriptionController.text,
                                    });

                                    provider.refreshTaskView();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 238, 238, 238),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
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
                    //////////////////////////////////////////////
                    //tombol untuk mengedit nama/deskripsi tugas//
                    //////////////////////////////////////////////
                    IconButton(
                      onPressed: () {
                        TextEditingController taskController =
                            TextEditingController(text: currentData['task']);
                        TextEditingController descriptionController =
                            TextEditingController(
                                text: currentData['description']);

                        if (context.mounted) {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                  height: 250,
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
                                        maxLength: 30,
                                        controller: taskController,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 23, 23, 23)),
                                        decoration: const InputDecoration(
                                            label: Text('Task',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                      TextField(
                                        maxLength: 100,
                                        controller: descriptionController,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 23, 23, 23)),
                                        decoration: const InputDecoration(
                                            label: Text('Description',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 68, 68, 68),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if (taskController
                                                .text.isNotEmpty) {
                                              await provider.editTask(
                                                  currentData['key'], {
                                                'task': taskController.text,
                                                'description':
                                                    descriptionController.text,
                                              });

                                              provider.refreshTaskView();
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            }
                                          },
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 238, 238, 238),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
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
