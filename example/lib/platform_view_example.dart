import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlatformViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform View Example'),
      ),
      body: Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Platform.isIOS
              ? UiKitView(viewType: 'ExampleView')
              : AndroidView(viewType: 'ExampleView'),
        ),
      ),
    );
  }
}
