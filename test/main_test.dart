import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/main.dart';

void main() {
  testWidgets('Should show the correct title on AppBar...', (tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
