import 'package:custom_events/custom_events.dart';
import 'package:flutter_test/flutter_test.dart';

enum TestParams { TEST_1, TEST_2 }

void main() {
  test('add and initialize event', () {
    void callWithParams(String param){
      //
    }

    void callWithoutParams(){
      //
    }

    CustomEvents evt = CustomEvents.instance;
    bool init = false;

    // change variable
    evt.addEventListener(TestParams.TEST_1, callWithParams);
    evt.addEventListener(TestParams.TEST_2, callWithoutParams);
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

    evt.addEventListener(EventType.START, () => counter++);
    evt.addEventListener(EventType.START, () => counter++);
    evt.addEventListener(EventType.START, () => counter++);
    evt.addEventListener(EventType.START, () => counter++);

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

    evt.addEventListener(EventType.START, () => startCounter++);
    evt.addEventListener(EventType.STOP, () => stopCounter++);

    evt.dispatchEvent(EventType.START);
    evt.dispatchEvent(EventType.STOP);
    evt.dispatchEvent(EventType.START);

    expect(startCounter, 2);
    expect(stopCounter, 1);
  });

  test('count listener events with removal of specific listener', () {
    CustomEvents evt = CustomEvents.instance;
    int counter = 0;

    void incrementCounter() => counter++;
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
