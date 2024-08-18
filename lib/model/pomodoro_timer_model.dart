import 'package:flutter/widgets.dart';

@immutable
class PomodoroTimerModel {
  const PomodoroTimerModel({
    required this.timerSeconds,
    required this.isTimerRun,
    required this.isTimerPause,
    required this.isDispose,
    required this.loadingBar,
    required this.section,
    required this.timerMinutes,
  });

  final int timerSeconds;
  final int timerMinutes;
  final bool isTimerRun;
  final bool isTimerPause;
  final bool isDispose;
  final double loadingBar;
  final PomodoroSection section;

  PomodoroTimerModel copyWith({
    int? timerSeconds,
    int? timerMinutes,
    int? timerHours,
    bool? isTimerRun,
    bool? isTimerPause,
    bool? isDispose,
    double? loadingBar,
    PomodoroSection? section,
  }) {
    return PomodoroTimerModel(
      timerSeconds: timerSeconds ?? this.timerSeconds,
      isTimerRun: isTimerRun ?? this.isTimerRun,
      isTimerPause: isTimerPause ?? this.isTimerPause,
      isDispose: isDispose ?? this.isDispose,
      loadingBar: loadingBar ?? this.loadingBar,
      section: section ?? this.section,
      timerMinutes: timerMinutes ?? this.timerMinutes,
    );
  }
}

enum PomodoroSection { focus, shortBreak, longBreak }
