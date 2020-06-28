import 'package:flutter/cupertino.dart';
import 'package:loveisblue/navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loveisblue/pages/map.dart';
class ProfileTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final String name, distance, id, image;
  final GeoPoint geoPoint;
  const ProfileTile(
      {this.snapshot, this.name, this.distance, this.id, this.image, this.geoPoint});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        color: Colors.white,
        child: ListTile(
          visualDensity: VisualDensity.compact,
          isThreeLine: false,
          trailing: Icon(Icons.more_vert),
          leading: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.height * 0.07,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                )),
          ),
          title: Text(
            name,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            distance,
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
          onTap: (){
                  Navigator.push(
                    Nav.context,
                    CupertinoPageRoute(builder: (context) => Maps(geoPoint.latitude,geoPoint.longitude,this.name)),
                  );
          },
        ),
      ),
    );
  }

  delete(){
           Firestore.instance
                  .collection("users")
                  .document(id)
                  .collection("interactions")
                  .document(snapshot.documentID)
                  .delete();
  }
}
