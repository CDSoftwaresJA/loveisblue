import 'package:loveisblue/global.dart';
import 'package:loveisblue/widgets/tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveisblue/widgets/profiletile.dart';

class Details extends StatefulWidget {
  final String id;
  Details(this.id);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border.all(width: 0.2),
          backgroundColor: Colors.white12,
          middle: Text("Report"),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                SizedBox(height: MediaQuery.of(context).size.height * 0.12)
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Tip("This is a list of all the people you came in contact with, click to show the location of where you interacted"),
     
              ]),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(Global.id)
                  .collection("interactions")
                  .snapshots(),
              builder: (context, interaction) {
                if (interaction.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                            .collection('users')
                            .document(
                                interaction.data.documents[index].documentID)
                            .snapshots(),
                        builder: (context, profile) {
                          if (profile.hasData) {
                            double distance = interaction
                                .data.documents[index].data['distance'];

                            GeoPoint geoPoint = interaction
                                .data.documents[index].data['location'];
                            if (interaction
                                    .data.documents[index].data['broken'] !=
                                null) {
                              distance = interaction
                                  .data.documents[index].data['broken'];
                            }
                            if (profile.data.exists) {
                              return ProfileTile(
                                id: Global.id,
                                snapshot: profile.data,
                                image: profile.data['picture'],
                                name: profile.data.data["displayname"],
                                distance:
                                    '${distance.toStringAsFixed(2)} Meters',
                                geoPoint: geoPoint,
                              );
                            }
                            return ProfileTile(
                              id: Global.id,
                              snapshot: profile.data,
                              image:
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1024px-Circle-icons-profile.svg.png',
                              name: "Unknown User",
                              distance: '${distance.toStringAsFixed(2)} Meters',
                              geoPoint: geoPoint,
                            );
                          }
                          return Container();
                        },
                      );
                    }, childCount: interaction.data.documents.length),
                  );
                }
                return SliverList(
                  delegate: SliverChildListDelegate([]),
                );
              },
            ),
          ],
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
