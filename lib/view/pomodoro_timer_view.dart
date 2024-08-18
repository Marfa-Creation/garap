import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garap/bloc/pomodoro_timer_cubit.dart';
import 'package:garap/model/pomodoro_timer_model.dart';
import 'package:garap/widgets/half_clipper.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class PomodoroTimerView extends StatefulWidget {
  const PomodoroTimerView({super.key});

  @override
  State<PomodoroTimerView> createState() => _PomodoroTimerViewState();
}

class _PomodoroTimerViewState extends State<PomodoroTimerView>
    with TickerProviderStateMixin {
  ////////////
  //variable//
  ////////////
  final PomodoroTimerCubit provider = PomodoroTimerCubit();
  late final AnimationController animationController;
  late final AnimationController textAnimationController;
  bool cooldown = false;

  //////////
  //method//
  //////////

  Future<void> snackBarAlert() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        showCloseIcon: true,
        content: Text(
          'the section is not finished, you can wait or stop the timer with holding timer before change the section',
          maxLines: 3,
        ),
      ),
    );
    //memberi cooldown pada snackbar agar tidak dapat di spam
    cooldown = true;
    Timer(const Duration(seconds: 3), () => cooldown = false);
  }

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
              color: const Color.fromARGB(255, 64, 65, 75),
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
                      color: Color.fromARGB(255, 255, 255, 255),
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
                            color: Color.fromARGB(255, 79, 249, 113),
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

  ////////////
  //override//
  ////////////
  @override
  void initState() {
    WakelockPlus.enable();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {},
    );
    provider.isDispose = false;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    textAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50));
    super.initState();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    provider.isDispose = true;
    animationController.dispose();
    super.dispose();
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
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        title: const Text(
          'Pomodoro Timer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder(
              bloc: provider,
              builder: (context, state) {
                return Animate(
                  controller: textAnimationController,
                  effects: const [FadeEffect()],
                  child: Text(
                    (provider.section == PomodoroSection.focus)
                        ? '25 Minutes Focus'
                        : (provider.section == PomodoroSection.shortBreak)
                            ? '5 Minutes Breaking'
                            : '15 Minutes Breaking',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            //tombol untuk memilih timer
            BlocBuilder(
              bloc: provider,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //untuk memilih sesi fokus
                    GestureDetector(
                      onTap: () async {
                        //cek apa sebelumnya sudah ditekan atau belum
                        if (provider.section != PomodoroSection.focus) {
                          //cek apa timer sedang berjalan, jika iya, minta user mengehentikannya
                          if (provider.isTimerRun == true) {
                            if (cooldown == false) {
                              snackBarAlert();
                            }
                          } else {
                            provider.timerSeconds = 0;
                            provider.timerMinutes = 25;
                            await textAnimationController.reverse();
                            Timer(
                              const Duration(milliseconds: 50),
                              () => textAnimationController.forward(),
                            );
                            provider.section = PomodoroSection.focus;
                          }
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (provider.section == PomodoroSection.focus)
                                ? const Color.fromARGB(255, 255, 0, 0)
                                : (provider.section ==
                                        PomodoroSection.shortBreak)
                                    ? const Color.fromARGB(255, 255, 247, 0)
                                    : const Color.fromARGB(255, 111, 255, 0),
                            boxShadow:
                                (provider.section == PomodoroSection.focus)
                                    ? [
                                        // BoxShadoow
                                      ]
                                    : null),
                      ),
                    ),
                    //untuk memilih sesi istirahat 5 menit
                    GestureDetector(
                      onTap: () async {
                        //cek apa sebelumnya sudah ditekan atau belum
                        if (provider.section != PomodoroSection.shortBreak) {
                          //cek apa timer sedang berjalan, jika iya, minta user mengehentikannya
                          if (provider.isTimerRun == true) {
                            if (cooldown == false) {
                              snackBarAlert();
                            }
                          } else {
                            provider.timerSeconds = 0;
                            provider.timerMinutes = 5;
                            await textAnimationController.reverse();
                            Timer(
                              const Duration(milliseconds: 50),
                              () => textAnimationController.forward(),
                            );
                            provider.section = PomodoroSection.shortBreak;
                          }
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(5),
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (provider.section == PomodoroSection.focus)
                              ? const Color.fromARGB(255, 255, 0, 0)
                              : (provider.section == PomodoroSection.shortBreak)
                                  ? const Color.fromARGB(255, 255, 247, 0)
                                  : const Color.fromARGB(255, 111, 255, 0),
                          boxShadow:
                              (provider.section == PomodoroSection.shortBreak)
                                  ? []
                                  : null,
                        ),
                      ),
                    ),
                    //untuk memilih sesi istirahat 15 menit
                    GestureDetector(
                      onTap: () async {
                        //cek apa sebelumnya sudah ditekan atau belum
                        if (provider.section != PomodoroSection.longBreak) {
                          //cek apa timer sedang berjalan, jika iya, minta user mengehentikannya
                          if (provider.isTimerRun == true) {
                            if (cooldown == false) {
                              snackBarAlert();
                            }
                          } else {
                            provider.timerSeconds = 0;
                            provider.timerMinutes = 15;
                            await textAnimationController.reverse();
                            Timer(
                              const Duration(milliseconds: 50),
                              () => textAnimationController.forward(),
                            );
                            provider.section = PomodoroSection.longBreak;
                          }
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (provider.section == PomodoroSection.focus)
                              ? const Color.fromARGB(255, 255, 0, 0)
                              : (provider.section == PomodoroSection.shortBreak)
                                  ? const Color.fromARGB(255, 255, 247, 0)
                                  : const Color.fromARGB(255, 111, 255, 0),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              height: 250,
              //tampilan timer
              child: BlocBuilder<PomodoroTimerCubit, PomodoroTimerModel>(
                  bloc: provider,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onLongPress: () {
                        provider.resetTimer();
                      },
                      onTap: () async {
                        //cek apakah timer sebelumnya sudah jalan atau belum,
                        //sehingga tidak terjadi pemanggilan `Timer.periodic` berlebih
                        if (provider.isTimerRun == false) {
                          WakelockPlus.enable();
                          provider.startTimer(
                            context,
                            () async {
                              AudioPlayer()
                                  .play(AssetSource('ding.wav'), volume: 1);
                              WakelockPlus.disable();
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    width: 100,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Center(
                                          child: Text(
                                            (provider.section ==
                                                    PomodoroSection.focus)
                                                ? 'your focus section has end,\n you can take a break now'
                                                : 'breaking time has end,\nlet\'s focus again!',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 23, 23, 23),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          if (provider.isTimerPause == true &&
                              provider.isTimerRun == true) {
                            WakelockPlus.enable();
                            animationController.reverse();
                          } else {
                            WakelockPlus.disable();
                            animationController.forward();
                          }
                          provider.isTimerPause = !provider.isTimerPause;
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          BlocBuilder<PomodoroTimerCubit, PomodoroTimerModel>(
                            bloc: provider,
                            builder: (context, state) {
                              return ClipPath(
                                clipper: HalfClipper(top: provider.loadingBar),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 250,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    color: (provider.section ==
                                            PomodoroSection.focus)
                                        ? const Color.fromARGB(255, 255, 0, 0)
                                        : (provider.section ==
                                                PomodoroSection.shortBreak)
                                            ? const Color.fromARGB(
                                                255, 255, 247, 0)
                                            : const Color.fromARGB(
                                                255, 111, 255, 0),
                                    borderRadius: BorderRadius.circular(250),
                                  ),
                                ),
                              );
                            },
                          ),
                          //Container untuk membuat efek lubang
                          BlocBuilder(
                            bloc: provider,
                            builder: (context, state) {
                              return Container(
                                width: 230,
                                height: 230,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 28, 32, 37),
                                  borderRadius: BorderRadius.circular(230),
                                ),
                                child: Center(
                                  child: Text(
                                    '${NumberFormat('00').format(provider.timerMinutes)}:${NumberFormat('00').format(provider.timerSeconds)}',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Animate(
                            autoPlay: false,
                            controller: animationController,
                            effects: const [FadeEffect(begin: 0, end: 1)],
                            child: Container(
                              width: 230,
                              height: 230,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 28, 32, 37),
                                  borderRadius: BorderRadius.circular(230)),
                              child: const Center(
                                child: Text(
                                  'Paused',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

//widget yang akan ditampilkan ketika timer sesi istirahat 5 menit selesai
class OnShortBreakSectionEnd extends StatelessWidget {
  const OnShortBreakSectionEnd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'your short break section has end,\nstart focus again?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromARGB(255, 23, 23, 23),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//widget yang akan ditampilkan ketika timer sesi istirahat 15 menit selesai
class OnLongBreakSectionEnd extends StatelessWidget {
  const OnLongBreakSectionEnd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 100,
        height: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'your long break section has end,\nstart focus again?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Color.fromARGB(255, 23, 23, 23),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
