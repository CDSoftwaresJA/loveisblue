import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final double x, y;
  final String name;
  Maps(this.x, this.y,this.name);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = <Marker>{};


  @override
  Widget build(BuildContext context) {
    markers.add(Marker(position:LatLng(widget.x, widget.y), markerId: MarkerId("main"),icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),infoWindow:InfoWindow(title: widget.name), onTap: (){
      print("Test");
    } ));
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.name),
      ),
      body: GoogleMap(
        compassEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.x, widget.y),
          tilt: 59.440717697143555,
      zoom: 0
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }

  
}
