import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/models/item_list.dart';
import 'package:to_do_app/utils/item_sort.dart';

void main() {
  test('Should sort items: undone first, done last', () {
    final items = [
      ItemList(id: '1', title: 'First', isDone: true),
      ItemList(id: '2', title: 'Second', isDone: false),
      ItemList(id: '3', title: 'Third', isDone: false),
    ];

    final sorted = sortItems(items);

    expect(sorted[0].title, 'Second');
    expect(sorted[1].title, 'Third');
    expect(sorted[2].title, 'First');
  });
}
