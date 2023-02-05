import 'package:flutter/material.dart';

class Task {
  Task({required this.name, required this.isDone});
  final String name;
  bool isDone;
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: _tasks.map((Task task) {
          return TaskItem(
            task: task,
            onTaskChanged: _handleTaskChanged,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayAddTaskDialog, //will return a function when invoked.  you want it to execute the function.
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  void _handleTaskChanged(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  void _addTaskItem(String taskName) {
    if (taskName.length > 0) {
      setState(() {
        _tasks.add(Task(name: taskName, isDone: false));
      });
      _taskController.clear();
    }
  }
  Future<void> _displayAddTaskDialog() async{
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
          actions: [
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTaskItem(_taskController.text);
              },
            ),
          ],
        );
      },
    );
  }
}

class TaskItem extends StatelessWidget {
  // TaskItem({
  //   required this.task,
  //   required this.onTaskChanged,
  // }) : super(key: ObjectKey(task));
  const TaskItem({super.key, required this.task, this.onTaskChanged});

  final Task task;
  final onTaskChanged;

  TextStyle _getTextStyle() {
    if (task.isDone) {
      return const TextStyle(
        color: Colors.black54,
        decoration: TextDecoration.lineThrough,
      );
    } else {
      return const TextStyle(
        color: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTaskChanged(task);
      },
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(223, 103, 192, 222),
        child: Text(task.name[0]),
      ),
      title: Text(
        task.name,
        style: _getTextStyle(),
      ),
    );
  }
}
