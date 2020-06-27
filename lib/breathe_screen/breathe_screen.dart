import 'package:flutter/material.dart';

//model for a breathing session
class BreatheSession {
  int inBreaths; //how many in breaths
  int outBreaths; //how many out breaths
  double sessionLengthSeconds; //total length of session
}

class BreatheScreen extends StatefulWidget {
  BreatheScreen() : super();

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
      backgroundColor: Colors.amber[100],
      body: Stack(
        children: [
          this._background(context), //background image/animation
          this.foreground(context) //everything in the foreground
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //draw background
  Widget _background(BuildContext context) {
    return Stack(
      children: [
        this._mountainLayer(context),
      ],
    );
  }

  //draw mountain view layer
  Widget _mountainLayer(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children : [
          Spacer(),
          Image.asset('assets/images/mountain_view.png'),
        ]
      )
    );
  }


  Widget foreground(BuildContext context) {
    return Container(
      child: Center(
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
