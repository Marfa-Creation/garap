import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/timer_model.dart';

class TimerCubit extends Cubit<TimerModel> {
  TimerCubit() : super(const TimerModel());
  //////////
  //setter//
  //////////

  set isDispose(bool value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: value, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set audioMode(bool value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: value, //11
        status: state.status, //12
      ),
    );
  }

  set breakRatio(int value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: value, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set isTimerIncrease(bool value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: value, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set isTimerDecrease(bool value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: value, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set isTimerPause(bool value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: value, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set isTimerRun(bool value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: value, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9

        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set status(String value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9

        audioMode: state.audioMode, //11
        status: value, //12
      ),
    );
  }

  set timerSeconds(int value) {
    emit(
      TimerModel(
        timerSeconds: value, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set timerMinutes(int value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: value, //2
        timerHours: state.timerHours, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  set timerHours(int value) {
    emit(
      TimerModel(
        timerSeconds: state.timerSeconds, //1
        timerMinutes: state.timerMinutes, //2
        timerHours: value, //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  //////////
  //getter//
  //////////
  bool get audioMode => state.audioMode;
  int get breakRatio => state.breakRatio;
  bool get isTimerIncrease => state.isTimerIncrease;
  bool get isTimerDecrease => state.isTimerDecrease;
  bool get isTimerPause => state.isTimerPause;
  bool get isTimerRun => state.isTimerRun;
  String get status => state.status;
  int get timerSeconds => state.timerSeconds;
  int get timerMinutes => state.timerMinutes;
  int get timerHours => state.timerHours;

  String setStatus() {
    if (state.isTimerPause == true) {
      return 'Paused';
    } else if ((state.isTimerIncrease == true ||
            state.isTimerDecrease == false) &&
        state.isTimerRun == true) {
      return 'Working Time';
    } else if ((state.isTimerIncrease == false ||
            state.isTimerDecrease == true) &&
        state.isTimerRun == true) {
      return 'Breaking Time';
    } else {
      return 'Idle';
    }
  }
  //////////
  //method//
  //////////

  void increaseTime() {
    final AudioPlayer tickSound = AudioPlayer();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //cancel timer
      if (state.isDispose == true) {
        timer.cancel();
      }
      //increase timer
      if (state.isTimerIncrease == true &&
          state.isTimerDecrease == false &&
          state.isTimerRun == true &&
          state.isTimerPause == false) {
        if (state.audioMode == true) {
          tickSound.play(AssetSource('tick_sound.mp3'));
        }
        emit(
          TimerModel(
            timerSeconds: state.timerSeconds + 1, //1
            timerMinutes: state.timerMinutes, //2
            timerHours: state.timerHours, //3
            breakRatio: state.breakRatio, //4
            isTimerIncrease: state.isTimerIncrease, //5
            isTimerDecrease: state.isTimerDecrease, //6
            isTimerRun: state.isTimerRun, //7
            isTimerPause: state.isTimerPause, //8
            isDispose: state.isDispose, //9
            audioMode: state.audioMode, //11
            status: 'Working Time', //12
          ),
        );
        if (state.timerSeconds == 60) {
          emit(
            TimerModel(
              timerSeconds: 0, //1
              timerMinutes: state.timerMinutes + 1, //2
              timerHours: state.timerHours, //3
              breakRatio: state.breakRatio, //4
              isTimerIncrease: state.isTimerIncrease, //5
              isTimerDecrease: state.isTimerDecrease, //6
              isTimerRun: state.isTimerRun, //7
              isTimerPause: state.isTimerPause, //8
              isDispose: state.isDispose, //9
              audioMode: state.audioMode, //11
              status: state.status, //12
            ),
          );
        }
        if (state.timerMinutes == 60) {
          emit(
            TimerModel(
              timerSeconds: state.timerSeconds, //1
              timerMinutes: 0, //2
              timerHours: state.timerHours + 1, //3
              breakRatio: state.breakRatio, //4
              isTimerIncrease: state.isTimerIncrease, //5
              isTimerDecrease: state.isTimerDecrease, //6
              isTimerRun: state.isTimerRun, //7
              isTimerPause: state.isTimerPause, //8
              isDispose: state.isDispose, //9
              audioMode: state.audioMode, //11
              status: state.status, //12
            ),
          );
        }
      }
    });
  }

  void decreaseTime(BuildContext context) {
    final AudioPlayer tickSound = AudioPlayer();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        //cancel timer
        if (state.isDispose == true) {
          timer.cancel();
        }

        //decrease timer
        if (state.isTimerIncrease == false &&
            state.isTimerDecrease == true &&
            state.isTimerRun == true &&
            state.isTimerPause == false) {
          emit(
            TimerModel(
              timerSeconds: state.timerSeconds, //1
              timerMinutes: state.timerMinutes, //2
              timerHours: state.timerHours, //3
              breakRatio: state.breakRatio, //4
              isTimerIncrease: state.isTimerIncrease, //5
              isTimerDecrease: state.isTimerDecrease, //6
              isTimerRun: state.isTimerRun, //7
              isTimerPause: state.isTimerPause, //8
              isDispose: state.isDispose, //9
              audioMode: state.audioMode, //11
              status: 'Breaking Time', //12
            ),
          );

          if (state.timerHours == 0 &&
              state.timerMinutes == 0 &&
              state.timerSeconds == 0) {
            _playAlarm(context);
          }
          if (state.timerSeconds > 0 ||
              state.timerMinutes > 0 ||
              state.timerHours > 0) {
            if (state.audioMode == true) {
              tickSound.play(AssetSource('tick_sound.mp3'));
            }
            emit(
              TimerModel(
                timerSeconds: state.timerSeconds - 1, //1
                timerMinutes: state.timerMinutes, //2
                timerHours: state.timerHours, //3
                breakRatio: state.breakRatio, //4
                isTimerIncrease: state.isTimerIncrease, //5
                isTimerDecrease: state.isTimerDecrease, //6
                isTimerRun: state.isTimerRun, //7
                isTimerPause: state.isTimerPause, //8
                isDispose: state.isDispose, //9
                audioMode: state.audioMode, //11
                status: state.status, //12
              ),
            );
          }
          if (state.timerSeconds < 0) {
            emit(
              TimerModel(
                timerSeconds: 59, //1
                timerMinutes: state.timerMinutes - 1, //2
                timerHours: state.timerHours, //3
                breakRatio: state.breakRatio, //4
                isTimerIncrease: state.isTimerIncrease, //5
                isTimerDecrease: state.isTimerDecrease, //6
                isTimerRun: state.isTimerRun, //7
                isTimerPause: state.isTimerPause, //8
                isDispose: state.isDispose, //9
                audioMode: state.audioMode, //11
                status: state.status, //12
              ),
            );
          }
          if (state.timerMinutes < 0) {
            emit(
              TimerModel(
                timerSeconds: state.timerSeconds, //1
                timerMinutes: 59, //2
                timerHours: state.timerHours - 1, //3
                breakRatio: state.breakRatio, //4
                isTimerIncrease: state.isTimerIncrease, //5
                isTimerDecrease: state.isTimerDecrease, //6
                isTimerRun: state.isTimerRun, //7
                isTimerPause: state.isTimerPause, //8
                isDispose: state.isDispose, //9
                audioMode: state.audioMode, //11
                status: state.status, //12
              ),
            );
          }
        }
        emit(
          TimerModel(
            timerSeconds: state.timerSeconds, //1
            timerMinutes: state.timerMinutes, //2
            timerHours: state.timerHours, //3
            breakRatio: state.breakRatio, //4
            isTimerIncrease: state.isTimerIncrease, //5
            isTimerDecrease: state.isTimerDecrease, //6
            isTimerRun: state.isTimerRun, //7
            isTimerPause: state.isTimerPause, //8
            isDispose: state.isDispose, //9
            audioMode: state.audioMode, //11
            status: state.status, //12
          ),
        );
      },
    );
  }

  void setBreakTime() {
    double hours = state.timerHours.toDouble();
    double minutes = state.timerMinutes.toDouble();
    double seconds = state.timerSeconds.toDouble();

    minutes += hours * 60;
    seconds += minutes * 60;

    seconds /= state.breakRatio;

    minutes = seconds / 60;
    hours = minutes / 60;
    
    emit(
      TimerModel(
        timerSeconds: (seconds % 60).toInt(), //1
        timerMinutes: minutes.toInt(), //2
        timerHours: hours.toInt(), //3
        breakRatio: state.breakRatio, //4
        isTimerIncrease: state.isTimerIncrease, //5
        isTimerDecrease: state.isTimerDecrease, //6
        isTimerRun: state.isTimerRun, //7
        isTimerPause: state.isTimerPause, //8
        isDispose: state.isDispose, //9
        audioMode: state.audioMode, //11
        status: state.status, //12
      ),
    );
  }

  void _playAlarm(BuildContext context) {
    final AudioPlayer timeEndSound = AudioPlayer();
    if (state.isTimerRun == true &&
        (state.isTimerIncrease == false || state.isTimerDecrease == true) &&
        (state.timerSeconds == 0 &&
            state.timerMinutes == 0 &&
            state.timerHours == 0)) {
      timeEndSound.play(AssetSource('digital_alarm.mp3'));
      // state.isTimerPause = true;
      // state.iconController.forward();

      emit(
        TimerModel(
          timerSeconds: state.timerSeconds, //1
          timerMinutes: state.timerMinutes, //2
          timerHours: state.timerHours, //3
          breakRatio: state.breakRatio, //4
          isTimerIncrease: state.isTimerIncrease, //5
          isTimerDecrease: state.isTimerDecrease, //6
          isTimerRun: state.isTimerRun, //7
          isTimerPause: true, //8
          isDispose: state.isDispose, //9
          audioMode: state.audioMode, //11
          status: state.status, //12
        ),
      );
      emit(
        TimerModel(
          timerSeconds: state.timerSeconds, //1
          timerMinutes: state.timerMinutes, //2
          timerHours: state.timerHours, //3
          breakRatio: state.breakRatio, //4
          isTimerIncrease: state.isTimerIncrease, //5
          isTimerDecrease: state.isTimerDecrease, //6
          isTimerRun: state.isTimerRun, //7
          isTimerPause: state.isTimerPause, //8
          isDispose: state.isDispose, //9
          audioMode: state.audioMode, //11
          status: state.status, //12
        ),
      );
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                border: Border.all(color: Colors.black, width: 0.5)),
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text(
                    'Break Time is Over',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ).whenComplete(
        () {
          timeEndSound.stop();
          emit(
            TimerModel(
              timerSeconds: state.timerSeconds, //1
              timerMinutes: state.timerMinutes, //2
              timerHours: state.timerHours, //3
              breakRatio: state.breakRatio, //4
              isTimerIncrease: true, //5
              isTimerDecrease: false, //6
              isTimerRun: state.isTimerRun, //7
              isTimerPause: false, //8
              isDispose: state.isDispose, //9
              audioMode: state.audioMode, //11
              status: state.status, //12
            ),
          );
        },
      );
    }
  }
}
