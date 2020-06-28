import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsAll extends StatefulWidget {
  final Set<Marker> markers;
  final String name;
  MapsAll(this.name,this.markers);

  @override
  _MapAllState createState() => _MapAllState();
}

class _MapAllState extends State<MapsAll> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.name),
      ),
      body: GoogleMap(
        compassEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target: widget.markers.first.position,
            tilt: 59.440717697143555,
            zoom: 0),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: widget.markers,
      ),
    );
  }
}
