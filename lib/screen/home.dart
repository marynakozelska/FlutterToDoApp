import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../widgets/add_todo_dialog.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todosList = ToDo.todoList();
  List<String> categories = ['Work', 'Home', 'Personal'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                for (ToDo todo in todosList.reversed)
                  ToDoItem(
                    todo: todo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                    categories: categories,
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddToDoDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      final index = todosList.indexWhere((element) => element.id == todo.id);
      if (index != -1) {
        todosList[index] = todo;
      }
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _showAddToDoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddToDoDialog(
          onAdd: _addToDoItem,
          existingCategories: categories,
        );
      },
    );
  }

  void _addToDoItem(String toDo, String? category) {
    if (toDo.isNotEmpty) {
      setState(() {
        todosList.add(
          ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            toDoText: toDo,
            category: category,
          ),
        );
      });
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('To Do App'),
    );
  }
}
