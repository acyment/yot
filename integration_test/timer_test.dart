import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:yot_flutter/main.dart';
import 'package:yot_flutter/timer_layout.dart';
import 'package:flutter_countdown_timer/countdown.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TimerApp(Duration(seconds: 3)));

    // Verify that our counter starts at 0.
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsNothing);

    await doubleTap(tester, find.byType(MainDigit));

    await tester.pump(Duration(seconds: 2));

    expect(find.text('1'), findsOneWidget);

    await doubleTap(tester, find.byType(MainDigit));

    await tester.pump(Duration(seconds: 5));

    expect(find.text('1'), findsOneWidget);
  });
}

Future<void> doubleTap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
