import 'package:flutter/material.dart';
import 'package:fsm2/fsm2.dart' as fsm;
import 'timer_layout.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_animator/flutter_animator.dart';

class TimerWidget extends StatefulWidget {
  Duration initialDuration;

  TimerWidget({required Duration initialDuration})
      : initialDuration = initialDuration;

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late CountdownController _countdownController;

  late fsm.StateMachine _stateMachine;

  final GlobalKey<AnimatorWidgetState> _onFinishAnimation =
      GlobalKey<AnimatorWidgetState>();

  @override
  void initState() {
    _countdownController = CountdownController(
        duration: widget.initialDuration,
        onEnd: () {
          _stateMachine.applyEvent(OnFinish());
        });

    _stateMachine = fsm.StateMachine.create((g) => g
      ..initialState<Stopped>()
      ..state<Stopped>((b) => b
        ..on<OnMoreMinutes, Stopped>(sideEffect: (e) async {
          widget.initialDuration += Duration(minutes: 1);
          _countdownController.value = widget.initialDuration.inMilliseconds;
        })
        ..on<OnMoreSeconds, Stopped>(sideEffect: (e) async {
          widget.initialDuration += Duration(seconds: 15);
          _countdownController.value = widget.initialDuration.inMilliseconds;
        })
        ..on<OnLessMinutes, Stopped>(sideEffect: (e) async {
          widget.initialDuration -= Duration(minutes: 1);
          _countdownController.value = widget.initialDuration.inMilliseconds;
        })
        ..on<OnLessSeconds, Stopped>(sideEffect: (e) async {
          widget.initialDuration -= Duration(seconds: 15);
          _countdownController.value = widget.initialDuration.inMilliseconds;
        })
        ..on<OnDoubleTap, Ticking>(
            sideEffect: (e) async => _countdownController.start()))
      ..state<Ticking>((b) => b
        ..on<OnDoubleTap, Paused>(
            sideEffect: (e) async => _countdownController.stop())
        ..on<OnLongPress, Stopped>(sideEffect: (e) async {
          _countdownController.stop();
          _countdownController.value = widget.initialDuration.inMilliseconds;
        })
        ..on<OnFinish, Flashing>(sideEffect: (e) async {
          _onFinishAnimation.currentState!.loop();
        }))
      ..state<Paused>((b) => b
        ..on<OnDoubleTap, Ticking>(
            sideEffect: (e) async => _countdownController.start()))
      ..state<Flashing>((b) => b
        ..on<OnLongPress, Stopped>(sideEffect: (e) async {
          _onFinishAnimation.currentState!.reset();
          _countdownController.stop();
          _countdownController.value = widget.initialDuration.inMilliseconds;
        })));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: () {
          _stateMachine.applyEvent(OnDoubleTap());
        },
        onLongPress: () {
          _stateMachine.applyEvent(OnLongPress());
        },
        child: Countdown(
            countdownController: _countdownController,
            builder: (_, Duration time) {
              return TimerLayout(
                time: time,
                onFinishAnimationKey: this._onFinishAnimation,
                stateMachine: this._stateMachine,
              );
            }));
  }
}

class Stopped implements fsm.State {}

class Paused implements fsm.State {}

class Ticking implements fsm.State {}

class Flashing implements fsm.State {}

class OnDoubleTap implements fsm.Event {}

class OnLongPress implements fsm.Event {}

class OnPause implements fsm.Event {}

class OnStop implements fsm.Event {}

class OnFinish implements fsm.Event {}

class OnMoreMinutes implements fsm.Event {}

class OnLessMinutes implements fsm.Event {}

class OnMoreSeconds implements fsm.Event {}

class OnLessSeconds implements fsm.Event {}
