import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/bloc/timer_cubit.dart';
import 'package:garap/model/timer_model.dart';
import 'package:intl/intl.dart';

//palet warna
//putih: Color.fromARGB(255, 238, 238, 238)
//hitam: Color.fromARGB(255, 23, 23, 23)
//abuAbu: Color.fromARGB(255, 68, 68, 68)

class RestworkTimerView extends StatefulWidget {
  const RestworkTimerView({super.key});

  @override
  State<RestworkTimerView> createState() => _RestworkTimerViewState();
}

class _RestworkTimerViewState extends State<RestworkTimerView> with TickerProviderStateMixin {
  ////////////
  //Override//
  ////////////

  @override
  initState() {
    provider.isDispose = false;
    provider.increaseTime();
    provider.decreaseTime(context);
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    visibilityController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    provider.isTimerRun = false;
    provider.isTimerIncrease = false;
    provider.isTimerDecrease = false;
    provider.isTimerPause = false;
    provider.status = 'Idle';
    provider.timerSeconds = 0;
    provider.timerMinutes = 0;
    provider.timerHours = 0;
    provider.isDispose = true;

    //dispose controlller
    iconController.dispose();
    visibilityController.dispose();
    super.dispose();
  }

  ////////////
  //Variable//
  ////////////
  final TimerCubit provider = TimerCubit();
  final ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(true);

  //UI/UX
  bool isVisible = false;
  late AnimationController iconController;
  late AnimationController visibilityController;

