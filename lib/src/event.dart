import 'package:uuid/uuid.dart';

import 'abstract_event.dart';
import 'event_item.dart';

class Event extends AbstractEvent {
  final List<EventItem> _listeners = <EventItem>[];

  Event._privateConstructor();

  static final Event _instance = Event._privateConstructor();

  static Event get instance => _instance;

  String _getUuid() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  @override
  void addEventListener(dynamic state, Function function) {
    _listeners.add(EventItem(state, function, _getUuid()));
  }

  @override
  void removeEventListener(dynamic state, {String? listenerId, Function? listener}) {
    if (listenerId != null) {
      _listeners.removeWhere((item) => item.state == state && item.id == listenerId);
    } else if (listener != null) {
      for (int i = 0; i < _listeners.length; i++) {
        if (_listeners[i].state == state && _listeners[i].function == listener) {
          _listeners.removeAt(i);
          break;
        }
      }
    } else {
      _listeners.removeWhere((item) => item.state == state);
    }
  }

  @override
  void dispatchEvent(dynamic state, {dynamic value}) {
    for (var item in _listeners) {
      if (item.state == state) {
        item.function(value);
      }
    }
  }
}
