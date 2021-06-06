import 'package:flutter/material.dart';
import 'package:lesson_platform_channels/lesson_platform_channels.dart';

class PigeonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pigeon Plugin Example'),
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
  final _api = MultiplyApi();

  int _multiplicand = 0;
  int _multiplier = 0;
  int _result = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Multiplicand is $_multiplicand',
          style: DefaultTextStyle.of(context).style.copyWith(fontSize: 24),
        ),
        Text(
          'Multiplier is $_multiplier',
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
              child: Text('Increment multiplicand'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
              ),
              onPressed: () {
                setState(() => _multiplicand++);
                _multiply();
              },
            ),
            TextButton(
              child: Text('Decrement multiplicand'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                primary: Colors.white,
              ),
              onPressed: () {
                setState(() => _multiplicand--);
                _multiply();
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: Text('Increment multiplier'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                primary: Colors.white,
              ),
              onPressed: () {
                setState(() => _multiplier++);
                _multiply();
              },
            ),
            TextButton(
              child: Text('Decrement multiplier'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                primary: Colors.white,
              ),
              onPressed: () {
                setState(() => _multiplier--);
                _multiply();
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _multiply() async {
    final request = MultiplyRequest();
    request.multiplicand = _multiplicand;
    request.multiplier = _multiplier;

    final result = (await _api.multiply(request)).result;

    if (result != null) {
      setState(() => _result = result);
    }
  }
}
