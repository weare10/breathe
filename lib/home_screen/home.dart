
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Container(
        child: _body(),
      )
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body() {
    return Stack(
      children: [
        _header()
      ],
    );
  }

  Widget _header(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/images/breathe_header.png'),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Image.asset('assets/images/breathe_title.png'),
        ),
        Spacer(),
        FlatButton(
          color: Colors.amber[200],
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40),
          child: Text("Login", style: TextStyle(fontSize: 20),),
          onPressed: () => Navigator.pushNamed(context, '/breathe'),
        ),
        Spacer(),
      ],
    );
  }


}
