import 'package:loveisblue/providers/switch.dart';
import 'package:loveisblue/utils/transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mock_data/mock_data.dart';
import 'package:provider/provider.dart';

import '../global.dart';
import 'navigate.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 500,
                child: Image.network("https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/title.gif?alt=media&token=bb652fef-a3ed-437d-8ea9-5b8d55e3a8e9")),
            FutureBuilder<String>(
              future: FlutterBluetoothSerial.instance.address,
              builder: (context, string) {
                if (string.hasData) {
                  Global.id = string.data;

                  return FlatButton(
                    child: Text("Login Demo"),
                    onPressed: () {
                      Firestore.instance
                          .collection('users')
                          .document(Global.id)
                          .snapshots()
                          .listen((event) {
                        if (event.exists) {
                          openNav(context);
                          return;
                        }
                        String name = mockName();
                        Firestore.instance
                            .collection('users')
                            .document(Global.id)
                            .setData({
                          "bio": mockString(),
                          "displayname": name,
                          "message": "Welcome to loveisblue",
                          "level": "0",
                          "count": 0,
                          "picture":
                              "https://source.unsplash.com/random/${mockInteger(200, 300)}*${mockInteger(200, 300)}",
                          "type": "text",
                          "username": name + '${mockInteger(1, 100)}'
                        });
                      });
                    },
                  );
                }
                return Container();
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }

  openNav(BuildContext context) {
    Navigator.of(context).pushReplacement(createRoute(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SwitchState()),
      ],
      child: Navigate(),
    )));
  }
}
