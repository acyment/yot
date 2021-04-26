import 'package:flutter/material.dart';
import 'timer_layout.dart';
import 'package:flutter_countdown_timer/index.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 300;
    return CountdownTimer(
        endTime: endTime,
        widgetBuilder: (_, CurrentRemainingTime? time) {
          return TimerLayout(time);
        });
  }
}
