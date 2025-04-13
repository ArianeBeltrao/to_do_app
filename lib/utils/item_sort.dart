import '../models/item_list.dart';

List<ItemList> sortItems(List<ItemList> items) {
  final sortedItems = [...items];
  sortedItems.sort((a, b) {
    if (a.isDone == b.isDone) return 0;
    return a.isDone ? 1 : -1;
  });
  return sortedItems;
}
