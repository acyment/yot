import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';

class TimerLayout extends StatefulWidget {
  CurrentRemainingTime? time;

  TimerLayout(CurrentRemainingTime? time) {
    this.time = time;
  }

  @override
  _TimerLayoutState createState() => _TimerLayoutState();
}

class _TimerLayoutState extends State<TimerLayout> {
  CurrentRemainingTime? time;

  @override
  Widget build(BuildContext context) {
    Widget digitsLayout;
    if ((widget.time?.min ?? 0) >= 1)
      digitsLayout = Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: MainDigit(widget.time?.min)),
        Align(
            alignment: Alignment.bottomRight,
            child: SmallDigit(widget.time?.sec))
      ]);
    else
      digitsLayout = Align(
          alignment: Alignment.bottomCenter,
          child: MainDigit(widget.time?.sec));

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('Yet Another Timer'),
      ),
      body: digitsLayout,
    );
  }
}

class MainDigit extends StatelessWidget {
  final int? value;

  const MainDigit(this.value);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Text(
      value.toString(),
      style: TextStyle(
          fontFamily: 'Roboto', fontSize: height * .83, color: Colors.white),
    );
  }
}

class SmallDigit extends StatelessWidget {
  final int? value;

  const SmallDigit(this.value);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        margin: EdgeInsets.only(right: 30.0),
        child: Text(
          this.value.toString(),
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: height * .2, color: Colors.white),
        ));
  }
}
