import 'dart:async';

import 'package:flutter/material.dart';
import 'package:garap/bloc/daily_tasks_cubit.dart';
import 'package:garap/model/daily_tasks_model.dart';
import 'package:garap/widgets/circle_status_widget.dart';
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
    tasksBoxListener = provider.tasksBox.watch().listen((event) {
      provider.refreshTasksSettingsView();
    });
    dayBoxListener = provider.dbDay.watch().listen((event) {});
    super.initState();
  }

  @override
  dispose() {
    taskController.dispose();
    descriptionController.dispose();
    listHoursController.dispose();
    listMinutesController.dispose();
    tasksBoxListener.cancel();
    super.dispose();
  }

  ////////////
  //variable//
  ////////////
  final DailyTasksCubit provider = DailyTasksCubit();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FixedExtentScrollController listHoursController =
      FixedExtentScrollController();
  final FixedExtentScrollController listMinutesController =
      FixedExtentScrollController();
  late final StreamSubscription tasksBoxListener;
  late final StreamSubscription dayBoxListener;
  List<Widget> listHours = () {
    List<Widget> listHours = [];
    for (var i = 0; i <= 23; i++) {
      listHours.add(
        SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: Text(
              '${(i.toString().length > 1) ? i : '0$i'}',
              style: const TextStyle(
                color: Color.fromARGB(255, 23, 23, 23),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return listHours;
  }();
  List<Widget> listMinutes = () {
    List<Widget> listMinutes = [];
    for (var i = 0; i <= 59; i++) {
      listMinutes.add(
        SizedBox(
          width: 30,
          height: 30,
          child: Center(
            child: Text(
              '${(i.toString().length > 1) ? i : '0$i'}',
              style: const TextStyle(
                color: Color.fromARGB(255, 23, 23, 23),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return listMinutes;
  }();

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
                        height: 350,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextField(
                                  maxLength: 30,
                                  controller: taskController,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 23, 23, 23)),
                                  decoration: const InputDecoration(
                                      label: Text(
                                    'Task',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ),
                                //tombol untuk user agar bisa memilih hari apa saja tugas dikerjakan
                                StatefulBuilder(
                                  builder: (context, setState) => Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //////////
                                      //sunday//
                                      //////////
                                      const SizedBox(width: 2),
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
                                      //////////
                                      //monday//
                                      //////////
                                      const SizedBox(width: 2),
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
                                      ///////////
                                      //tuesday//
                                      ///////////
                                      const SizedBox(width: 2),
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
                                      /////////////
                                      //wednesday//
                                      /////////////
                                      const SizedBox(width: 2),
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
                                      ////////////
                                      //thursday//
                                      ////////////
                                      const SizedBox(width: 2),
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
                                      //////////
                                      //friday//
                                      //////////
                                      const SizedBox(width: 2),
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
                                      ////////////
                                      //saturday//
                                      ////////////
                                      const SizedBox(width: 2),
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
                                      const SizedBox(width: 2),
                                      GestureDetector(
                                        onTap: () {
                                          provider.enableAllDay();
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 17,
                                          height: 17,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: !(provider.onEvery
                                                    .containsAll(Days.values))
                                                ? const Color.fromARGB(
                                                    255, 238, 238, 238)
                                                : const Color.fromARGB(
                                                    255, 79, 249, 113),
                                            border: Border.all(
                                              width: 2,
                                              color: const Color.fromRGBO(
                                                  224, 224, 224, 1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 200,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[300],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //memilih jam berapa tugas dikerjakan
                                      SizedBox(
                                        width: 50,
                                        child: ListWheelScrollView(
                                            controller: listHoursController,
                                            physics:
                                                const FixedExtentScrollPhysics(),
                                            itemExtent: 40,
                                            children: listHours),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          ':',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 23, 23, 23),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: ListWheelScrollView(
                                            controller: listMinutesController,
                                            physics:
                                                const FixedExtentScrollPhysics(),
                                            itemExtent: 40,
                                            children: listMinutes),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
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
                                      provider.addTask(
                                        taskController.text,
                                        descriptionController.text,
                                        DateTime.parse(
                                            '0000-00-00 ${(listHoursController.offset / 40).round().toString().length > 1 ? '${(listHoursController.offset / 40).round()}' : '0${(listHoursController.offset / 40).round()}'}:${(listMinutesController.offset / 40).round().toString().length > 1 ? '${(listMinutesController.offset / 40).round()}' : '0${(listMinutesController.offset / 40).round()}'}:00'),
                                      );
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
                              ),
                            ),
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
                    provider.disableAllDay();
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
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' - ${currentTask['description']}'),
                      //menunjukkan hari apa saja tugas akan muncul
                      Row(
                        children: [
                          CircleStatusWidget(
                              color: (currentTask['sunday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Sun'),
                          const SizedBox(width: 3),
                          CircleStatusWidget(
                              color: (currentTask['monday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Mon'),
                          const SizedBox(width: 3),
                          CircleStatusWidget(
                              color: (currentTask['tuesday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Tue'),
                          const SizedBox(width: 3),
                          CircleStatusWidget(
                              color: (currentTask['wednesday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Wed'),
                          const SizedBox(width: 3),
                          CircleStatusWidget(
                              color: (currentTask['thursday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Thu'),
                          const SizedBox(width: 3),
                          CircleStatusWidget(
                              color: (currentTask['friday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Fri'),
                          const SizedBox(width: 3),
                          CircleStatusWidget(
                              color: (currentTask['saturday'])
                                  ? const Color.fromARGB(255, 79, 249, 113)
                                  : Colors.grey[300],
                              text: 'Sat'),
                        ],
                      ),
                      Text(
                        'Do At ${(currentTask['hourDate'].toString().length > 1) ? '${currentTask['hourDate']}' : '0${currentTask['hourDate']}'}:${(currentTask['minuteDate'].toString().length > 1) ? '${currentTask['minuteDate']}' : '0${currentTask['minuteDate']}'}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 80,
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

                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                listHoursController.animateToItem(
                                    currentTask['hourDate'],
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.bounceInOut);
                                listMinutesController.animateToItem(
                                    currentTask['minuteDate'],
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.bounceInOut);
                              },
                            );

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
                                      height: 350,
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 238, 238, 238),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextField(
                                                maxLength: 30,
                                                controller: taskController,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 23, 23, 23)),
                                                decoration:
                                                    const InputDecoration(
                                                        label: Text(
                                                  'Task',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                              TextField(
                                                maxLength: 100,
                                                controller:
                                                    descriptionController,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 23, 23, 23)),
                                                decoration:
                                                    const InputDecoration(
                                                        label: Text(
                                                  'Description',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                              //tombol untuk user agar bisa memilih hari apa saja tugas dikerjakan
                                              StatefulBuilder(
                                                builder: (context, setState) =>
                                                    Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    //////////
                                                    //sunday//
                                                    //////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                      buttonColor: (provider
                                                              .onEvery
                                                              .contains(
                                                                  Days.sunday))
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 79, 249, 113)
                                                          : Colors.grey[300],
                                                      onPressed: () {
                                                        provider
                                                            .switchSundayButton();
                                                        setState(() {});
                                                      },
                                                      buttonText: 'Sun',
                                                    ),
                                                    //////////
                                                    //monday//
                                                    //////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                      buttonColor: (provider
                                                              .onEvery
                                                              .contains(
                                                                  Days.monday))
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 79, 249, 113)
                                                          : Colors.grey[300],
                                                      onPressed: () {
                                                        provider
                                                            .switchMondayButton();
                                                        setState(() {});
                                                      },
                                                      buttonText: 'Mon',
                                                    ),
                                                    ///////////
                                                    //tuesday//
                                                    ///////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                        buttonColor: (provider
                                                                .onEvery
                                                                .contains(Days
                                                                    .tuesday))
                                                            ? const Color
                                                                .fromARGB(255,
                                                                79, 249, 113)
                                                            : Colors.grey[300],
                                                        onPressed: () {
                                                          provider
                                                              .switchTuesdayButton();
                                                          setState(() {});
                                                        },
                                                        buttonText: 'Tue'),
                                                    /////////////
                                                    //wednesday//
                                                    /////////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                        buttonColor: (provider
                                                                .onEvery
                                                                .contains(Days
                                                                    .wednesday))
                                                            ? const Color
                                                                .fromARGB(255,
                                                                79, 249, 113)
                                                            : Colors.grey[300],
                                                        onPressed: () {
                                                          provider
                                                              .switchWednesdayButton();
                                                          setState(() {});
                                                        },
                                                        buttonText: 'Wed'),
                                                    ////////////
                                                    //thursday//
                                                    ////////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                        buttonColor: (provider
                                                                .onEvery
                                                                .contains(Days
                                                                    .thursday))
                                                            ? const Color
                                                                .fromARGB(255,
                                                                79, 249, 113)
                                                            : Colors.grey[300],
                                                        onPressed: () {
                                                          provider
                                                              .switchThursdayButton();
                                                          setState(() {});
                                                        },
                                                        buttonText: 'Thu'),
                                                    //////////
                                                    //friday//
                                                    //////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                        buttonColor: (provider
                                                                .onEvery
                                                                .contains(Days
                                                                    .friday))
                                                            ? const Color
                                                                .fromARGB(255,
                                                                79, 249, 113)
                                                            : Colors.grey[300],
                                                        onPressed: () {
                                                          provider
                                                              .switchFridayButton();
                                                          setState(() {});
                                                        },
                                                        buttonText: 'Fri'),
                                                    ////////////
                                                    //saturday//
                                                    ////////////
                                                    const SizedBox(width: 2),
                                                    MiniSwitchButtonWidget(
                                                      buttonColor: (provider
                                                              .onEvery
                                                              .contains(
                                                                  Days
                                                                      .saturday))
                                                          ? const Color
                                                              .fromARGB(
                                                              255, 79, 249, 113)
                                                          : Colors.grey[300],
                                                      onPressed: () {
                                                        provider
                                                            .switchSaturdayButton();
                                                        setState(() {});
                                                      },
                                                      buttonText: 'Sat',
                                                    ),
                                                    const SizedBox(width: 2),
                                                    GestureDetector(
                                                      onTap: () {
                                                        provider.enableAllDay();
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 17,
                                                        height: 17,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: !(provider
                                                                  .onEvery
                                                                  .containsAll(Days
                                                                      .values))
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  238, 238, 238)
                                                              : const Color
                                                                  .fromARGB(255,
                                                                  79, 249, 113),
                                                          border: Border.all(
                                                            width: 2,
                                                            color: const Color
                                                                .fromRGBO(224,
                                                                224, 224, 1),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                width: 200,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey[300],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    //memilih jam berapa tugas dikerjakan
                                                    SizedBox(
                                                      width: 50,
                                                      child: ListWheelScrollView(
                                                          controller:
                                                              listHoursController,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          itemExtent: 40,
                                                          children: listHours),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Text(
                                                        ':',
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 23, 23, 23),
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 50,
                                                      child: ListWheelScrollView(
                                                          controller:
                                                              listMinutesController,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          itemExtent: 40,
                                                          children:
                                                              listMinutes),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 68, 68, 68),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (taskController
                                                      .text.isNotEmpty) {
                                                    provider.editTask(
                                                      currentTask['key'],
                                                      taskController.text,
                                                      descriptionController
                                                          .text,
                                                      DateTime.parse(
                                                          '0000-00-00 ${(listHoursController.offset / 40).round().toString().length > 1 ? '${(listHoursController.offset / 40).round()}' : '0${(listHoursController.offset / 40).round()}'}:${(listMinutesController.offset / 40).round().toString().length > 1 ? '${(listMinutesController.offset / 40).round()}' : '0${(listMinutesController.offset / 40).round()}'}:00'),
                                                    );
                                                    provider
                                                        .refreshTasksSettingsView();
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
                                            ),
                                          ),
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
                                  provider.disableAllDay();
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
