import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
final SERVER_IP = 'https://5631b014.ngrok.io';
class readUser extends StatefulWidget {
  var _token;

  readUser(this._token);

  @override
  State<StatefulWidget> createState() {
    return readIt(_token);
  }
}

class readIt extends State<readUser> {
  var _token;

  readIt(value) {
    _token = value;
  }

  @override
  Widget build(BuildContext context) {
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
    debugPrint(ass);

    debugPrint('read User api called');

    return ass;
  }
}
