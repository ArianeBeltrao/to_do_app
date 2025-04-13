import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/components/add_item_form.dart';
import 'package:to_do_app/screens/home.dart';

void main() {
  testWidgets('Should show the correct title on AppBar...', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Home(title: 'To do list')));

    expect(find.text('To do list'), findsOneWidget);
  });

  testWidgets('Should open the modal by clicking on the add button', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: Home(title: 'To do list')));

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();

    expect(find.byType(AddItemForm), findsOneWidget);
  });

  testWidgets('Should open the modal by clicking on the floatingActionButton', (
    tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: Home(title: 'To do list')));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(AddItemForm), findsOneWidget);
  });

  testWidgets('Should add an item when submit the AddItemForm', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Home(title: 'To do list')));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final titleKey = find.byKey(const Key('title_key'));
    final addButton = find.byKey(Key('add_item_button_key'));

    await tester.enterText(titleKey, 'new item');
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('new item'), findsOneWidget);
  });

  testWidgets('Should change the item status to done', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Home(title: 'To do list')));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final titleKey = find.byKey(const Key('title_key'));
    final addButton = find.byKey(Key('add_item_button_key'));

    await tester.enterText(titleKey, 'new item status');
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    final checkboxFinder = find.byType(Checkbox).first;
    expect(checkboxFinder, findsOneWidget);

    await tester.tap(checkboxFinder);
    await tester.pumpAndSettle();

    Checkbox checkbox = tester.widget(checkboxFinder);

    expect(checkbox.value, true);
  });

  testWidgets('Should remove the item when clicked', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Home(title: 'To do list')));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    final titleKey = find.byKey(const Key('title_key'));
    final addButton = find.byKey(Key('add_item_button_key'));

    await tester.enterText(titleKey, 'new item to delete');
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    final deleteFinder = find.byIcon(Icons.delete).first;
    expect(deleteFinder, findsOneWidget);

    await tester.tap(deleteFinder);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.delete), findsNothing);
  });
}
