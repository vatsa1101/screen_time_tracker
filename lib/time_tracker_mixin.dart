import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'local_database.dart';
import 'screen_time_tracker.dart';

mixin TimeTracker<T extends StatefulWidget> on State<T> {
  String? get name => null;
  Map<String, dynamic>? get params => null;
  Widget body(BuildContext context);
  Function? get onScreenHideCallback => null;
  Function? get onScreenVisibleCallback => null;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () async {
        final String screen = context.widget.key.toString();
        if (onScreenVisibleCallback != null) {
          await onScreenVisibleCallback!();
        }
        if (ScreenTimeTracker.onVisibleCallback != null) {
          await LocalDb.saveTime(screen);
          await ScreenTimeTracker.onVisibleCallback!(
            name ?? runtimeType.toString(),
            params,
          );
        }
      },
      onFocusLost: () async {
        final String screen = context.widget.key.toString();
        if (onScreenHideCallback != null) {
          await onScreenHideCallback!();
        }
        if (ScreenTimeTracker.onHideCallback != null) {
          final int time = await LocalDb.getTime(screen);
          await ScreenTimeTracker.onHideCallback!(
            name ?? runtimeType.toString(),
            params,
            (DateTime.now().millisecondsSinceEpoch - time) / 1000,
          );
        }
      },
      child: body(context),
    );
  }
}
