import 'package:breathe/breathe_screen/timer.dart';
import 'package:breathe/stats_screen/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

enum SessionState {
  Initial,
  Starting,
  HoldBreathIn,
  HoldBreathOut,
  BreathingIn,
  BreathingOut,
  Ended,
  Invalid
}

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

  var sessionState = SessionState.Initial;

  final TimerModel timer = new TimerModel();
  String display;
  int countDown = 0;
  Timer countDownTimer;
  var goUp = false;

  @override
  void initState() {
    super.initState();
  }

  start() {
    setState(() {
      goUp = !goUp;
      selected = !selected;
      timer.stopwatch.start();
      this.beginExcerciseRoutine();
    });
  }

  stop() {
    setState(() {
      timer.stopwatch.stop();
      this.sessionState = SessionState.Ended;
      this.countDownTimer.cancel();
      this.countDown = null;
    });
  }

//  navigateToChart() {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => StatsScreen(),
//      ),
//    );
//  }

  final oneSec = const Duration(seconds: 1);
  beginExcerciseRoutine() {
    this.sessionState = nextState(sessionState);
    countDown = 5;
    countDownTimer = Timer.periodic(oneSec, (timer) {
      //Decrement the countDown
      setState(() {
        countDown--;
        if (countDown < 0) {
          countDown = 5;
          sessionState = nextState(sessionState);
        }
      });
    });
  }

  SessionState nextState(SessionState state) {
    SessionState next;
    switch (state) {
      case SessionState.Initial:
        next = SessionState.Starting;
        break;
      case SessionState.Starting:
        next = SessionState.BreathingIn;
        break;
      case SessionState.BreathingIn:
        next = SessionState.HoldBreathIn;
        break;
      case SessionState.BreathingOut:
        next = SessionState.HoldBreathOut;
        break;
      case SessionState.HoldBreathIn:
        next = SessionState.BreathingOut;
        break;
      case SessionState.HoldBreathOut:
        next = SessionState.BreathingIn;
        break;
      case SessionState.Ended:
        next = SessionState.Ended;
        break;
      default:
        next = SessionState.Invalid;
        break;
    }
    return next;
  }

  //Returns the appropriate instruction string based
  //on the given state
  String instructionText(SessionState state) {
    String text;
    switch (state) {
      case SessionState.Initial:
        text = "Press Play to Begin";
        break;
      case SessionState.Starting:
        text = "Get Ready...";
        break;
      case SessionState.BreathingIn:
        text = "Breathe in Slowly";
        break;
      case SessionState.BreathingOut:
        text = "Breathe out Slowly";
        break;
      case SessionState.HoldBreathIn:
      case SessionState.HoldBreathOut:
        text = "Hold";
        break;
      case SessionState.Ended:
        text = "Great Job!";
        break;
      default:
        text = "INVALID STATE";
        break;
    }
    return text;
  }

  //returns the action button based on session state
  Widget actionButton(SessionState state) {
    //if state is initial, show start button
    if (state == SessionState.Initial) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: this.start,
          child: Icon(Icons.play_arrow),
        ),
      );

      //Else show stop button
    } else if (state == SessionState.Ended) {
      return FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: () {
            Navigator.pushNamed(context,'/stats');
          },
          child: Icon(Icons.insert_chart));
    } else {
      return FloatingActionButton(
          backgroundColor: Colors.yellow.shade900,
          onPressed: this.stop,
          child: Icon(Icons.stop));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Stack(
        children: [
          this._background(context), //background image/animation
          TimerText(
            dependencies: this.timer,
          ),
          this.foreground(context) //everything in the foreground
        ],
      ),
      floatingActionButton: this.actionButton(this.sessionState),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  var person = AssetImage('assets/images/guy_meditate.png');
  //draw background
  Widget _background(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: this._mountainLayer(context)),
        Align(
          alignment: Alignment.center,
          //Avatar over the Mountains
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            onEnd: () => setState(() {
              goUp = !goUp;
            }),
            padding: EdgeInsets.only(
              top: goUp ? 0 : 50,
              bottom: goUp ? 250 : 150,
            ),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  goUp = !goUp;
                });
              },
              child: Image(
                image: person,
                height: 200,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //draw mountain view layer
  Widget _mountainLayer(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/images/mountain_view.png'),
    );
  }

  circle() {
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  double getDiameter(SessionState state) {
    double diameter;
    switch (state) {
      case SessionState.Initial:
        diameter = 30;
        break;
      case SessionState.Starting:
        diameter = 30;
        break;
      case SessionState.BreathingIn:
        diameter = 100;
        break;
      case SessionState.BreathingOut:
        diameter = 30;
        break;
      case SessionState.HoldBreathIn:
        diameter = 100;
        break;
      case SessionState.HoldBreathOut:
        diameter = 30;
        break;
      case SessionState.Ended:
        diameter = 100;
        break;
      default:
        diameter = 5;
        break;
    }
    return diameter;
  }

  Widget foreground(BuildContext context) {
    if (display == null) {
      display = 'Get ready';
    }
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 300),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  person = AssetImage('assets/images/girl_meditate.png');
                });
              },
              child: Image(
                image: AssetImage('assets/images/girl_meditate.png'),
                height: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 300),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  person = AssetImage('assets/images/guy_meditate.png');
                });
              },
              child: Image(
                image: AssetImage('assets/images/guy_meditate.png'),
                height: 50,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 225),
            child: AnimatedContainer(
              duration: Duration(seconds: 5),
              color: Colors.white,
              width: 500,
              height: 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      instructionText(sessionState),
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 5),
                          width: getDiameter(sessionState),
                          height: getDiameter(sessionState),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                          child: countDown != null
                              ? Text(
                                  '$countDown',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                )
                              : Text(''),
                          alignment: Alignment.center,
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
