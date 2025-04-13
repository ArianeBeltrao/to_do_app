import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/components/todo_item.dart';
import 'package:to_do_app/models/item_list.dart';

void main() {
  group("To do item widget", () {
    testWidgets("Should return a message in case items is null", (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: TodoItem([], (_) {}, (_) {})));

      expect(find.text("No items registered yet"), findsOneWidget);
    });

    testWidgets("Should return the to do items correctly", (
      WidgetTester tester,
    ) async {
      final items = [
        ItemList(id: "1", title: "write a letter"),
        ItemList(id: "2", title: "cook beans"),
      ];
      await tester.pumpWidget(
        MaterialApp(home: TodoItem(items, (_) {}, (_) {})),
      );

      expect(find.text("write a letter"), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets("Should remove an item when the button onRemove is clicked", (
      WidgetTester tester,
    ) async {
      String? removedId;

      final items = [ItemList(id: "2", title: "cook beans")];

      await tester.pumpWidget(
        MaterialApp(home: TodoItem(items, (id) => removedId = id, (_) {})),
      );

      await tester.tap(find.byIcon(Icons.delete));
      expect(removedId, equals("2"));
    });

    testWidgets("Should mark a item as done when the checkbox is clicked", (
      WidgetTester tester,
    ) async {
      bool isChanged = false;
      final items = [ItemList(id: "2", title: "cook beans", isDone: false)];

      await tester.pumpWidget(
        MaterialApp(
          home: TodoItem(items, (_) {}, (item) {
            isChanged = true;
            return null;
          }),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      expect(isChanged, isTrue);
    });
  });
}
