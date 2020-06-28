import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  StatsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

var selectedButton = 'This Session';
var length = "Length of Session";
var time = "1:20";
var deepNum = "10";
var streak = "Current Streak";
var streakNum = "2";

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        title: Text('Your Stats'),
        centerTitle: true,
        backgroundColor: Colors.yellow.shade800,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = "This Session";
                      selectedButton = 'This Session';
                      length = "Length of Session";
                      time = "1:20";
                      deepNum = "10";
                      streak = "Current Streak";
                      streakNum = "2";
                    });
                  },
                  child: Text(
                    'This Session',
                    style: TextStyle(
                      fontSize: 25,
                      color: selectedButton == "This Session"
                          ? Colors.yellow.shade900
                          : Colors.black,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = "All Time";
                      length = "Total Session time";
                      time = "6:00";
                      deepNum = "50";
                      streak = "Number of Sessions";
                      streakNum = "5";
                    });
                  },
                  child: Text(
                    'All Time',
                    style: TextStyle(
                      fontSize: 25,
                      color: selectedButton == "All Time"
                          ? Colors.yellow.shade900
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Image(
              image: AssetImage('assets/images/trophy.png'),
              height: 100,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  width: 300,
                  height: 100,
                  color: Colors.yellow.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        length,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.yellow.shade100,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Deep Breaths Taken',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Text(
                              deepNum,
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        height: 150,
                        width: 140,
                        color: Colors.yellow.shade100,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                streak,
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              streakNum,
                              style: TextStyle(
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
