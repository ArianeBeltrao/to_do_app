import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/components/add_item_form.dart';

void main() {
  testWidgets('Should add item form ...', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddItemForm((_) {})));

    final titleKey = find.byKey(const Key('title_key'));
    final addButton = find.byKey(Key('add_item_button_key'));

    expect(titleKey, findsOneWidget);
    expect(addButton, findsOneWidget);
  });

  testWidgets('Should show the title error message ...', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AddItemForm((_) {})));

    final titleKey = find.byKey(const Key('title_key'));
    await tester.tap(titleKey);
    await tester.pumpAndSettle();

    await tester.enterText(titleKey, '');
    await tester.pumpAndSettle();

    final addButton = find.byKey(Key('add_item_button_key'));
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('The title field can not be empty'), findsOneWidget);
  });

  testWidgets('Should call onSubmit when title is valid ...', (tester) async {
    String? submittedTitle;

    await tester.pumpWidget(
      MaterialApp(
        home: AddItemForm((title) {
          submittedTitle = title;
        }),
      ),
    );

    final titleKey = find.byKey(const Key('title_key'));

    await tester.enterText(titleKey, 'Buy new shoes');
    await tester.pumpAndSettle();

    final addButton = find.byKey(Key('add_item_button_key'));
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(submittedTitle, equals('Buy new shoes'));
  });

  testWidgets('Should call onSubmitted when click on enter ...', (
    tester,
  ) async {
    String? submittedTitle;

    await tester.pumpWidget(
      MaterialApp(
        home: AddItemForm((title) {
          submittedTitle = title;
        }),
      ),
    );

    final titleKey = find.byKey(const Key('title_key'));

    await tester.enterText(titleKey, 'Buy new shoes');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(submittedTitle, equals('Buy new shoes'));
  });
}
