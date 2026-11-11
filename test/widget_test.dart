import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pablo_calculator/main.dart';

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    // Set a large enough surface size so all elements are in viewport
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalculatorApp());

    // Verify AppBar title and key UI elements are present
    expect(find.text('My Stateful Calculator'), findsOneWidget);
    expect(find.text('BASIC CALCULATOR'), findsOneWidget);
    expect(find.text('RESULT'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);

    // Test addition
    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(0), '12');
    await tester.enterText(textFields.at(1), '8');

    // Tap '+' button
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();

    // Verify addition result
    expect(find.text('20.0'), findsOneWidget);
    expect(find.text('12.0 + 8.0'), findsOneWidget);

    // Tap Clear button
    await tester.ensureVisible(find.text('Clear'));
    await tester.tap(find.text('Clear'));
    await tester.pump();

    // Verify clear reset
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Enter two numbers'), findsOneWidget);
  });
}
