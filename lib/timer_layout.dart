import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:fsm2/fsm2.dart' as fsm;
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
import 'package:yot_flutter/widget.dart';

class TimerLayout extends StatefulWidget {
  final Duration? remainingTime;
  final Key onFinishAnimationKey;
  final fsm.StateMachine stateMachine;

  TimerLayout(
      {required Duration time,
      required GlobalKey<AnimatorWidgetState> onFinishAnimationKey,
      required fsm.StateMachine stateMachine})
      : this.remainingTime = time,
        this.onFinishAnimationKey = onFinishAnimationKey,
        this.stateMachine = stateMachine;

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
          child: SwipeGestureRecognizer(
              onSwipeUp: () {
                widget.stateMachine.applyEvent(OnMoreMinutes());
              },
              onSwipeDown: () {
                widget.stateMachine.applyEvent(OnLessMinutes());
              },
              child: MainDigit(widget.remainingTime?.inMinutes)),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: SwipeGestureRecognizer(
                onSwipeUp: () {
                  widget.stateMachine.applyEvent(OnMoreSeconds());
                },
                onSwipeDown: () {
                  widget.stateMachine.applyEvent(OnLessSeconds());
                },
                child: SmallDigit(widget.remainingTime?.inSeconds
                    .remainder(Duration.secondsPerMinute))))
      ]);
    else
      digitsLayout = Align(
        alignment: Alignment.bottomCenter,
        child: RubberBand(
            key: widget.onFinishAnimationKey,
            preferences:
                AnimationPreferences(autoPlay: AnimationPlayStates.None),
            child: SwipeGestureRecognizer(
              onSwipeUp: () {
                widget.stateMachine.applyEvent(OnMoreSeconds());
              },
              onSwipeDown: () {
                widget.stateMachine.applyEvent(OnLessSeconds());
              },
              child: MainDigit(widget.remainingTime?.inSeconds
                  .remainder(Duration.secondsPerMinute)),
            )),
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
