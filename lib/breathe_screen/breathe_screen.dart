import 'package:flutter/material.dart';

//model for a breathing session
class BreatheSession {
  int inBreaths; //how many in breaths
  int outBreaths; //how many out breaths
  double sessionLengthSeconds; //total length of session
}

class BreatheScreen extends StatefulWidget {
  BreatheScreen() : super();

  final String title = "Breathe";

  @override
  _BreatheScreenState createState() => _BreatheScreenState();
}

class _BreatheScreenState extends State<BreatheScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
