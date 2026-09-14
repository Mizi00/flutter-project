import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CounterScreen(),
    const TodoListScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning App'),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100.withValues(alpha: 0.4),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle),
                  label: 'Counter',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Todos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Counter App',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              '$_counter',
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _decrement,
                icon: const Icon(Icons.remove),
                label: const Text('Decrement'),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                label: const Text('Increment'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [
    Todo('Learn Flutter basics', false),
    Todo('Build a counter app', true),
    Todo('Create a todo list', false),
  ];

  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(_controller.text, false));
        _controller.clear();
      });
    }
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].completed = !_todos[index].completed;
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addTodo,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: _todos[index].completed,
                  onChanged: (value) => _toggleTodo(index),
                ),
                title: Text(
                  _todos[index].title,
                  style: TextStyle(
                    decoration: _todos[index].completed
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteTodo(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SwitchListTile(
          title: const Text('Enable Notifications'),
          subtitle: const Text('Receive app notifications'),
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Enable dark theme'),
          value: _darkModeEnabled,
          onChanged: (value) {
            setState(() {
              _darkModeEnabled = value;
            });
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('About'),
          subtitle: const Text('Flutter Learning App v1.0.0'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('This is a learning app!')),
            );
          },
        ),
      ],
    );
  }
}

class Todo {
  String title;
  bool completed;

  Todo(this.title, this.completed);
}
