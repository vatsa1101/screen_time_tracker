library screen_time_tracker;

class ScreenTimeTracker {
  static Future<void> initialize({
    Future<void> Function(String name, Map<String, dynamic>? params)?
        onScreenVisibleCallback,
    Future<void> Function(String name, Map<String, dynamic>? params, int time)?
        onScreenHideCallback,
  }) async {
    onVisibleCallback = onScreenVisibleCallback;
    onHideCallback = onScreenHideCallback;
  }

  static Future<void> Function(String name, Map<String, dynamic>? params)?
      onVisibleCallback;
  static Future<void> Function(
      String name, Map<String, dynamic>? params, int time)? onHideCallback;
}
