// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foreign_emp_scam_checker/features/job/presentation/screens/job_screen.dart';

void main() {
  testWidgets('job check page matches the new check flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: JobPage(),
        ),
      ),
    );

    expect(find.text('New Check'), findsOneWidget);
    expect(find.text('Job Post'), findsOneWidget);
    expect(find.text('Message'), findsOneWidget);
    expect(find.text('Agency'), findsNothing);
    expect(find.text('Company'), findsNothing);
    expect(
      find.text('Runs entirely on this device — nothing is uploaded.'),
      findsOneWidget,
    );
    expect(find.text('Run Security Check'), findsOneWidget);

    await tester.tap(find.text('Message'));
    await tester.pumpAndSettle();
    expect(find.text('Paste the recruiter message'), findsOneWidget);
  });

  testWidgets('run security check shows progress then the risk result', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: JobPage(),
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextField),
      'Pay a registration fee for guaranteed income of \$5000 per day. '
      'Send your passport details.',
    );
    await tester.pump();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isNotEmpty,
    );
    await tester.ensureVisible(find.text('Run Security Check'));
    await tester.tap(find.text('Run Security Check'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Analyzing job post...'), findsOneWidget);
    expect(find.text('Detecting suspicious requests'), findsOneWidget);

    for (var step = 0; step < 6; step++) {
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();
    }

    expect(find.text('Risk Result'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.text('DANGEROUS'), findsOneWidget);
    expect(find.text('Warning sign detected.'), findsNWidgets(3));
  });
}
