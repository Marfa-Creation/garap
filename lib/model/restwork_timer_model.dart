import 'package:flutter/material.dart';

@immutable
class RestworkTimerModel {
  ///////////////
  //constructor//
  ///////////////
  const RestworkTimerModel({
    required this.timerSeconds,
    required this.timerMinutes,
    required this.timerHours,
    required this.breakRatio,
    required this.isTimerIncrease,
    required this.isTimerDecrease,
    required this.isTimerRun,
    required this.isTimerPause,
    required this.isDispose,
    required this.audioMode,
    required this.status,
  });

  ////////////
  //Variable//
  ////////////
  final int timerSeconds;
  final int timerMinutes;
  final int timerHours;
  final int breakRatio;
  final bool isTimerIncrease;
  final bool isTimerDecrease;
  final bool isTimerRun;
  final bool isTimerPause;
  final bool isDispose;
  final bool audioMode;
  final String status;

  RestworkTimerModel copyWith({
    int? timerSeconds,
    int? timerMinutes,
    int? timerHours,
    int? breakRatio,
    bool? isTimerIncrease,
    bool? isTimerDecrease,
    bool? isTimerRun,
    bool? isTimerPause,
    bool? isDispose,
    bool? audioMode,
    String? status,
  }) {
    return RestworkTimerModel(
      timerSeconds: timerSeconds ?? this.timerSeconds,
      timerMinutes: timerMinutes ?? this.timerMinutes,
      timerHours: timerHours ?? this.timerHours,
      breakRatio: breakRatio ?? this.breakRatio,
      isTimerIncrease: isTimerIncrease ?? this.isTimerIncrease,
      isTimerDecrease: isTimerDecrease ?? this.isTimerDecrease,
      isTimerRun: isTimerRun ?? this.isTimerRun,
      isTimerPause: isTimerPause ?? this.isTimerPause,
      isDispose: isDispose ?? this.isDispose,
      audioMode: audioMode ?? this.audioMode,
      status: status ?? this.status,
    );
  }
}
