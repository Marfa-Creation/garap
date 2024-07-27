import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/daily_tasks_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DailyTasksCubit extends Cubit<DailyTasksModel> {
  DailyTasksCubit()
      : super(
          DailyTasksModel(
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

  set onEvery(Set<Days> value) {
    emit(
      state.copyWith(onEvery: value),
    );
  }

  set isDispose(bool value) {
    emit(state.copyWith(isDispose: value));
  }

  //////////
  //method//
  //////////
  
  void clearButtonConditions(){
    state.copyWith(onEvery: state.onEvery.toSet()..clear());
  }

  void switchSundayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.sunday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.sunday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..remove(Days.sunday)));
    }
  }

  void switchMondayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.monday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.monday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..remove(Days.monday)));
    }
  }

  void switchTuesdayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.tuesday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.tuesday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(
          state.copyWith(onEvery: state.onEvery.toSet()..remove(Days.tuesday)));
    }
  }

  void switchWednesdayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.wednesday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.wednesday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(state.copyWith(
          onEvery: state.onEvery.toSet()..remove(Days.wednesday)));
    }
  }

  void switchThursdayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.thursday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.thursday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(state.copyWith(
          onEvery: state.onEvery.toSet()..remove(Days.thursday)));
    }
  }

  void switchFridayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.friday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.friday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..remove(Days.friday)));
    }
  }

  void switchSaturdayButton() {
    //jika tombol sedang dalam kondisi mati, maka if dijalankan
    if (state.onEvery.contains(Days.saturday) == false) {
      emit(state.copyWith(onEvery: state.onEvery.toSet()..add(Days.saturday)));
      //jika tombol sedang dalam kondisi menyala, maka else dijalankan
    } else {
      emit(state.copyWith(
          onEvery: state.onEvery.toSet()..remove(Days.saturday)));
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
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    emit(state.copyWith(tasksView: data.reversed.toList()));
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

    state.tasksView.sort((now, next) {
      var a = (now['status']) ? 1 : 0;
      var b = (next['status']) ? 1 : 0;
      return a.compareTo(b);
    });
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
          };
        })
        .cast<Map<String, dynamic>>()
        .toList();

    emit(state.copyWith(tasksSettingsView: data.reversed.toList()));
  }

  void updateDay() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        // print('day periodic run');
        if (state.isDispose == true) {
          timer.cancel();
        } else {
          emit(state.copyWith(day: DateFormat('EEEE').format(DateTime.now())));
        }
      },
    );
  }

  void updateDbDay() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.isDispose == true) {
          timer.cancel();
        } else {
          state.dbDay.put('day_box', DateFormat('EEEE').format(DateTime.now()));
        }
      },
    );
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
      },
    );
  }

  void editTask(
    int itemKey,
    String taskName,
    String description,
  ) {
    Map<String, dynamic> data = {
      'status': state.tasksBox.getAt(itemKey)['status'],
      'task': taskName,
      'description': description,
      'sunday': state.onEvery.contains(Days.sunday),
      'monday': state.onEvery.contains(Days.monday),
      'tuesday': state.onEvery.contains(Days.tuesday),
      'wednesday': state.onEvery.contains(Days.wednesday),
      'thursday': state.onEvery.contains(Days.thursday),
      'friday': state.onEvery.contains(Days.friday),
      'saturday': state.onEvery.contains(Days.saturday),
    };
    state.tasksBox.put(itemKey, data);
  }

  void addTask(
    String taskName,
    String description,
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
    };

    await state.tasksBox.add(data);
  }

  void deleteTask(int itemKey) async {
    await state.tasksBox.delete(itemKey);
  }
}
