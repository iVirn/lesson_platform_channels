import 'package:flutter/material.dart';
import 'package:lesson_platform_channels_example/plugin_example.dart';

import 'ffi_example.dart';
import 'pigeon_example.dart';
import 'platform_view_example.dart';

class AppRoutes {
  static const home = '/';
  static const pluginExample = 'plugin_example';
  static const pigeonExample = 'pigeon_example';
  static const ffiExample = 'ffi_example';
  static const platformViewExample = 'platform_view_example';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => HomeView(),
        AppRoutes.pluginExample: (_) => PluginExample(),
        AppRoutes.pigeonExample: (_) => PigeonExample(),
        AppRoutes.ffiExample: (_) => FfiExample(),
        AppRoutes.platformViewExample: (_) => PlatformViewExample(),
      },
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextButton(
                    child: Text('Open Plugin Example'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      primary: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.pluginExample),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextButton(
                    child: Text('Open Pigeon Example'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.pigeonExample),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextButton(
                    child: Text('Open FFI Example'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      primary: Colors.white,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(AppRoutes.ffiExample),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextButton(
                    child: Text('Open Platform View Example'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.purple,
                      primary: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.platformViewExample),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
