# Custom Events
[![pub package](https://img.shields.io/pub/v/custom_events.svg)](https://pub.dev/packages/custom_events)

This package helps you manage custom events in Flutter apps in a simple and lightweight way. It lets you easily add event listeners to simple widgets, making it easier for different parts of your app to communicate.

## Features

* Easy creation of custom events.
* Simple listener management.
* Uses the **Singleton** pattern for centralized event control.

## 🛠️ Usage

### Adding Listeners:
```dart
enum App { LOGIN, LOGOUT }

CustomEvents.instance.addEventListener(App.LOGIN, (data) {
  print('User logged in: $data');
});
```

### Dispatching Events:
```dart
CustomEvents.instance.dispatchEvent(App.LOGIN, value: {'user': 'John'});
```

### Removing Listeners:
* Remove all listeners for a given state:

```dart
CustomEvents.instance.removeEventListener(App.LOGIN);
```

* Remove a specific listener by reference:
```dart
var listenerFunction = (data) => print('Logout: $data');
CustomEvents.instance.addEventListener(App.LOGOUT, listenerFunction);

// Later, remove it:
CustomEvents.instance.removeEventListener(App.LOGOUT, listener: listenerFunction);
```

## Dependencies
* `uuid`: Used for generating unique listener identifiers.

```yaml
dependencies:
  uuid: ^4.4.0
```

## Complete Example
Here's a simple and practical example demonstrating usage:

```dart
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
```

## License
This project is licensed under the BSD 2-Clause License – see the [LICENSE](LICENSE) file for details.

