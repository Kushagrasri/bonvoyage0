import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:landing_page/screens/readUser.dart';

import '../main.dart';
final SERVER_IP = 'https://5631b014.ngrok.io';

// ignore: must_be_immutable
class LoggedInPage extends StatefulWidget {
  var value;
  var json;

  LoggedInPage(this.value, this.json);

  @override
  State<StatefulWidget> createState() {
    return NewLoginPage(value, json);
  }
}

class NewLoginPage extends State<LoggedInPage> {
  var val;
  var jsonn;

  NewLoginPage(this.val, this.jsonn);

  @override
  Widget build(BuildContext context) {
    debugPrint('inside logged in page');
    debugPrint(jsonn);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(

          body: Column(
            children: <Widget>[
              Container(height: 80.0,),
              Container(
                child: Text(
                  'You are now authenticated in Bon-Voyage',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Amatic',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Container(
                height: 75.0,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Response code $val',
                  )),
              Container(
                height: 100.0,
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    child: Text('User Profile'),
                    onPressed: () {
                      debugPrint('User profile tapped  $jsonn');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return readUserhere(jsonn);
                          }));
                      debugPrint('User profile reached');
                    }),
              ),
              Container(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    child: Text('Visited places'),
                    onPressed: () {
                      debugPrint('Tapped visited places $jsonn');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return readUserhere(jsonn);
                          }));
                      debugPrint('visited places reached');
                    }),
              ),
              Container(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                    child: Text('Comment section'),
                    onPressed: () {
                      debugPrint('Tapped comment section  $jsonn');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return readUserhere(jsonn);
                          }));
                      debugPrint('comment section reached');
                    }),
              ),
              Container(height: 20.0),
              Row(
                children: <Widget>[
                  Container(width: 20.0),
                  Expanded(

                    child: RaisedButton(
                        child: Text('Log Out'),
                        onPressed: () {
                          debugPrint('LOGOUT TAPPED');
                          logoutHere('$jsonn');
                          debugPrint('Logout done');
                        }
                    ),
                  ),
                  Container(width: 20.0),
                  Expanded(

                    child: RaisedButton(
                        child: Text('Log Out ALL'),
                        onPressed: () {
                          debugPrint('LOGOUT ALL DEVICES TAPPED');
                          logoutAllDev('$jsonn');
                          debugPrint('Logout done');
                        }
                    ),
                  ),
                  Container(width: 20.0),
                ],
              ),
            ],
          ),
        ));
  }



  Future logoutHere(String _token) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token"
    };


    http.Response res = await http.post(
      "$SERVER_IP/users/logout",
      headers: headers,
    );

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp()
        ),
        ModalRoute.withName("../main")
    );
  }

  Future logoutAllDev(String _token) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token"
    };


    http.Response res = await http.post(
      "$SERVER_IP/users/logoutAll",
      headers: headers,
    );

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MyApp()
        ),
        ModalRoute.withName("../main")
    );
  }


}

class readUserhere extends StatefulWidget {
  var _token;

  readUserhere(this._token);

  @override
  State<StatefulWidget> createState() {
    return readIt(_token);
  }
}

class readIt extends State<readUserhere> {
  var _token;

  readIt(value) {
    _token = value;
  }

  @override
  Widget build(BuildContext context) {
//    Future jsonData = readUserQ(_token);
    debugPrint('While reading user');
    debugPrint(_token);
    return WillPopScope(
      // ignore: missing_return
        onWillPop: () {
          Navigator.pop(context, true);
        },
        child: Scaffold(
          body: Column(children: <Widget>[
            Container(height: 150.0),
            Container(

              child: FutureBuilder(
                future: readUserQ(_token),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading....');
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return new Text(
                          'Result: \n\n\n${snapshot.data}',
                          textAlign: TextAlign.center,
                        );
                  }
                },
              ),
            ),
          ]),
        ));
  }

  Future<String> readUserQ(var _value) async {


    var _token = _value;
    debugPrint('While calling API');
    debugPrint(_token);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token",
    };

    Response res = await http.get(
      '$SERVER_IP/users/me',
      headers: headers,
    );

    String ass = res.body;
    print(ass);

    debugPrint('Read User API done');
    debugPrint(_token);
    return ass;
  }

}
