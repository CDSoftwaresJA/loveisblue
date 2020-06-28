import 'package:loveisblue/pages/details.dart';
import 'package:loveisblue/pages/mapall.dart';
import 'package:loveisblue/pages/shareprofile.dart';
import 'package:loveisblue/providers/animation.dart';
import 'package:loveisblue/utils/theme.dart';
import 'package:loveisblue/widgets/button.dart';
import 'package:loveisblue/widgets/button2.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveisblue/global.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../navigator.dart';
import 'package:loveisblue/widgets/tip.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  static Themes themes = Themes();
  String id = Global.id;
  AnimationProvider animationProvider;

  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 20000),
      vsync: this,
    )..repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    animationProvider = Provider.of<AnimationProvider>(context, listen: true);

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border.all(width: 0.2),
          backgroundColor: Colors.white12,
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Profile",
              ),
            ],
          ),
        ),
        child: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              )
            ]),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Color status = Colors.black;
                  if (snapshot.data['level'] == "1") {
                    status = Colors.yellow;
                  }
                  if (snapshot.data['level'] == "2") {
                    status = Colors.red;
                  }
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (_, child) {
                              return Transform.rotate(
                                angle: _controller.value * 2 * math.pi,
                                child: child,
                              );
                            },
                            child: Container(
                                height: animationProvider.height,
                                width: animationProvider.width,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          snapshot.data['picture']),
                                    ))),
                          ),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot.data['picture']),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            snapshot.data['displayname'],
                            style: TextStyle(
                                color: status,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("@" + snapshot.data['username'],
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300)),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Exposure Count: ${snapshot.data['count']}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(snapshot.data['bio'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('users')
                                .document(Global.id)
                                .collection("interactions")
                                .snapshots(),
                            builder: (context, interaction) {
                              if (interaction.hasData) {
                                Set<Marker> markers = <Marker>{};
                                interaction.data.documents.forEach((element) {
                                  GeoPoint geoPoint = element.data['location'];
                                  print(geoPoint.toString());
                                  markers.add(Marker(
                                      markerId: MarkerId(element.documentID),
                                      position: LatLng(geoPoint.latitude,
                                          geoPoint.longitude)));
                                });

                                return RoundedButtonWidget(
                                  buttonText: "Contact Map",
                                  buttonColor: CupertinoColors.black,
                                  onPressed: () {
                                    Navigator.push(
                                      Nav.context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              MapsAll("Contact Map", markers)),
                                    );
                                  },
                                );
                              }
                              return RoundedButtonWidget(
                                buttonText: "Loading",
                                buttonColor: CupertinoColors.black,
                                onPressed: () {
                                  Set<Marker> markers = <Marker>{};
                                  Navigator.push(
                                    Nav.context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            MapsAll("Contact Map", markers)),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SolidButton(
                            buttonText: "Report",
                            buttonColor: Hexcolor("#3870FF"),
                            onPressed: () async {
                              Navigator.push(
                                  Nav.context,
                                  CupertinoPageRoute(
                                      builder: (context) => Details(id)));
                            },
                          ),
                        ],
                      ),
                      Divider()
                    ]),
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate([]),
                );
              }),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            ]),
          ),
        ]));
  }
}
