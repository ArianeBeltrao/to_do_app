import 'package:flutter/material.dart';
import 'package:to_do_app/shared/auth/auth_service.dart';

class AddItemForm extends StatefulWidget {
  final void Function(String) onSubmit;

  const AddItemForm(this.onSubmit, {super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _titleController = TextEditingController();
  final Auth _auth = Auth();

  String? _errorMessage;

  _submitForm() {
    final title = _titleController.text;
    final String? result = _auth.submitForm(title);

    if (result != null) {
      setState(() {
        _errorMessage = result;
      });
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    widget.onSubmit(title);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              key: Key('title_key'),
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Title',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              child: ElevatedButton(
                key: Key('add_item_button_key'),
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(
                  'Add new item',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
