import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:landing_page/screens/LogInPage.dart';
import 'package:landing_page/screens/LoggedInPage.dart';
import 'package:landing_page/screens/SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:landing_page/screens/readUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;

//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://source.unsplash.com/random/1080x1920"),
                    fit: BoxFit.cover)),
          ),
          Center(
            child: Transform(
              transform: Matrix4.skewX(0.0),
//            angle: -0.1,
              child: Text(
                "Bon Voyage",
                style: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.redAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.blueAccent,
                      offset: Offset(5.0, 5.0),
                    ),
                    Shadow(
                      color: Colors.deepOrangeAccent,
                      blurRadius: 30.0,
                      offset: Offset(-5.0, 5.0),
                    ),
                  ],
                  fontFamily: 'Sacramento',
//                  fontWeight: FontWeight.w700,
                  fontSize: 65.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 7.0),
                      child: RaisedButton(
                        splashColor: Colors.blueAccent,
                        elevation: 5.0,
                        color: Colors.black54,
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          debugPrint('Log In tapped');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LogInPage();
                          }));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 7.0),
                      child: RaisedButton(
                        splashColor: Colors.blueAccent,
                        elevation: 5.0,
                        color: Colors.black54,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          debugPrint('Sign Up tapped');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpPage();
                          }));
                        },
                      ),
                    ),
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
