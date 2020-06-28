import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileNormal extends StatelessWidget {
  final String title,subtitle;
  final IconData icon;
  final String image;
  final VoidCallback onPressed;
  TileNormal({this.title,this.subtitle,this.onPressed, this.icon, this.image});
  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (image == null){
        widget = Icon(icon);
    }else{
      widget = Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.height * 0.07,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  )),
            );
    } 
    return Material(
      color: Colors.white,
      child: ListTile(
        
        leading: widget,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
