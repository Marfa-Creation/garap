import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/pomodoro_timer_model.dart';

class PomodoroTimerCubit extends Cubit<PomodoroTimerModel> {
  PomodoroTimerCubit()
      : super(const PomodoroTimerModel(
          timerMinutes: 25,
          timerSeconds: 0,
          isTimerPause: false,
          isDispose: false,
          isTimerRun: false,
          loadingBar: 250,
          section: PomodoroSection.focus,
        ));

  //////////
  //getter//
  //////////
  bool get isTimerRun => state.isTimerRun;
  bool get isDispose => state.isDispose;
  int get timerSeconds => state.timerSeconds;
  int get timerMinutes => state.timerMinutes;
  double get loadingBar => state.loadingBar;
  PomodoroSection get section => state.section;
  bool get isTimerPause => state.isTimerPause;

  //////////
  //setter//
  //////////
  set isDispose(bool value) => emit(state.copyWith(isDispose: value));
  set isTimerPause(bool value) => emit(state.copyWith(isTimerPause: value));
  set section(PomodoroSection value) => emit(state.copyWith(section: value));
  set timerSeconds(int value) => emit(state.copyWith(timerSeconds: value));
  set timerMinutes(int value) => emit(state.copyWith(timerMinutes: value));

  //////////
  //method//
  //////////

  void resetTimer() {
    emit(state.copyWith(
      timerSeconds: 0,
      timerMinutes: (state.section == PomodoroSection.focus)
          ? 25
          : (state.section == PomodoroSection.shortBreak)
              ? 5
              : 15,
      isTimerPause: false,
      isDispose: true,
      isTimerRun: false,
      loadingBar: 250,
    ));
  }

  Future<void> startTimer(
    BuildContext context,
    Future<void> Function() onEndOfSection,
  ) async {
    emit(state.copyWith(isDispose: false, isTimerRun: true));
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        final double loadingBar = () {
          int timerSeconds = (state.timerMinutes * 60) + state.timerSeconds;
          switch (state.section) {
            case PomodoroSection.focus:
              return ((timerSeconds - 1) / 1500) * 250;
            case PomodoroSection.shortBreak:
              return ((timerSeconds - 1) / 300) * 250;
            case PomodoroSection.longBreak:
              return ((timerSeconds - 1) / 900) * 250;
          }
        }();
        //pembatalan Timer.periodic dispose
        if (state.isDispose == true) {
          timer.cancel();
          //pembatalan Timer.periodic ketika timer sudah habis
        } else if ((state.timerSeconds <= 0 && state.timerMinutes <= 0) ||
            state.loadingBar <= 0) {
          onEndOfSection();
          resetTimer();
          //pengurangan timer
        } else {
          if (state.isTimerRun == true && state.isTimerPause == false) {
            //jika kondisi terpenuhi, maka akan mulai mengurangi nilai antara detik, menit, dan jam
            //kurangi nilai detik
            emit(state.copyWith(
                timerSeconds: state.timerSeconds - 1, loadingBar: loadingBar));
            //untuk mengurangi nilai menit dan set nilai detik ke `59`
            if (state.timerSeconds < 0) {
              emit(
                state.copyWith(
                    timerSeconds: 59,
                    timerMinutes: state.timerMinutes - 1,
                    loadingBar: loadingBar),
              );
            }
          }
        }
      },
    );
  }
}
