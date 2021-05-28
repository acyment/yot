import 'package:flutter/material.dart';
import 'widget.dart';

void main() => runApp(TimerApp());

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yet Another Timer',
      home: TimerWidget(initialDuration: Duration(seconds: 3)),
    );
  }
}
