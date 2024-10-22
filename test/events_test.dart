import 'package:custom_events/custom_events.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('add and initialize event', () {
    CustomEvents evt = CustomEvents.instance;
    bool init = false;

    // change variable
    evt.addEventListener(EventType.START, (bool value) => init = value);
    evt.dispatchEvent(EventType.START, value: true);

    // without listener
    evt.removeEventListener(EventType.START);
    evt.dispatchEvent(EventType.START, value: false);

    expect(init, true);
  });

  test('count listener events', () {
    CustomEvents evt = CustomEvents.instance;
    int counter = 0;

    evt.addEventListener(EventType.START, (_) => counter++);
    evt.addEventListener(EventType.START, (_) => counter++);
    evt.addEventListener(EventType.START, (_) => counter++);
    evt.addEventListener(EventType.START, (_) => counter++);

    evt.dispatchEvent(EventType.START);

    evt.removeEventListener(EventType.START);
    evt.removeEventListener(EventType.START);
    evt.removeEventListener(EventType.START);
    evt.removeEventListener(EventType.START);

    evt.dispatchEvent(EventType.START);

    expect(counter, 4);
  });

  test('multiple event types with different listeners', () {
    CustomEvents evt = CustomEvents.instance;
    int startCounter = 0;
    int stopCounter = 0;

    evt.addEventListener(EventType.START, (_) => startCounter++);
    evt.addEventListener(EventType.STOP, (_) => stopCounter++);

    evt.dispatchEvent(EventType.START);
    evt.dispatchEvent(EventType.STOP);
    evt.dispatchEvent(EventType.START);

    expect(startCounter, 2);
    expect(stopCounter, 1);
  });

  test('count listener events with removal of specific listener', () {
    CustomEvents evt = CustomEvents.instance;
    int counter = 0;

    void incrementCounter(_) => counter++;
    evt.addEventListener(EventType.START, incrementCounter);
    evt.addEventListener(EventType.START, incrementCounter);
    evt.addEventListener(EventType.START, incrementCounter);
    evt.addEventListener(EventType.START, incrementCounter);

    evt.dispatchEvent(EventType.START);
    expect(counter, 4);

    evt.removeEventListener(EventType.START, listener: incrementCounter);
    evt.dispatchEvent(EventType.START);
    expect(counter, 7);
  });
}
