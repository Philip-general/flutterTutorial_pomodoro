import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const minutes = 60;
  static const defaultPomodoroSeconds = 10;

  bool isRunning = false;
  int totalSeconds = defaultPomodoroSeconds;
  int totalPomodoros = 0;
  late Timer timer;

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    var formattedSeconds = duration.toString().split(".").first.substring(2);
    return formattedSeconds;
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros++;
        isRunning = false;
        totalSeconds = defaultPomodoroSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = defaultPomodoroSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalSeconds),
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 89,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  icon: isRunning
                      ? const Icon(Icons.pause_circle_outline)
                      : const Icon(Icons.play_circle_outline_outlined),
                ),
                IconButton(
                    onPressed: onResetPressed,
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    icon: const Icon(Icons.restore)),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
