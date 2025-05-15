import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skill_build_project/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Provide initial route for the MyApp constructor
    await tester.pumpWidget(const MyApp(initialRoute: '/login'));

    // Since you're using a different homepage, adjust these lines to match your actual app
    expect(find.text('0'), findsOneWidget); // May need to change based on your UI
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
