import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Todo List',
      home: TodoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tasks[index].task,
              // Aplicar tachado si la tarea está completada (checked)
              style: TextStyle(
                decoration:
                    tasks[index].checked ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Checkbox(
              value: tasks[index].checked,
              onChanged: (bool? value) {
                // Actualizar el estado de la tarea cuando cambia el checkbox
                setState(() {
                  tasks[index].checked = value ?? false;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask(context);
        },
        tooltip: 'Agregar Tarea',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Resto del código permanece igual

  void _addTask(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Nueva Tarea'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(hintText: 'Ingrese la tarea'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(taskController.text, false));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}

// Definir una clase Task para representar las tareas
class Task {
  String task;
  bool checked;

  Task(this.task, this.checked);
}
