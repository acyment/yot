import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class TimerLayout extends StatefulWidget {
  Duration? remainingTime;
  Key? onFinishAnimationKey;

  TimerLayout(
      {required Duration time,
      required GlobalKey<AnimatorWidgetState> onFinishAnimationKey}) {
    this.remainingTime = time;
    this.onFinishAnimationKey = onFinishAnimationKey;
  }

  @override
  _TimerLayoutState createState() => _TimerLayoutState();
}

class _TimerLayoutState extends State<TimerLayout> {
  @override
  Widget build(BuildContext context) {
    Widget digitsLayout;
    if ((widget.remainingTime?.inMinutes ?? 0) >= 1)
      digitsLayout = Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: MainDigit(widget.remainingTime?.inMinutes),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: SmallDigit(widget.remainingTime?.inSeconds
                .remainder(Duration.secondsPerMinute)))
      ]);
    else
      digitsLayout = Align(
        alignment: Alignment.bottomCenter,
        child: RubberBand(
          key: widget.onFinishAnimationKey,
          preferences: AnimationPreferences(autoPlay: AnimationPlayStates.None),
          child: MainDigit(widget.remainingTime?.inSeconds
              .remainder(Duration.secondsPerMinute)),
        ),
      );

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
