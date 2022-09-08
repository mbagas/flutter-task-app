import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:riverpod/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'task.dart';
import 'addTask.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tasks List'),
    );
  }
}

// initiate a TaskList with pre-defined tasks
final taskListProvider = StateNotifierProvider<TaskList, List<Task>>((ref) {
  return TaskList([
    Task(
        id: '1',
        taskName: 'Task 1',
        taskDescription: 'Task 1 description',
        imageUrl: 'https://picsum.photos/250?image=5'),
    Task(
        id: '2',
        taskName: 'Task 2',
        taskDescription: 'Task 2 description',
        imageUrl: 'https://picsum.photos/250?image=6'),
    Task(
        id: '3',
        taskName: 'Task 3',
        taskDescription: 'Task 3 description',
        imageUrl: 'https://picsum.photos/250?image=7'),
    Task(
        id: '4',
        taskName: 'Task 4',
        taskDescription: 'Task 4 description',
        imageUrl: 'https://picsum.photos/250?image=8'),
    Task(
        id: '5',
        taskName: 'Task 5',
        taskDescription: 'Task 5 description',
        imageUrl: 'https://picsum.photos/250?image=9')
  ]);
});

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    void _navigateToAddTask() async {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const AddTaskScreen(
          title: 'Add Task',
        );
      }));
    }

    final tasks = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
          actions: [
            IconButton(
                onPressed: _navigateToAddTask,
                icon: const Icon(Icons.add, color: Colors.white))
          ]),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: ElevatedButton(
              child: const Text("Add Task"),
              onPressed: _navigateToAddTask,
            )),
            Container(
              child: Column(children: <Widget>[
                Text("Tasks"),
                SizedBox(
                    height: 600,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final Task task = tasks[index];

                        return InkWell(
                            onTap: () {},
                            child: Card(
                              child: Row(children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Image.network(task.imageUrl)),
                                Expanded(
                                    flex: 2,
                                    child: Column(children: <Widget>[
                                      Text(task.taskName),
                                      Text(task.taskDescription)
                                    ])),
                                Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      child: const Text("-"),
                                      onPressed: () {
                                        ref
                                            .read(taskListProvider.notifier)
                                            .removeTask(task);
                                      },
                                    ))
                              ]),
                            ));
                      },
                    ))
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
