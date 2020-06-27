import 'package:breathe/breathe_screen/timer.dart';
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

  //  Animation growingContainer;
  //  Animation growingCircle;
  //  @override
  void initState() {
    super.initState();
    //  controller = AnimationController(vsync: this, duration: Duration(seconds:3));
  }

  start() {
    setState(() {
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

  navigateToChart() {
    //TODO
  }


  final oneSec = const Duration(seconds: 1);
  beginExcerciseRoutine(){
    this.sessionState = nextState(sessionState);
    countDown = 5;
    countDownTimer = Timer.periodic(oneSec, (timer) { 
      //Decrement the countDown
      setState(() {
        countDown--;
        if (countDown < 0){
          countDown = 5;
          sessionState = nextState(sessionState);
        }
      
      });

    });
  }

  SessionState nextState(SessionState state){
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
        text = "Breath in Slowly";
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
  Widget actionButton(SessionState state){
    //if state is initial, show start button
    if (state == SessionState.Initial) {
      return FloatingActionButton(
        onPressed: this.start,
        child: Icon(Icons.play_arrow), 
      );
    
    //Else show stop button
    } else if (state == SessionState.Ended) {
      return FloatingActionButton(
        onPressed: this.navigateToChart(),
        child: Icon(Icons.insert_chart)
      );
    }else {
      return FloatingActionButton(
        onPressed: this.stop,
        child: Icon(Icons.stop)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Stack(
        children: [
          this._background(context), //background image/animation
          TimerText(dependencies: this.timer,),
          this.foreground(context) //everything in the foreground
        ],
      ),
      floatingActionButton: this.actionButton(this.sessionState),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                    child: countDown != null? Text('$countDown') : Text(''),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(instructionText(sessionState)),
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


