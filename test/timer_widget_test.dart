// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yot_flutter/main.dart';
import 'package:yot_flutter/timer_layout.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  testWidgets('General counting smoke tests', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TimerApp());

    // Verify that our counter starts at 0.
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsNothing);

    //  await doubleTap(tester, find.byType(MainDigit));

    await tester.pump(Duration(seconds: 2));

    // expect(find.text('1'), findsOneWidget);

    await doubleTap(tester, find.byType(MainDigit));

    await tester.pump(Duration(seconds: 5));

    //  expect(find.text('1'), findsOneWidget);
    Countdown c = tester.widget<Countdown>(find.byType(Countdown));
  });
}

Future<void> doubleTap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
