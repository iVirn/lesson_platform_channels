import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final DynamicLibrary _nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

final int Function(int x, int y) _nativeAdd = _nativeAddLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

class FfiExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FFI Example'),
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
  int _term1 = 0;
  int _term2 = 0;
  int _result = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Term 1 is $_term1',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24),
        ),
        Text(
          'Term 2 is $_term2',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24),
        ),
        Text(
          'Result is $_result',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text('Increment term1'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                primary: Colors.white,
              ),
              onPressed: () => setState(() {
                _term1++;
                _result = _nativeAdd(_term1, _term2);
              }),
            ),
            TextButton(
              child: Text('Decrement term1'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                primary: Colors.white,
              ),
              onPressed: () => setState(() {
                _term1--;
                _result = _nativeAdd(_term1, _term2);
              }),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text('Increment term2'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.brown,
                primary: Colors.white,
              ),
              onPressed: () => setState(() {
                _term2++;
                _result = _nativeAdd(_term1, _term2);
              }),
            ),
            TextButton(
              child: Text('Decrement term2'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.brown,
                primary: Colors.white,
              ),
              onPressed: () => setState(() {
                _term2--;
                _result = _nativeAdd(_term1, _term2);
              }),
            ),
          ],
        ),
      ],
    );
  }
}
