import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_app/models/item_list.dart';
import 'package:to_do_app/utils/item_sort.dart';
import '../components/add_item_form.dart';
import 'package:to_do_app/components/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ItemList> _items = [];

  _addItem(String title) {
    final newItem = ItemList(
      id: Random().nextDouble().toString(),
      title: title,
    );

    setState(() {
      _items.add(newItem);
    });

    Navigator.of(context).pop();
  }

  _removeItem(String id) {
    setState(() {
      _items.removeWhere((item) => item.id == id);
    });
  }

  _openAddItemFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddItemForm(_addItem);
      },
    );
  }

  _handleToDoChange(ItemList item) {
    setState(() {
      item.isDone = !item.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ItemList> sortedItems = sortItems(_items);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openAddItemFormModal(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TodoItem(sortedItems, _removeItem, _handleToDoChange),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddItemFormModal(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
