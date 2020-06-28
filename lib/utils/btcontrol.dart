import 'dart:async';
import 'dart:io';
import 'package:loveisblue/navigator.dart';
import 'package:loveisblue/object/device.dart';
import 'package:loveisblue/pages/settings.dart';
import 'package:encrypt/encrypt.dart' as Enc;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'dart:math' show pow;
import 'package:synchronized/synchronized.dart';
import 'package:loveisblue/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BTControl {
  StreamSubscription bleDetection;
  static const stream = const EventChannel('stream');
  List<Device> devices = List<Device>();
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  final key = Enc.Key.fromLength(32);
  final iv = Enc.IV.fromLength(8);
  Encrypter encrypter;
  String id = Global.id;
  static int limit = -50;
  bool ble = false, broadcast = false;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  static int played = 0;
  var lock = Lock();

  BTControl() {
    encrypter = Enc.Encrypter(Enc.Salsa20(key));
  }
  addDevice(Device device) async {
    double distance = getDistance(device.rssi, -59);

    // FIX LINE
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high,locationPermissionLevel: GeolocationPermission.locationAlways);
    //    Position position= Position(latitude: 10,longitude: 10);
      
    Firestore.instance
        .collection('users')
        .document(id)
        .collection('interactions')
        .document(device.id)
        .setData({
      "distance": distance,
      
      "timestamp": Timestamp.now(),
      "location": (GeoPoint(position.latitude, position.longitude))
    }, merge: true);

    if (device.rssi > limit) {
      if (played == 0) {
        if (ttsState == TtsState.stopped) {
          ttsState = TtsState.playing;
          lock.synchronized(() async {
            var result = await flutterTts.speak(
                "You are aproximately ${distance.toStringAsFixed(2)} meters close to someone, Please maintain social distancing.");
          });
          ttsState = TtsState.stopped;
        }
        showDialog(
            context: Nav.context,
            builder: (context) => new CupertinoAlertDialog(
                title: new Text("Alert"),
                content: Text(
                    "You are aproximately ${distance.toStringAsFixed(2)} meters close to someone, Please maintain social distancing."),
                actions: <Widget>[]));
      }
      played++;

      Firestore.instance
          .collection('users')
          .document(id)
          .collection('interactions')
          .document(device.id)
          .setData({
        "broken": distance,
        "distance": distance,
        "timestamp": Timestamp.now(),
        "location": (GeoPoint(position.latitude, position.longitude))
      }, merge: true);
    }
    for (Device d in devices) {
      if (device.id == d.id) {
        return;
      }
    }
    devices.add(device);
    Firestore.instance
        .collection("users")
        .document(id)
        .updateData({"count": FieldValue.increment(1)});
    print("Device Added");
  }

  String formatString(String raw) {
    raw = raw.replaceAll(new RegExp(r'00000000'), "");
    raw = raw.replaceAll(new RegExp(r'-'), "");
    raw = encrypter.decrypt16(raw, iv: iv);
    String str = "";
    int count = 0;
    for (int i = 0; i < raw.length; i++) {
      if (count == 2) {
        str += ":";
        count = 0;
      }
      str += raw[i];
      count++;
    }

    //print(str);
    return str;
  }

  double getDistance(int rssi, int txPower) {
    return pow(10, (txPower - rssi) / (10 * 2));
  }

  enableBLE() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    bleDetection = stream.receiveBroadcastStream().listen((event) {
      String raw = event['uuid'];
      if (raw.contains(RegExp(r'00000000-'))) {
        raw = formatString(raw);
      }
      Device d = Device(id: raw, rssi: event['rssi'], state: false);
      addDevice(d);
      if (d.rssi > limit) {
        HapticFeedback.vibrate();
        print("Vibrate");
      }
    });
  }

  disableBLE() {
    bleDetection.cancel();
    played = 0;
  }

  enableBeacon() {
    if (Platform.isAndroid) {
      String text = id;
      text = text.replaceAll(new RegExp(r':'), "");
      final encrypted = encrypter.encrypt(text, iv: iv);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      print(decrypted);
      print(encrypted.base16);
      beaconBroadcast
          .setUUID(encrypted.base16)
          .setMajorId(1)
          .setMinorId(100)
          .start();
      beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
        print(isAdvertising);
      });
    }
  }

  disableBeacon() {
    beaconBroadcast.stop();
  }
}
