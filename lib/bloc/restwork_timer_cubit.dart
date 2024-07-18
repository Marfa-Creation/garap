import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/model/restwork_timer_model.dart';

class RestworkTimerCubit extends Cubit<RestworkTimerModel> {
  RestworkTimerCubit()
      : super(
          const RestworkTimerModel(
            timerSeconds: 0,
            timerMinutes: 0,
            timerHours: 0,
            breakRatio: 1,
            isTimerIncrease: false,
            isTimerDecrease: false,
            isTimerRun: false,
            isTimerPause: false,
            isDispose: false,
            audioMode: true,
            status: 'Idle',
          ),
        );
  //////////
  //setter//
  //////////

  set isDispose(bool value) {
    emit(
      state.copyWith(
        isDispose: value,
      ),
    );
  }

  set audioMode(bool value) {
    emit(
      state.copyWith(
        audioMode: value,
      ),
    );
  }

  set breakRatio(int value) {
    emit(
      state.copyWith(breakRatio: value),
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

  //////////
  //method//
  //////////

  //
  void bugTesting() {
    emit(
      state.copyWith(
        timerSeconds: 55,
        timerMinutes: 59,
        timerHours: 23,
      ),
    );
  }

  void playPauseButton() {
    //jika timer pertama kali di mulai atau selesai di reset
    if (state.isTimerRun == false) {
      emit(
        state.copyWith(
          isTimerRun: true,
          isTimerIncrease: true,
          isTimerDecrease: false,
          isTimerPause: false,
          status: 'Working Time',
        ),
      );
    } else if (state.isTimerRun == true &&
        (state.isTimerIncrease == false && state.isTimerDecrease == true) &&
        state.isTimerPause == false) {
      emit(
        state.copyWith(
          isTimerPause: true,
          status: 'Paused',
        ),
      );
    } else if (state.isTimerRun == true &&
        (state.isTimerIncrease == true && state.isTimerDecrease == false) &&
        state.isTimerPause == false) {
      emit(
        state.copyWith(
          isTimerPause: true,
          status: 'Paused',
        ),
      );
    } else if (state.isTimerRun == true &&
        (state.isTimerIncrease == false && state.isTimerDecrease == true) &&
        state.isTimerPause == true) {
      emit(
        state.copyWith(
          isTimerPause: false,
          status: 'Breaking Time',
        ),
      );
    } else if (state.isTimerRun == true &&
        (state.isTimerIncrease == true && state.isTimerDecrease == false) &&
        state.isTimerPause == true) {
      emit(
        state.copyWith(
          isTimerPause: false,
          status: 'Working Time',
        ),
      );
    } else {}
  }

  void breakButton() {
    if (state.isTimerIncrease == true && state.isTimerDecrease == false) {
      setBreakTime();
      emit(
        state.copyWith(
          isTimerIncrease: false,
          isTimerDecrease: true,
          isTimerPause: false,
          status: 'Breaking Time',
        ),
      );
    }
  }

  void resetButton() {
    emit(
      state.copyWith(
        isTimerRun: false,
        isTimerIncrease: false,
        isTimerDecrease: false,
        isTimerPause: false,
        status: 'Idle',
        timerSeconds: 0,
        timerMinutes: 0,
        timerHours: 0,
      ),
    );
  }

  void increaseTime(void Function() resetController, BuildContext context) {
    final AudioPlayer tickSound = AudioPlayer();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //cancel timer
      if (state.isDispose == true) {
        timer.cancel();
      }

      if (state.timerHours >= 24) {
        askForReset(context).whenComplete(
          () {
            resetButton();
            resetController();
          },
        );
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
          state.copyWith(
            timerSeconds: state.timerSeconds + 1,
          ),
        );
        if (state.timerSeconds == 60) {
          emit(state.copyWith(
            timerSeconds: 0,
            timerMinutes: state.timerMinutes + 1,
          ));
        }
        if (state.timerMinutes == 60) {
          emit(
            state.copyWith(
              timerMinutes: 0,
              timerHours: state.timerHours + 1,
            ),
          );
        }
      }
    });
  }

  Future<void> askForReset(BuildContext context) async {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1 / 2,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 23, 23, 23),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Did you forget about your timer? we\'ll reset it for you.',
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 238, 238),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
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
          if (state.timerHours == 0 &&
              state.timerMinutes == 0 &&
              state.timerSeconds == 0) {
            _playAlarm(context);
          }
          //jika kondisi terpenuhi, maka akan mulai mengurangi nilai antara detik, menit, dan jam
          if (state.timerSeconds > 0 ||
              state.timerMinutes > 0 ||
              state.timerHours > 0) {
            //bunyikan suara detik jam jika user meminta
            if (state.audioMode == true) {
              tickSound.play(AssetSource('tick_sound.mp3'));
            }

            //kurangi nilai detik
            emit(
              state.copyWith(
                timerSeconds: state.timerSeconds - 1,
              ),
            );
            //untuk mengurangi nilai menit dan set nilai detik ke `59`
            if (state.timerSeconds < 0) {
              emit(
                state.copyWith(
                  timerSeconds: 59,
                  timerMinutes: state.timerMinutes - 1,
                ),
              );
            }
            //untuk mengurangi nilai jam dan set nilai menit ke `59`
            if (state.timerMinutes < 0) {
              emit(
                state.copyWith(
                  timerMinutes: 59,
                  timerHours: state.timerHours - 1,
                ),
              );
            }
          }
        }
      },
    );
  }

  void setBreakTime() {
    double hours = state.timerHours.toDouble();
    double minutes = state.timerMinutes.toDouble();
    double seconds = state.timerSeconds.toDouble();
    double totalSeconds = 0;

    totalSeconds += hours * 60 * 60;
    totalSeconds += minutes * 60;
    totalSeconds += seconds;
    totalSeconds /= state.breakRatio;

    double convertedHours = (totalSeconds / 3600);
    double convertedMinutes = (convertedHours - convertedHours.toInt()) * 60;
    double convertedSeconds =
        (convertedMinutes - convertedMinutes.toInt()) * 60;
    emit(
      state.copyWith(
        timerSeconds: convertedSeconds.toInt(),
        timerMinutes: convertedMinutes.toInt(),
        timerHours: convertedHours.toInt(),
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

      emit(
        state.copyWith(
          isTimerPause: true,
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
                color: const Color.fromARGB(255, 238, 238, 238),
                border: Border.all(
                  color: const Color.fromARGB(255, 23, 23, 23),
                  width: 0.5,
                )),
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
            state.copyWith(
              isTimerIncrease: true,
              isTimerDecrease: false,
              status: 'Working Time',
              isTimerPause: false,
            ),
          );
        },
      );
    }
  }
}
