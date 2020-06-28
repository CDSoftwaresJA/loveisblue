import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:loveisblue/global.dart';
class ShareProfile extends StatefulWidget {
  @override
  _ShareProfileState createState() => _ShareProfileState();
}

class _ShareProfileState extends State<ShareProfile> {
  String id = Global.id;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          middle: Text("Edit Profile"),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate.fixed([
      
                      
        
            ]))
          ],
        ));
  }
}

