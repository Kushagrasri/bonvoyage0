import 'dart:io';
import 'package:landing_page/main.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:landing_page/screens/LoggedInPage.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart';

final SERVER_IP = 'https://5631b014.ngrok.io';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpKaro();
  }
}

class SignUpKaro extends State<SignUpPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
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
                      image: AssetImage("images/sophie.jpg"),
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
                      'Make your journey beautiful :)',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Raleway',
//                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.blueAccent,
                            offset: Offset(5.0, 5.0),
                          ),
                          Shadow(
                            blurRadius: 15.0,
                            color: Colors.deepOrange,
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
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: TextFormField(
//                    keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white70,
                          ),
                          controller: nameController,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your name';
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.android),
                              labelText: 'Name',
                              hintText: 'eg. Kushagra',
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
                              return 'Please enter email';
                            }
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.alternate_email),
                              labelText: 'Email',
                              hintText: 'eg. kush@abc.com',
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
                              hintText: 'eg. gabbieCarter69',
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
                        "Register",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        debugPrint('Register Tapped');
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            createAlbum(nameController, usernameController,
                                passwordController);
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

  Future createAlbum(TextEditingController name, TextEditingController user,
      TextEditingController pass) async {
    debugPrint(name.text);
    debugPrint(user.text);
    debugPrint(pass.text);
    String n = name.text;
    String a = user.text;
    String b = pass.text;

    String json =
        '{"name":"nlikasvniva","email":"aafshbjk@icna.com","password":"iknegcas23"}';
    int n1 = json.length;
    debugPrint('$n1');

    var _token = 'dwfquwkvcadb829.auvnvfqwfie2.r3cwfqs';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token",
    };

    http.Response res = await http.post(
      "$SERVER_IP/users",
      headers: headers,
      body: jsonEncode(
          <String, String>{"name": "$n", "email": "$a", "password": "$b"}),
    );

    if (res.statusCode == 400) {
      debugPrint('User exists already');
      showDialog(
          context: context,
          // ignore: missing_return
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text('ERROR'),
                content: Text('Invalid Email or Password'),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        child: Text('GoTo Home Page'),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                              ModalRoute.withName("../main"));
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        child: Text('Close Dialog'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                  Container(width: 1.5,),
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
