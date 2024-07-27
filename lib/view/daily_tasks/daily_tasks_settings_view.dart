import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garap/bloc/daily_tasks_cubit.dart';
import 'package:garap/model/daily_tasks_model.dart';
import 'package:garap/widgets/mini_switch_button_widget.dart';

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
    provider.refreshTasksSettingsView();
    provider.tasksBox.watch().listen((event) {
      provider.refreshTasksSettingsView();
    });
    super.initState();
  }

  @override
  dispose() {
    taskController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  ////////////
  //variable//
  ////////////
  DailyTasksCubit provider = DailyTasksCubit();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> debugging() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {},
    );
  }

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
              // provider.showTaskForm(
              //   null,
              //   context,
              // );

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
                        height: 300,
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
                              )),
                            ),
                            //tombol untuk user agar bisa memilih hari apa saja tugas dikerjakan
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //////////
                                //sunday//
                                //////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                      buttonColor: (provider.onEvery
                                              .contains(Days.sunday))
                                          ? const Color.fromARGB(
                                              255, 79, 249, 113)
                                          : Colors.grey[300],
                                      onPressed: () {
                                        provider.switchSundayButton();
                                        setState(() {});
                                      },
                                      buttonText: 'Sun',
                                    ),
                                  ),
                                ),
                                //////////
                                //monday//
                                //////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                      buttonColor: (provider.onEvery
                                              .contains(Days.monday))
                                          ? const Color.fromARGB(
                                              255, 79, 249, 113)
                                          : Colors.grey[300],
                                      onPressed: () {
                                        provider.switchMondayButton();
                                        setState(() {});
                                      },
                                      buttonText: 'Mon',
                                    ),
                                  ),
                                ),
                                ///////////
                                //tuesday//
                                ///////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                            buttonColor: (provider.onEvery
                                                    .contains(Days.tuesday))
                                                ? const Color.fromARGB(
                                                    255, 79, 249, 113)
                                                : Colors.grey[300],
                                            onPressed: () {
                                              provider.switchTuesdayButton();
                                              setState(() {});
                                            },
                                            buttonText: 'Tue'),
                                  ),
                                ),
                                /////////////
                                //wednesday//
                                /////////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                            buttonColor: (provider.onEvery
                                                    .contains(Days.wednesday))
                                                ? const Color.fromARGB(
                                                    255, 79, 249, 113)
                                                : Colors.grey[300],
                                            onPressed: () {
                                              provider.switchWednesdayButton();
                                              setState(() {});
                                            },
                                            buttonText: 'Wed'),
                                  ),
                                ),
                                ////////////
                                //thursday//
                                ////////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                            buttonColor: (provider.onEvery
                                                    .contains(Days.thursday))
                                                ? const Color.fromARGB(
                                                    255, 79, 249, 113)
                                                : Colors.grey[300],
                                            onPressed: () {
                                              provider.switchThursdayButton();
                                              setState(() {});
                                            },
                                            buttonText: 'Thu'),
                                  ),
                                ),
                                //////////
                                //friday//
                                //////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                            buttonColor: (provider.onEvery
                                                    .contains(Days.friday))
                                                ? const Color.fromARGB(
                                                    255, 79, 249, 113)
                                                : Colors.grey[300],
                                            onPressed: () {
                                              provider.switchFridayButton();
                                              setState(() {});
                                            },
                                            buttonText: 'Fri'),
                                  ),
                                ),
                                ////////////
                                //saturday//
                                ////////////
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: StatefulBuilder(
                                    builder: (context, setState) =>
                                        MiniSwitchButtonWidget(
                                      buttonColor: (provider.onEvery
                                              .contains(Days.saturday))
                                          ? const Color.fromARGB(
                                              255, 79, 249, 113)
                                          : Colors.grey[300],
                                      onPressed: () {
                                        provider.switchSaturdayButton();
                                        setState(() {});
                                      },
                                      buttonText: 'Sat',
                                    ),
                                  ),
                                ),
                              ],
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
                                    provider.addTask(taskController.text,
                                        descriptionController.text);

                                    provider.refreshTasksSettingsView();
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
                ).whenComplete(
                  //menonaktifkan seluruh tombol untuk memilih hari
                  () {
                    taskController.text = '';
                    descriptionController.text = '';
                    provider.clearButtonConditions();
                  },
                );
              }
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
            itemCount: provider.tasksSettingsView.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> currentTask =
                  provider.tasksSettingsView[index];
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
                            taskController.text = currentTask['task'];
                            descriptionController.text =
                                currentTask['description'];
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
                                      height: 300,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 238, 238, 238),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          TextField(
                                            maxLength: 30,
                                            controller: taskController,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 23, 23, 23),
                                            ),
                                            decoration: const InputDecoration(
                                                label: Text(
                                              'Task',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          TextField(
                                            maxLength: 100,
                                            controller: descriptionController,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 23, 23, 23)),
                                            decoration: const InputDecoration(
                                              label: Text(
                                                'Description',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          //tombol untuk user agar bisa memilih hari apa saja tugas dikerjakan
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              //////////
                                              //sunday//
                                              //////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                    buttonColor: (provider
                                                            .onEvery
                                                            .contains(
                                                                Days.sunday))
                                                        ? const Color.fromARGB(
                                                            255, 79, 249, 113)
                                                        : Colors.grey[300],
                                                    onPressed: () {
                                                      provider
                                                          .switchSundayButton();
                                                      setState(() {});
                                                    },
                                                    buttonText: 'Sun',
                                                  ),
                                                ),
                                              ),
                                              //////////
                                              //monday//
                                              //////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                    buttonColor: (provider
                                                            .onEvery
                                                            .contains(
                                                                Days.monday))
                                                        ? const Color.fromARGB(
                                                            255, 79, 249, 113)
                                                        : Colors.grey[300],
                                                    onPressed: () {
                                                      provider
                                                          .switchMondayButton();
                                                      setState(() {});
                                                    },
                                                    buttonText: 'Mon',
                                                  ),
                                                ),
                                              ),
                                              ///////////
                                              //tuesday//
                                              ///////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                          buttonColor: (provider
                                                                  .onEvery
                                                                  .contains(
                                                                      Days
                                                                          .tuesday))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  79, 249, 113)
                                                              : Colors
                                                                  .grey[300],
                                                          onPressed: () {
                                                            provider
                                                                .switchTuesdayButton();
                                                            setState(() {});
                                                          },
                                                          buttonText: 'Tue'),
                                                ),
                                              ),
                                              /////////////
                                              //wednesday//
                                              /////////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                          buttonColor: (provider
                                                                  .onEvery
                                                                  .contains(
                                                            Days.wednesday,
                                                          ))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  79, 249, 113)
                                                              : Colors
                                                                  .grey[300],
                                                          onPressed: () {
                                                            provider
                                                                .switchWednesdayButton();
                                                            setState(() {});
                                                          },
                                                          buttonText: 'Wed'),
                                                ),
                                              ),
                                              ////////////
                                              //thursday//
                                              ////////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                          buttonColor: (provider
                                                                  .onEvery
                                                                  .contains(Days
                                                                      .thursday))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  79, 249, 113)
                                                              : Colors
                                                                  .grey[300],
                                                          onPressed: () {
                                                            provider
                                                                .switchThursdayButton();
                                                            setState(() {});
                                                          },
                                                          buttonText: 'Thu'),
                                                ),
                                              ),
                                              //////////
                                              //friday//
                                              //////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                          buttonColor: (provider
                                                                  .onEvery
                                                                  .contains(
                                                                      Days
                                                                          .friday))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  79, 249, 113)
                                                              : Colors
                                                                  .grey[300],
                                                          onPressed: () {
                                                            provider
                                                                .switchFridayButton();
                                                            setState(() {});
                                                          },
                                                          buttonText: 'Fri'),
                                                ),
                                              ),
                                              ////////////
                                              //saturday//
                                              ////////////
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: StatefulBuilder(
                                                  builder: (context,
                                                          setState) =>
                                                      MiniSwitchButtonWidget(
                                                    buttonColor: (provider
                                                            .onEvery
                                                            .contains(
                                                                Days.saturday))
                                                        ? const Color.fromARGB(
                                                            255, 79, 249, 113)
                                                        : Colors.grey[300],
                                                    onPressed: () {
                                                      provider
                                                          .switchSaturdayButton();
                                                      setState(() {});
                                                    },
                                                    buttonText: 'Sat',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
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
                                                  {
                                                    provider.editTask(
                                                      currentTask['key'],
                                                      taskController.text,
                                                      descriptionController
                                                          .text,
                                                    );
                                                  }
                                                }
                                                provider
                                                    .refreshTasksSettingsView();
                                                if (context.mounted) {
                                                  Navigator.pop(context);
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
                              ).whenComplete(
                                //menonaktifkan seluruh tombol untuk memilih hari
                                () {
                                  taskController.text = '';
                                  descriptionController.text = '';
                                  provider.onEvery.clear();
                                },
                              );
                            }
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.deleteTask(currentTask['key']);
                            provider.refreshTasksSettingsView();
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
        },
      ),
    );
  }
}
