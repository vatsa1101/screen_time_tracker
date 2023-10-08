import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:screen_time_tracker/screen_time_tracker.dart';

mixin TimeTracker<T extends StatefulWidget> on State<T> {
  String? get name;
  Map<String, dynamic>? get params;
  Widget body(BuildContext context);
  Function? get onScreenHideCallback => null;
  Function? get onScreenVisibleCallback => null;

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () async {
        if (onScreenVisibleCallback != null) {
          await onScreenVisibleCallback!();
        }
        if (ScreenTimeTracker.onVisibleCallback != null) {
          await ScreenTimeTracker.onVisibleCallback!(
            name ?? runtimeType.toString(),
            params,
          );
        }
      },
      onFocusLost: () async {
        if (onScreenHideCallback != null) {
          await onScreenHideCallback!();
        }
        if (ScreenTimeTracker.onHideCallback != null) {
          await ScreenTimeTracker.onHideCallback!(
            name ?? runtimeType.toString(),
            params,
            0,
          );
        }
      },
      child: body(context),
    );
  }
}
