import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

//palet warna
//putih: Color.fromARGB(255, 238, 238, 238)
//hitam: Color.fromARGB(255, 23, 23, 23)
//abuAbu: Color.fromARGB(255, 68, 68, 68)

//ide
//isTimerRun hanya di ubah menjadi true ketika tombol play belum pernah di pencet atau setelah reset

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> with TickerProviderStateMixin {
  ////////////
  //Override//
  ////////////
  @override
  initState() {
    // debugging();
    increaseTime();
    decreaseTime();
    timeEndSound.setReleaseMode(ReleaseMode.loop);
    timeEndSound.setVolume(1);
    tickSound.setReleaseMode(ReleaseMode.release);
    tickSound.setVolume(1);
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    visibilityController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    isTimerRun = false;
    isTimerIncrease = false;
    isTimerDecrease = false;
    isTimerPause = false;
    status = 'Idle';
    timerSeconds = 0;
    timerMinutes = 0;
    timerHours = 0;
    isDispose = true;
    //dispose controlller
    iconController.dispose();
    visibilityController.dispose();
    print('disposed running successfully');
    super.dispose();
  }

  ////////////
  //Variable//
  ////////////
  NumberFormat formatter = NumberFormat('00');
  int timerSeconds = 0;
  int timerMinutes = 0;
  int timerHours = 0;
  int input = 1;
  bool isTimerIncrease = false;
  bool isTimerDecrease = false;
  bool isTimerRun = false;
  bool isTimerPause = false;
  bool isDispose = false;
  bool isVisible = false;
  bool isAnimationEnd = false;
  //UI/UX
  String status = 'Idle';
  final AudioPlayer timeEndSound = AudioPlayer();
  final AudioPlayer tickSound = AudioPlayer();
  late AnimationController iconController;
  late AnimationController visibilityController;

  //////////
  //method//
  //////////
  Future<void> debugging() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(isVisible.toString());
    });
  }

  String setStatus() {
    if (isTimerPause == true) {
      return 'Paused';
    } else if ((isTimerIncrease == true || isTimerDecrease == false) &&
        isTimerRun == true) {
      return 'Working Time';
    } else if ((isTimerIncrease == false || isTimerDecrease == true) &&
        isTimerRun == true) {
      return 'Breaking Time';
    } else {
      return 'Idle';
    }
  }

  //Method untuk menjalankan timer
  void increaseTime() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //cancel timer
      if (isDispose == true) {
        timer.cancel();
      }
      //increase timer
      if (isTimerIncrease == true &&
          isTimerDecrease == false &&
          isTimerRun == true &&
          isTimerPause == false) {
        tickSound.play(AssetSource('tick_sound.mp3'));
        status = 'Working Time';

        setState(() {
          timerSeconds++;
          if (timerSeconds == 60) {
            timerSeconds = 0;
            timerMinutes++;
          }
          if (timerMinutes == 60) {
            timerMinutes = 0;
            timerHours++;
          }
        });
      }
    });
  }

  void decreaseTime() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        //cancel timer
        if (isDispose == true) {
          timer.cancel();
        }

        //decrease timer
        if (isTimerIncrease == false &&
            isTimerDecrease == true &&
            isTimerRun == true &&
            isTimerPause == false) {
          status = 'Breaking Time';
          setState(
            () {
              if (timerHours == 0 && timerMinutes == 0 && timerSeconds == 0) {
                playAlarm(context);
              }
              if (timerSeconds > 0 || timerMinutes > 0 || timerHours > 0) {
                tickSound.play(AssetSource('tick_sound.mp3'));
                timerSeconds--;
              }
              if (timerSeconds < 0) {
                timerSeconds = 59;
                timerMinutes--;
              }
              if (timerMinutes < 0) {
                timerMinutes = 59;
                timerHours--;
              }
            },
          );
        }
      },
    );
  }

  //Method untuk menentukan panjang waktu istirahat
  void setBreakTime() {
    double hours = timerHours.toDouble();
    double minutes = timerMinutes.toDouble();
    double seconds = timerSeconds.toDouble();

    minutes += hours * 60;
    seconds += minutes * 60;

    seconds /= input;

    minutes = seconds / 60;
    hours = minutes / 60;

    setState(() {
      timerSeconds = (seconds % 60).toInt();
      timerMinutes = minutes.toInt();
      timerHours = hours.toInt();
    });
  }

  //Method untuk mengurangi waktu istirahat

  //Method untuk memutar alarm
  void playAlarm(BuildContext context) {
    if (isTimerRun == true &&
        (isTimerIncrease == false || isTimerDecrease == true) &&
        (timerSeconds == 0 && timerMinutes == 0 && timerHours == 0)) {
      timeEndSound.play(AssetSource('digital_alarm.mp3'));
      isTimerPause = true;
      iconController.forward();
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
          isTimerPause = false;
          timeEndSound.stop();
          isTimerIncrease = true;
          isTimerDecrease = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Display status
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                setStatus(),
                style: const TextStyle(
                    color: Color.fromARGB(255, 238, 238, 238),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //Display timer
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Tampilan detik
                Container(
                  width: 65,
                  height: 65,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  child: Center(
                    child: Text(formatter.format(timerHours),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 238, 238, 238),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                //Tampilan menit
                Container(
                  width: 65,
                  height: 65,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  child: Center(
                    child: Text(formatter.format(timerMinutes),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 238, 238, 238),
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                //Tampilan jam
                Container(
                  width: 65,
                  height: 65,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: const Color.fromARGB(255, 23, 23, 23),
                  ),
                  child: Center(
                    child: Text(
                      formatter.format(timerSeconds),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 238, 238, 238),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color.fromARGB(255, 23, 23, 23),
                    ),
                    child: const Center(
                      child: Text(
                        'BreakTime',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ' = ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 238, 238, 238),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color.fromARGB(255, 23, 23, 23),
                    ),
                    child: const Center(
                      child: Text(
                        'WorkTime',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    ' / ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 238, 238, 238),
                    ),
                  ),
                  //Menunjukkan waktu istirahat yang di tentukan user
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color.fromARGB(255, 23, 23, 23),
                    ),
                    child: Center(
                      child: Text(
                        input.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 238, 238, 238),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    //Custom Button untuk penambahan nilai
                    children: [
                      Container(
                          width: 30,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[350],
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          child: Material(
                            child: InkWell(
                              onTap: (input < 10)
                                  ? () {
                                      if (input < 10) {
                                        input++;
                                        setState(() {});
                                      }
                                    }
                                  : null,
                              child: const Icon(Icons.arrow_drop_up),
                            ),
                          )),
                      //Custom button untuk pengurangan nilai
                      Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            border:
                                Border.all(color: Colors.black, width: 0.5)),
                        child: Material(
                          child: InkWell(
                            onTap: (input > 1)
                                ? () {
                                    if (input > 1) {
                                      input--;
                                      setState(() {});
                                    }
                                  }
                                : null,
                            child: const Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            //Button
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //tombol untuk istirahat
                  Visibility(
                    visible: isVisible,
                    child: Animate(
                      controller: visibilityController,
                      effects: const [
                        FadeEffect(
                          begin: 0,
                          end: 1,
                          duration: Duration(milliseconds: 300),
                        ),
                        SlideEffect(
                          begin: Offset(0.5, 0),
                          end: Offset(0, 0),
                          duration: Duration(milliseconds: 300),
                        )
                      ],
                      child: FloatingActionButton(
                        backgroundColor:
                            const Color.fromARGB(255, 238, 238, 238),
                        onPressed: () {
                          if (isTimerDecrease == true &&
                              isTimerIncrease == false) {
                            setBreakTime();
                          }
                          isTimerIncrease = true;
                          isTimerDecrease = false;
                          isTimerPause = false;
                          isTimerDecrease = true;
                          isTimerIncrease = false;
                          setState(() {
                            iconController.forward();
                          });
                        },
                        child: const Icon(
                          Icons.free_breakfast,
                          color: Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                    ),
                  ),

                  //switch play/pause timer
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: FloatingActionButton(
                      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                      onPressed: () {
                        setState(() {
                          isVisible = true;
                        });
                        //jika timer pertama kali di mulai atau selesai di reset
                        if (isTimerRun == false) {
                          isTimerRun = true;
                          isTimerIncrease = true;
                          isTimerDecrease = false;
                          isTimerPause = false;
                          setState(
                            () {
                              iconController.forward();
                            },
                          );
                          //jika timer sedang mengurangi angka dan kondisi tidak di pause
                        } else if (isTimerRun == true &&
                            (isTimerIncrease == false &&
                                isTimerDecrease == true) &&
                            isTimerPause == false) {
                          isTimerPause = true;
                          setState(
                            () {
                              iconController.reverse();
                            },
                          );
                          //jika timer sedang menambah angka dan kondisi tidak di pause
                        } else if (isTimerRun == true &&
                            (isTimerIncrease == true &&
                                isTimerDecrease == false) &&
                            isTimerPause == false) {
                          isTimerPause = true;
                          setState(
                            () {
                              iconController.reverse();
                            },
                          );
                          //jika timer sedang mengurangi angka dan kondisi sedang di pause
                        } else if (isTimerRun == true &&
                            (isTimerIncrease == false &&
                                isTimerDecrease == true) &&
                            isTimerPause == true) {
                          isTimerPause = false;
                          setState(() {
                            iconController.forward();
                          });
                          //jika timer sedang menambah angka dan kondisi sedang di pause
                        } else if (isTimerRun == true &&
                            (isTimerIncrease == true &&
                                isTimerDecrease == false) &&
                            isTimerPause == true) {
                          isTimerPause = false;
                          setState(() {
                            iconController.forward();
                          });
                        }
                      },
                      child: AnimatedIcon(
                          color: const Color.fromARGB(255, 23, 23, 23),
                          icon: AnimatedIcons.play_pause,
                          progress: iconController),
                    ),
                  ),

                  //reset timer
                  Visibility(
                    visible: isVisible,
                    child: Animate(
                      controller: visibilityController,
                      effects: const [
                        FadeEffect(
                          begin: 0,
                          end: 1,
                          duration: Duration(milliseconds: 300),
                        ),
                        SlideEffect(
                          begin: Offset(-0.5, 0),
                          end: Offset(0, 0),
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                      child: FloatingActionButton(
                        backgroundColor:
                            const Color.fromARGB(255, 238, 238, 238),
                        onPressed: () {
                          isTimerRun = false;
                          isTimerIncrease = false;
                          isTimerDecrease = false;
                          isTimerPause = false;
                          status = 'Idle';
                          timerSeconds = 0;
                          timerMinutes = 0;
                          timerHours = 0;
                          setState(
                            () {
                              iconController.reverse();

                              visibilityController.reverse().whenComplete(
                                    () => setState(
                                      () {
                                        isVisible = false;
                                      },
                                    ),
                                  );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.stop,
                          color: Color.fromARGB(255, 23, 23, 23),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
