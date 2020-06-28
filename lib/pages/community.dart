import 'package:loveisblue/widgets/community.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveisblue/global.dart';
import 'package:loveisblue/widgets/tip.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  String id = Global.id;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border.all(width: 0.2),
          backgroundColor: Colors.white24,
          middle: Text("Community"),
          trailing: Material(
              color: Colors.white,
              child: InkWell(
                child: Icon(Icons.add),
                onTap: () {
                  Firestore.instance.collection('communities').add({
                    "bio": "Test Community Bio",
                    "displayname": "community",
                    "message": "Welcome to loveisblue",
                    "picture": "https://source.unsplash.com/random/208*208",
                    "type": "text",
                    "username": "community"
                  });
                },
              )),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Tip("These are the communities you are apart of"),
            ])),
            StreamBuilder<QuerySnapshot>(
                stream:
                    Firestore.instance.collection('communities').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return CommunityTile(
                            snapshot: snapshot.data.documents[index], id: id);
                      }, childCount: snapshot.data.documents.length),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildListDelegate.fixed([]),
                  );
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
