import 'package:flutter/material.dart';

class Task {
  const Task({required this.name, required this.isDone});
  final String name;
  final bool isDone;
}

void main() => runApp(TrackTasks());

class TrackTasks extends StatelessWidget {
  const TrackTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TasksList(),
    );
  }
}

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _tasks = <Task>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(223, 251, 184, 84),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tasks Tracker'),
          ],
        ),
      ),
      
    );
  }
}
