import 'package:flutter/material.dart';

@immutable
class TimerModel {
  ///////////////
  //constructor//
  ///////////////
  const TimerModel({
    this.timerSeconds = 0, //1
    this.timerMinutes = 0, //2
    this.timerHours = 0, //3
    this.breakRatio = 1, //4
    this.isTimerIncrease = false, //5
    this.isTimerDecrease = false, //6
    this.isTimerRun = false, //7
    this.isTimerPause = false, //8
    this.isDispose = false, //9
    this.audioMode = true, //11
    this.status = 'Idle', //12
  });

  ////////////
  //Variable//
  ////////////
  final int timerSeconds; //1
  final int timerMinutes; //2
  final int timerHours; //3
  final int breakRatio; //4
  final bool isTimerIncrease; //5
  final bool isTimerDecrease; //6
  final bool isTimerRun; //7
  final bool isTimerPause; //8
  final bool isDispose; //9
  final bool audioMode; //11
  //UI/UX
  final String status;


}
