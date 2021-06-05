import 'package:flutter/material.dart';
import 'widget.dart';

void main() => runApp(TimerApp(Duration(minutes: 3)));

class TimerApp extends StatelessWidget {
  final Duration _duration;

  TimerApp(Duration duration) : _duration = duration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yet Another Timer',
      home: TimerWidget(initialDuration: _duration),
    );
  }
}
