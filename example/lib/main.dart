import 'package:custom_events/custom_events.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Events',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Events example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ExampleEvents { INCREMENT }

class _MyHomePageState extends State<MyHomePage> {
  CustomEvents events = CustomEvents.instance;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    events.addEventListener(ExampleEvents.INCREMENT, () {
      setState(() {
        _counter++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: IncrementWidget());
  }
}

class IncrementWidget extends StatelessWidget {
  CustomEvents events = CustomEvents.instance;

  IncrementWidget({super.key});

  void _incrementCounter() {
    events.dispatchEvent(ExampleEvents.INCREMENT);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