  //////////
  //method//
  //////////
  Future<bool?> askForPop(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1 / 2,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 23, 23, 23),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'The timer is still running!\nare you sure to go back?',
                    maxLines: 3,
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 238, 238),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(width: 35),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 23, 23, 23),
        leading: PopScope(
          canPop: true,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return; //jika ternyata pop sudah sukses dilakukan, maka batalkan
            }
            final bool getConfirmation = await askForPop(context) ?? false;

            if (context.mounted && getConfirmation == true) {
              Navigator.pop(context);
            }
          },
          child: IconButton(
            onPressed: () async {
              if (provider.isTimerRun == true) {
                final bool getConfirmation = await askForPop(context) ?? false;

                if (context.mounted && getConfirmation == true) {
                  Navigator.pop(context);
                }
              }else{
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
          ),
        ),
        title: const Text(
          'Restwork Timer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: valueNotifier,
            builder: (context, boolean, widget) => IconButton(
              onPressed: () {
                provider.audioMode = !provider.audioMode;
                valueNotifier.value = provider.audioMode;
              },
              icon: Icon((provider.audioMode == true)
                  ? Icons.volume_up
                  : Icons.volume_off),
              color: const Color.fromARGB(255, 238, 238, 238),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Display status
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                provider.setStatus(),
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
                    child: BlocBuilder<TimerCubit, TimerModel>(
                      bloc: provider,
                      builder: (context, state) => Text(
                          NumberFormat('00').format(state.timerHours),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 238, 238, 238),
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
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
                    child: BlocBuilder<TimerCubit, TimerModel>(
                      bloc: provider,
                      builder: (context, state) => Text(
                          NumberFormat('00').format(state.timerMinutes),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 238, 238, 238),
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
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
                    child: BlocBuilder<TimerCubit, TimerModel>(
                      bloc: provider,
                      builder: (context, state) => Text(
                        NumberFormat('00').format(state.timerSeconds),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 238, 238, 238),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
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
                  //Menunjukkan breakRatio
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      color: const Color.fromARGB(255, 23, 23, 23),
                    ),
                    child: Center(
                      child: BlocBuilder<TimerCubit, TimerModel>(
                        bloc: provider,
                        builder: (context, state) => Text(
                          state.breakRatio.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 238, 238, 238),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    //Custom Button untuk menambah breakRatio
                    children: [
                      Container(
                          width: 30,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[350],
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                          child: Material(
                            child: BlocBuilder<TimerCubit, TimerModel>(
                              bloc: provider,
                              builder: (context, state) => InkWell(
                                onTap: (state.breakRatio < 10)
                                    ? () {
                                        if (state.breakRatio < 10) {
                                          provider.breakRatio++;
                                        }
                                      }
                                    : null,
                                child: const Icon(Icons.arrow_drop_up,
                                    color: Color.fromARGB(255, 23, 23, 23)),
                              ),
                            ),
                          )),
                      //Custom button untuk mengurangi breakRatio
                      Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey[350],
                            border:
                                Border.all(color: Colors.black, width: 0.5)),
                        child: Material(
                          child: BlocBuilder<TimerCubit, TimerModel>(
                            bloc: provider,
                            builder: (context, state) => InkWell(
                              onTap: (state.breakRatio > 1)
                                  ? () {
                                      if (state.breakRatio > 1) {
                                        provider.breakRatio--;
                                      }
                                    }
                                  : null,
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 23, 23, 23),
                              ),
                            ),
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
                      child: BlocBuilder<TimerCubit, TimerModel>(
                        bloc: provider,
                        builder: (context, state) => FloatingActionButton(
                          heroTag: 'c',
                          backgroundColor:
                              const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {
                            if (state.isTimerIncrease == true &&
                                state.isTimerDecrease == false) {
                              provider.setBreakTime();
                            }
                            provider.isTimerIncrease = true;
                            provider.isTimerDecrease = false;
                            provider.isTimerPause = false;
                            provider.isTimerDecrease = true;
                            provider.isTimerIncrease = false;
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
                  ),

                  //switch play/pause timer
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: BlocBuilder<TimerCubit, TimerModel>(
                      builder: (context, state) => FloatingActionButton(
                        heroTag: 'a',
                        backgroundColor:
                            const Color.fromARGB(255, 238, 238, 238),
                        onPressed: () {
                          setState(() {
                            isVisible = true;
                          });
                          //jika timer pertama kali di mulai atau selesai di reset
                          if (state.isTimerRun == false) {
                            provider.isTimerRun = true;
                            provider.isTimerIncrease = true;
                            provider.isTimerDecrease = false;
                            provider.isTimerPause = false;
                            setState(
                              () {
                                iconController.forward();
                              },
                            );
                            //jika timer sedang mengurangi angka dan kondisi tidak di pause
                          } else if (state.isTimerRun == true &&
                              (state.isTimerIncrease == false &&
                                  state.isTimerDecrease == true) &&
                              state.isTimerPause == false) {
                            provider.isTimerPause = true;
                            setState(
                              () {
                                iconController.reverse();
                              },
                            );
                            //jika timer sedang menambah angka dan kondisi tidak di pause
                          } else if (state.isTimerRun == true &&
                              (state.isTimerIncrease == true &&
                                  state.isTimerDecrease == false) &&
                              state.isTimerPause == false) {
                            provider.isTimerPause = true;
                            setState(
                              () {
                                iconController.reverse();
                              },
                            );
                            //jika timer sedang mengurangi angka dan kondisi sedang di pause
                          } else if (state.isTimerRun == true &&
                              (state.isTimerIncrease == false &&
                                  state.isTimerDecrease == true) &&
                              state.isTimerPause == true) {
                            provider.isTimerPause = false;
                            setState(() {
                              iconController.forward();
                            });
                            //jika timer sedang menambah angka dan kondisi sedang di pause
                          } else if (state.isTimerRun == true &&
                              (state.isTimerIncrease == true &&
                                  state.isTimerDecrease == false) &&
                              state.isTimerPause == true) {
                            provider.isTimerPause = false;
                            setState(() {
                              iconController.forward();
                            });
                          } else {}
                        },
                        child: AnimatedIcon(
                            color: const Color.fromARGB(255, 23, 23, 23),
                            icon: AnimatedIcons.play_pause,
                            progress: iconController),
                      ),
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
                      child: BlocBuilder<TimerCubit, TimerModel>(
                        bloc: provider,
                        builder: (context, state) => FloatingActionButton(
                          heroTag: 'b',
                          backgroundColor:
                              const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {
                            provider.isTimerRun = false;
                            provider.isTimerIncrease = false;
                            provider.isTimerDecrease = false;
                            provider.isTimerPause = false;
                            provider.status = 'Idle';
                            provider.timerSeconds = 0;
                            provider.timerMinutes = 0;
                            provider.timerHours = 0;
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
