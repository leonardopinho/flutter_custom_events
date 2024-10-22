import 'package:events/events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Event is received by SecondWidget when dispatched from FirstWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Column(
          children: [
            FirstWidget(),
            SecondWidget(),
          ],
        ),
      ),
    );

    expect(find.text('No message received'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Hello from FirstWidget'), findsOneWidget);
  });
}

class FirstWidget extends StatelessWidget {
  const FirstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Event.instance.dispatchEvent('my_event', value: 'Hello from FirstWidget');
      },
      child: const Text('Dispatch Event'),
    );
  }
}

class SecondWidget extends StatefulWidget {
  const SecondWidget({super.key});

  @override
  _SecondWidgetState createState() => _SecondWidgetState();
}

class _SecondWidgetState extends State<SecondWidget> {
  String receivedMessage = 'No message received';

  @override
  void initState() {
    super.initState();
    Event.instance.addEventListener('my_event', (value) {
      setState(() {
        receivedMessage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(receivedMessage);
  }
}
