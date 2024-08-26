import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/daily_tasks_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DailyTasksCubit extends Cubit<DailyTasksModel> {
  DailyTasksCubit()
      : super(
          DailyTasksModel(
            dateTimeTask: DateTime(DateTime.now().year),
            tasksSettingsView: const [],
            tasksView: const [],
            day: DateFormat('EEEE').format(DateTime.now()),
            onEvery: const {},
            isDispose: false,
          ),
        );

  //////////
  //getter//
  //////////
  Box<dynamic> get tasksBox => state.tasksBox;
  String get day => state.day;
  Box<dynamic> get dbDay => state.dbDay;
  bool get isDispose => state.isDispose;
  List<Map<String, dynamic>> get tasksView => state.tasksView;
  List<Map<String, dynamic>> get tasksSettingsView => state.tasksSettingsView;
  Set<Days> get onEvery => state.onEvery;

  //////////
  //setter//
  //////////

  set onEvery(Set<Days> value) => emit(state.copyWith(onEvery: value));
  set isDispose(bool value) => emit(state.copyWith(isDispose: value));

  //////////
  //method//
  //////////

  //ambil data dari DB, convert menjadi Set<Days>, sehingga tombol akan menyesuaikan dengan Set<Days>
  //contoh:
  //data dari DB menunjukkan tugas `A` akan muncul pada hari senin dan kamis,
  //maka tombol senin dan kamis akan menyala.
  void restoreDayFromDB(Map<String, dynamic> currentTask) {
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

    emit(state.copyWith(onEvery: days));
  }

  void enableAllDay() {
    emit(state.copyWith(onEvery: Days.values.toSet()));
  }

  void disableAllDay() {
    emit(state.copyWith(onEvery: state.onEvery.toSet()..clear()));
  }

  void switchDayButton(Days day) {
    switch (day) {
      //sunday
      case Days.sunday:
        if (state.onEvery.contains(Days.sunday) == false) {
          emit(
              state.copyWith(onEvery: state.onEvery.toSet()..add(Days.sunday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.sunday)));
        }
        break;
      //monday
      case Days.monday:
        if (state.onEvery.contains(Days.monday) == false) {
          emit(
              state.copyWith(onEvery: state.onEvery.toSet()..add(Days.monday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.monday)));
        }
        break;
      //tuesday
      case Days.tuesday:
        if (state.onEvery.contains(Days.tuesday) == false) {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..add(Days.tuesday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.tuesday)));
        }
        break;
      //wednesday
      case Days.wednesday:
        if (state.onEvery.contains(Days.wednesday) == false) {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..add(Days.wednesday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.wednesday)));
        }
        break;
      //thursday
      case Days.thursday:
        if (state.onEvery.contains(Days.thursday) == false) {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..add(Days.thursday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.thursday)));
        }
        break;
      //friday
      case Days.friday:
        if (state.onEvery.contains(Days.friday) == false) {
          emit(
              state.copyWith(onEvery: state.onEvery.toSet()..add(Days.friday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.friday)));
        }
        break;
      //saturday
      case Days.saturday:
        if (state.onEvery.contains(Days.saturday) == false) {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..add(Days.saturday)));
        } else {
          emit(state.copyWith(
              onEvery: state.onEvery.toSet()..remove(Days.saturday)));
        }
        break;
    }
  }

  void refreshTasksView() {
    final List<Map<String, dynamic>> data = state.tasksBox.keys
        .map((key) {
          final item = state.tasksBox.get(key);
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
            'hourDate': item['hourDate'],
            'minuteDate': item['minuteDate'],
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    emit(state.copyWith(tasksView: data.reversed.toList()));

    //filter untuk hanya mengambil tugas yang sesuai pada hari ini
    //contoh:
    //status `sunday` pada data tugas pada DB adalah true,
    //maka tugas tersebut akan diambil jika hari ini adalah minggu
    emit(
      state.copyWith(
        tasksView: state.tasksView.where((element) {
          switch (state.day.toLowerCase()) {
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
        }).toList(),
      ),
    );
    //sortir berdasarkan waktu tugas dikerjakan
    emit(
      state.copyWith(
        tasksView: state.tasksView
          ..sort(
            (now, next) {
              return ((now['hourDate'] * 100 + now['minuteDate']) as int) -
                  ((next['hourDate'] * 100 + next['minuteDate']) as int);
            },
          ),
      ),
    );

    //sortir berdasarkan status tugas, yang sudah selesai akan ditaruh pada poisis paling bawah
    emit(
      state.copyWith(
        tasksView: state.tasksView
          ..sort(
            (now, next) {
              final int a = (now['status']) ? 1 : 0;
              final int b = (next['status']) ? 1 : 0;
              return a.compareTo(b);
            },
          ),
      ),
    );
  }

  void refreshTasksSettingsView() {
    final List<Map<String, dynamic>> data = state.tasksBox.keys
        .map((key) {
          final item = state.tasksBox.get(key);
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
            'hourDate': item['hourDate'],
            'minuteDate': item['minuteDate'],
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    emit(state.copyWith(tasksSettingsView: data.reversed.toList()));
    //sortir berdasarkan waktu tugas dikerjakan
    emit(
      state.copyWith(
        tasksSettingsView: state.tasksSettingsView
          ..sort(
            (now, next) {
              return ((now['hourDate'] * 100 + now['minuteDate']) as int) -
                  ((next['hourDate'] * 100 + next['minuteDate']) as int);
            },
          ),
      ),
    );
  }

  Future<void> checkIsDayChanged() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (isDispose == true) {
        timer.cancel();
      } else {
        //update hari apa sekarang
        emit(state.copyWith(day: DateFormat('EEEE').format(DateTime.now())));

        //bandingan dengan hari pada database, jika berbeda(yang berarti ada pergantian hari), tugas akan di refresh
        if (state.day != state.dbDay.get('day_box')) {
          state.dbDay.put('day_box', DateFormat('EEEE').format(DateTime.now()));
          for (var i = 0; i < state.tasksBox.length; i++) {
            state.tasksBox.putAt(i, {
              'status': false,
              'task': state.tasksBox.getAt(i)['task'],
              'description': state.tasksBox.getAt(i)['description'],
              'sunday': state.tasksBox.getAt(i)['sunday'],
              'monday': state.tasksBox.getAt(i)['monday'],
              'tuesday': state.tasksBox.getAt(i)['tuesday'],
              'wednesday': state.tasksBox.getAt(i)['wednesday'],
              'thursday': state.tasksBox.getAt(i)['thursday'],
              'friday': state.tasksBox.getAt(i)['friday'],
              'saturday': state.tasksBox.getAt(i)['saturday'],
              'hourDate': state.tasksBox.getAt(i)['hourDate'],
              'minuteDate': state.tasksBox.getAt(i)['minuteDate'],
            });
          }
        }
        await state.dbDay
            .put('day_box', DateFormat('EEEE').format(DateTime.now()));
      }
    });
  }

  void switchTaskStatus(Map<String, dynamic> data) {
    state.tasksBox.put(
      data['key'],
      {
        'status': !data['status'],
        'task': data['task'],
        'description': data['description'],
        'sunday': data['sunday'],
        'monday': data['monday'],
        'tuesday': data['tuesday'],
        'wednesday': data['wednesday'],
        'thursday': data['thursday'],
        'friday': data['friday'],
        'saturday': data['saturday'],
        'hourDate': data['hourDate'],
        'minuteDate': data['minuteDate'],
      },
    );
  }

  void editTask(
    int itemKey,
    String taskName,
    String description,
    DateTime dateTimeTask,
  ) {
    Map<String, dynamic> data = {
      'status': state.tasksBox.get(itemKey)['status'],
      'task': taskName,
      'description': description,
      'sunday': state.onEvery.contains(Days.sunday),
      'monday': state.onEvery.contains(Days.monday),
      'tuesday': state.onEvery.contains(Days.tuesday),
      'wednesday': state.onEvery.contains(Days.wednesday),
      'thursday': state.onEvery.contains(Days.thursday),
      'friday': state.onEvery.contains(Days.friday),
      'saturday': state.onEvery.contains(Days.saturday),
      'hourDate': dateTimeTask.hour,
      'minuteDate': dateTimeTask.minute,
    };
    state.tasksBox.put(itemKey, data);
  }

  void addTask(
    String taskName,
    String description,
    DateTime dateTimeTask,
  ) async {
    final Map<String, dynamic> data = {
      'status': false,
      'task': taskName,
      'description': description,
      'sunday': state.onEvery.contains(Days.sunday),
      'monday': state.onEvery.contains(Days.monday),
      'tuesday': state.onEvery.contains(Days.tuesday),
      'wednesday': state.onEvery.contains(Days.wednesday),
      'thursday': state.onEvery.contains(Days.thursday),
      'friday': state.onEvery.contains(Days.friday),
      'saturday': state.onEvery.contains(Days.saturday),
      'hourDate': dateTimeTask.hour,
      'minuteDate': dateTimeTask.minute,
    };

    await state.tasksBox.add(data);
  }

  void deleteTask(int itemKey) async {
    await state.tasksBox.delete(itemKey);
  }
}
