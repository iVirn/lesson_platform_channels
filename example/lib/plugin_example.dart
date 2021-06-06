import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lesson_platform_channels/lesson_platform_channels.dart';

class PluginExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Example'),
      ),
      body: Center(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  int _initialValue = 0;
  int _resultValue = 0;
  DateTime? _fgTimestamp;
  DateTime? _bgTimestamp;

  late StreamSubscription<String> _subscription;

  @override
  void initState() {
    super.initState();

    LessonPlatformChannels.handleEnterBackground(() {
      print('ENTERING BACKGROUND...');
      setState(() => _bgTimestamp = DateTime.now());
    });

    _subscription = LessonPlatformChannels.stream.listen((event) {
      if (event != 'enterForeground') return;

      print('ENTERING FOREGROUND...');
      setState(() => _fgTimestamp = DateTime.now());
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Value is $_initialValue',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24),
        ),
        Text(
          '$_initialValue^2 = $_resultValue',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24),
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        TextButton(
          child: Text('Increment'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            primary: Colors.white,
          ),
          onPressed: () {
            setState(() => _initialValue++);
            _raiseToPower2(_initialValue);
          },
        ),
        TextButton(
          child: Text('Decrement'),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            primary: Colors.white,
          ),
          onPressed: () {
            setState(() => _initialValue--);
            _raiseToPower2(_initialValue);
          },
        ),
        if (_bgTimestamp != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'I have entered background at ${_bgTimestamp?.hour}:${_bgTimestamp?.minute}:${_bgTimestamp?.second}\nlast time',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        if (_fgTimestamp != null)
          Text(
            'I have entered foreground at ${_fgTimestamp?.hour}:${_fgTimestamp?.minute}:${_fgTimestamp?.second}\nlast time',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Future<void> _raiseToPower2(int value) async {
    final result = await LessonPlatformChannels.power2(value);

    if (result != null) {
      setState(() => _resultValue = result);
    }
  }
}
