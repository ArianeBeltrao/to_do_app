import 'package:flutter/material.dart';
import 'package:to_do_app/models/item_list.dart';

class TodoItem extends StatelessWidget {
  final List<ItemList> items;
  final void Function(String) onRemove;
  final dynamic Function(ItemList) onToDoChanged;

  const TodoItem(this.items, this.onRemove, this.onToDoChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No items registered yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            );
          },
        )
        : ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            final item = items[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: ListTile(
                leading: Checkbox(
                  value: item.isDone,
                  onChanged: (value) => onToDoChanged(item),
                ),
                title: Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                trailing: IconButton(
                  onPressed: () => onRemove(item.id),
                  color: Theme.of(context).colorScheme.primary,
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        );
  }
}
