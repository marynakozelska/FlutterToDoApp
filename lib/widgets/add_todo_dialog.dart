import 'package:flutter/material.dart';

class AddToDoDialog extends StatefulWidget {
  final Function(String, String?) onAdd;
  final List<String> existingCategories;

  const AddToDoDialog({
    Key? key,
    required this.onAdd,
    required this.existingCategories,
  }) : super(key: key);

  @override
  _AddToDoDialogState createState() => _AddToDoDialogState();
}

class _AddToDoDialogState extends State<AddToDoDialog> {
  final _todoController = TextEditingController();
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add ToDo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(hintText: 'Enter ToDo'),
          ),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: widget.existingCategories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            hint: Text('Select Category'),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
              widget.onAdd(_todoController.text, _selectedCategory);
              Navigator.pop(context);
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
