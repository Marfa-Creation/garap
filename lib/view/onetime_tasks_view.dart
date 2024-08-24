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
  //variabel//
  ////////////
  final OnetimeTasksCubit provider = OnetimeTasksCubit();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  //////////
  //method//
  //////////

  Future<bool?> showDeleteTaskConfirmation() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1 / 2,
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 64, 65, 75),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Are you sure to delete\nthis task?',
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Color.fromARGB(255, 79, 249, 113),
                        ),
                      ),
                    ),
                    const SizedBox(width: 35),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showTaskForm(
      {required void Function() onButtonClick,
      required String buttonText}) async {
    if (context.mounted) {
      await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 325,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        maxLength: 30,
                        controller: taskController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 23, 23, 23)),
                        decoration: const InputDecoration(
                            label: Text('Task',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 150,
                        child: TextField(
                          minLines: 1,
                          maxLines: 10,
                          maxLength: 300,
                          controller: descriptionController,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 23, 23, 23)),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 68, 68, 68),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onPressed: () async {
                          onButtonClick();
                        },
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 238, 238, 238),
                          ),
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
  }

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

  @override
  dispose() {
    taskController.dispose();
    descriptionController.dispose();
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
          'Onetime Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showTaskForm(
                      onButtonClick: () async {
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
                      buttonText: 'Add')
                  .whenComplete(() {
                taskController.text = '';
                descriptionController.text = '';
              });
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
                    IconButton(
                      onPressed: () {
                        taskController.text = currentData['task'];
                        descriptionController.text = currentData['description'];
                        showTaskForm(
                                onButtonClick: () async {
                                  if (taskController.text.isNotEmpty) {
                                    await provider
                                        .editTask(currentData['key'], {
                                      'task': taskController.text,
                                      'description': descriptionController.text,
                                    });
                                    provider.refreshTaskView();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                buttonText: 'Edit')
                            .whenComplete(() {
                          taskController.text = '';
                          descriptionController.text = '';
                        });
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    //tombol untuk menghapus tugas dari daftar
                    IconButton(
                      onPressed: () async {
                        final bool confirmation =
                            await showDeleteTaskConfirmation() ?? false;
                        if (confirmation == true) {
                          provider.deleteTask(currentData['key']);
                          provider.refreshTaskView();
                        }
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
