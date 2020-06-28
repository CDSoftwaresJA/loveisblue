import 'package:flutter/cupertino.dart';
import 'package:loveisblue/pages/webview.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../navigator.dart';

class Tile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String id;
  final bool showSub;
  const Tile({this.snapshot, this.id, this.showSub});

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

    Color status = Colors.black;
    if (snapshot.data['level'] == "1") {
      status = Colors.yellow[900];
    }
    if (snapshot.data['level'] == "2") {
      status = Colors.red[900];
      ;
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
              visualDensity: VisualDensity.compact,
              isThreeLine: true,
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
              trailing: Icon(Icons.more_vert),
              title: Text(
                snapshot.data["displayname"],
                style: TextStyle(color: status, fontWeight: FontWeight.bold),
              ),
              subtitle: Visibility(
                visible: showSub,
                child: message,
              ),
              onTap: () async {
                if (snapshot.data['type'] == "audio") {
                  AudioPlayer audioplayer = AudioPlayer(playerId: "loveisblue");
                  audioplayer.play(
                    snapshot.data["message"],
                  );
                }
                if (snapshot.data["type"] == "text") {}
                if (snapshot.data["type"] == "link") {

                  
                  Navigator.push(
                    Nav.context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            WebView(snapshot.data["message"])),
                  );
                }

                // if (snapshot.data["audio"]) {}
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

  share() {
    Share.share(
        "${snapshot.data["displayname"].toString().toUpperCase()} : ${snapshot.data["message"]} SENT VIA loveisblue ");
  }

  archive() {
    Firestore.instance
        .collection("users")
        .document(id)
        .collection('archive')
        .add({
      "id": snapshot.documentID,
      "message": snapshot.data["message"],
      "type": snapshot.data['type']
    });
  }

  delete() {
    Firestore.instance
        .collection("users")
        .document(id)
        .collection("interactions")
        .document(snapshot.documentID)
        .delete();
  }


}
