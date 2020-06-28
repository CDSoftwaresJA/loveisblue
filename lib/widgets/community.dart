import 'package:flutter/cupertino.dart';
import 'package:loveisblue/pages/members.dart';
import 'package:loveisblue/pages/webview.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';

import '../navigator.dart';

class CommunityTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String id;
  const CommunityTile({this.snapshot, this.id});

  @override
  Widget build(BuildContext context) {
    Widget message = Text(
      snapshot.data["message"],
      style: TextStyle(
          color: Colors.grey[900], fontWeight: FontWeight.w400, fontSize: 12),
    );
    if (snapshot.data["type"] == "image") {
      message = Container(
        color: Colors.black,
        child: Image.network(
          snapshot.data['message'],
          width: MediaQuery.of(context).size.width,
        ),
      );
    }

    if (snapshot.data['type'] == "audio") {
      message = Container(
        child: Text("Shared an audio.",
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w400,
                fontSize: 12)),
      );
    }
    if (snapshot.data['type'] == "link") {
      message = Container(
        child: Text("Shared a link.",
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w400,
                fontSize: 12)),
      );
    }
    if (snapshot.data['type'] == "script") {
      message = Container(
        child: Text("Shared a Script.",
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w400,
                fontSize: 12)),
      );
    }
    return Column(
      children: [
        Material(
          color: Colors.white,
          child: Container(
            color: Colors.white,
            child: ListTile(
              isThreeLine: true,
              visualDensity: VisualDensity.compact,
              trailing: Material(
                  child: InkWell(
                child: Icon(Icons.more_vert),
                onTap: () {
                  bottomSheet(context);
                },
              )),
              leading: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.height * 0.07,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(snapshot.data['picture']),
                    )),
              ),
              title: Text(
                snapshot.data["displayname"],
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: message,
              onTap: () async {
                openStatistics();
              },
            ),
          ),
        ),
        Divider(
          indent: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }

  bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Add Member'),
                    onTap: () => {addMember()}),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('View Members'),
                  onTap: () => {openStatistics()},
                ),
                ListTile(
                  leading: Icon(Icons.people),
                  title: Text('Share'),
                  onTap: () => {share()},
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text(""),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

  share() {
    Share.share(
        "${snapshot.data["displayname"].toString().toUpperCase()} : ${snapshot.data["message"]} SENT VIA loveisblue ");
  }

  addMember() async {}

  openStatistics() {
    Navigator.push(
      Nav.context,
      CupertinoPageRoute(
          builder: (context) => Members(snapshot.documentID,
              snapshot.data['displayname'], snapshot.data['picture'])),
    );
  }
}
