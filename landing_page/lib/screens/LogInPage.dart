import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:landing_page/screens/LoggedInPage.dart';
import 'package:http/http.dart' as http;

//import 'package:dio/dio.dart';
final SERVER_IP = 'https://5631b014.ngrok.io';

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInKaro();
  }
}

class LogInKaro extends State<LogInPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Inside login page');
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context);
      },

      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(width: 600.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/interstellar.jpg"),
                      fit: BoxFit.cover)),
            ),
            Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 50.0,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
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
//                      fontWeight: FontWeight.w700,
                        fontSize: 65.0,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      'We\'ve missed you!',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Raleway',
//                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 15.0,
                            color: Colors.white70,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 30.0,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextFormField(
//                    keyboardType: TextInputType.number,

                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white70,
                          ),
                          controller: usernameController,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter username';
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.alternate_email),
                              labelText: 'Email',
                              hintText: 'email@abc.com',
//                              fillColor: Colors.white30,
                              hintStyle: TextStyle(
                                color: Colors.white70,
                              ),
                              labelStyle: TextStyle(
                                  fontFamily: 'Raleway', color: Colors.white70),
                              errorStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.redAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0, top: 2.0),
                        child: TextFormField(
//                    keyboardType: TextInputType.number,
                          obscureText: _obscureText,

                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white70,
                          ),
                          controller: passwordController,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter password';
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                  ),
                                  onPressed: () {
                                    _toggle();
                                  }),
                              labelText: 'Password',
                              hintText: '* * * * * * * *',
//                              fillColor: Colors.white70,
                              hintStyle: TextStyle(
                                color: Colors.white70,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Raleway',
                                color: Colors.white70,
                              ),
                              errorStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.redAccent,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 100.0,
                      right: 100.0,
                      top: 15.0,
                    ),
                    child: RaisedButton(
                      splashColor: Colors.blueAccent,
                      elevation: 5.0,
                      color: Colors.black54,
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
//                        debugPrint('Enter Tapped');
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            createAlbum(usernameController, passwordController);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createAlbum(
      TextEditingController user, TextEditingController pass) async {
    debugPrint(user.text);
    debugPrint(pass.text);
    String a = user.text;
    String b = pass.text;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    };

    http.Response res = await http.post(
      "$SERVER_IP/users/login",
      headers: headers,
      body: jsonEncode(<String, String>{"email": "$a", "password": "$b"}),
    );
    var x = res.statusCode;
    if (x == 400) {
      debugPrint('Invalid credentials');
      showDialog(
          context: context,
          // ignore: missing_return
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('ERROR'),
                content: Text('Invalid Email or Password'),
                actions: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        child: Text('Close Dialog'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                ]);
          });
    } else {
      String ass = res.body;
      print(ass);

      Map<String, dynamic> answer = jsonDecode(res.body);

      debugPrint('Just after login api called ');
      String required = answer['token'];
      debugPrint(required);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoggedInPage(res.statusCode, required);
      }));
    }
  }
}
