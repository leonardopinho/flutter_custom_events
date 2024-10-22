abstract class AbstractEvent {
  void addEventListener(dynamic state, Function function);

  void removeEventListener(dynamic state);

  void dispatchEvent(dynamic state, {dynamic value});
}
