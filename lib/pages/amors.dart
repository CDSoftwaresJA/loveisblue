import 'package:loveisblue/utils/theme.dart';
import 'package:loveisblue/widgets/tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveisblue/global.dart';
import 'package:loveisblue/widgets/tip.dart';

class Amors extends StatefulWidget {
  @override
  _AmorsState createState() => _AmorsState();
}

class _AmorsState extends State<Amors> {
  static Themes themes = Themes();
  String id = Global.id;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Messages"),
          border: Border.all(width: 0.2),
          backgroundColor: Colors.white24,
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Tip("This is where you receive messages from anyone who you interact with")
            ])),
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(id)
                    .collection('interactions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = List<DocumentSnapshot>();
                    for (DocumentSnapshot snapshot in snapshot.data.documents) {
                      if (snapshot.exists) {
                        documents.add(snapshot);
                      }
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: Firestore.instance
                              .collection('users')
                              .document(documents[index].documentID)
                              .snapshots(),
                          builder: (context, profiles) {
                            if (profiles.hasData) {
                              if (profiles.data.exists) {
                                return Tile(
                                  snapshot: profiles.data,
                                  id: id,
                                  showSub: true,
                                );
                              }
                            }
                            return Container();
                          },
                        );
                      }, childCount: snapshot.data.documents.length),
                    );
                  }
                  return SliverList(
                      delegate: SliverChildListDelegate.fixed([]));
                }),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            ])),
          ],
        ));
  }
}
