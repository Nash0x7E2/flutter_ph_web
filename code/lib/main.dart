import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keynote Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double breakpoint = 840.0;
  TextEditingController _controller;
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addTask() {
    final task = _controller.value.text;
    setState(() {
      tasks.add(task);
    });
    _controller.clear();
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello Flutter Philippines'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: addTask,
                    child: Icon(Icons.add),
                  )
                ],
              ),
            ),
            if (media.size.shortestSide > breakpoint)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return LargeItem(
                      color: Colors.accents[index],
                      onRemove: () => removeTask(index),
                      text: tasks[index],
                    );
                  },
                ),
              ),
            if (media.size.shortestSide < breakpoint)
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]),
                      onLongPress: () => removeTask(index),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LargeItem extends StatelessWidget {
  final VoidCallback onRemove;
  final String text;
  final Color color;

  const LargeItem({
    Key key,
    @required this.onRemove,
    @required this.text,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: BoxConstraints(maxHeight: 10.0, minWidth: 10.0),
        color: color,
        child: InkWell(
          onLongPress: onRemove,
          child: Text(text),
        ),
      ),
    );
  }
}
