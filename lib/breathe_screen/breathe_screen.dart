import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

class _BreatheScreenState extends State<BreatheScreen>
    with SingleTickerProviderStateMixin {
  var selected = false;
  AnimationController controller;
//  Animation growingContainer;
//  Animation growingCircle;
//  @override
//  void initState() {
//    super.initState();
//    controller = AnimationController(vsync: this, duration: Duration(seconds:3));
//
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Stack(
        children: [
          this._background(context), //background image/animation
          this.foreground(context) //everything in the foreground
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            selected = !selected;
            startTimer();
          });
        },
        child: Icon(Icons.add),
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
        child: Column(children: [
      Spacer(),
      Image.asset('assets/images/mountain_view.png'),
    ]));
  }

  circle() {
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  Timer _timer;
  var _start = 5;
  void startTimer() {
    const oneSec = const Duration(seconds: 3);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  var display;
  breatheIn() {
    if (_start == 0) {
      setState(() {
        display = "Breathe In";
      });
    }
  }

  Widget foreground(BuildContext context) {
    if (display == null) {
      display = 'Get ready';
    }
    breatheIn();
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 440),
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              color: Colors.white,
              width: 500,
              height: selected ? 50 : 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: selected ? 30 : 100,
                    height: selected ? 30 : 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: selected ? Text('') : Text('$_start'),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: selected
                        ? Text(
                            'Start Breathing Excercise',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text('$display'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
