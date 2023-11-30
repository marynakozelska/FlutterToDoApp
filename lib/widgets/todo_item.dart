import 'package:flutter/material.dart';
import '../model/todo.dart';

typedef OnToDoChanged = void Function(ToDo todo);
typedef OnDeleteItem = void Function(String id);

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final OnToDoChanged onToDoChanged;
  final Function(String) onDeleteItem;
  final List<String> categories;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(todo.toDoText ?? ''),
      subtitle: Text(todo.category ?? ''),
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (newValue) {
          onToDoChanged(todo.copyWith(isDone: newValue ?? false));
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editTask(context); // Open task edit dialog on tap
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id!); // Call onDeleteItem function
            },
          ),
        ],
      ),
    );
  }

  void _editTask(BuildContext context) {
    TextEditingController textEditingController = TextEditingController(text: todo.toDoText);
  
    String? updatedName = todo.toDoText;
    String? updatedCategory = todo.category;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Edit Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        updatedName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Task Name',
                    ),
                    controller: textEditingController,
                  ),
                  DropdownButtonFormField<String>(
                    value: updatedCategory,
                    items: [
                      ...categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }),
                    ],
                    hint: Text('Select Category'),
                    onChanged: (value) {
                      setState(() {
                        updatedCategory = value;
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
                    if (updatedName != null && updatedCategory != null) {
                      onToDoChanged(todo.copyWith(
                        toDoText: updatedName,
                        category: updatedCategory,
                      ));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
