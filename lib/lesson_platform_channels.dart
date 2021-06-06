import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

export 'pigeon/multiply.pigeon.dart';

class LessonPlatformChannels {
  static const MethodChannel _channel =
      const MethodChannel('lesson_platform_channels');

  static const EventChannel _eventChannel =
      const EventChannel('lesson_platform_channels_event_channel');

  static Stream<String> get stream =>
      _eventChannel.receiveBroadcastStream().cast<String>();

  static Future<int?> power2(int value) =>
      _channel.invokeMethod<int>('power2', value);

  static void handleEnterBackground(VoidCallback callback) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'enterBackground') {
        callback();
      }
    });
  }
}
