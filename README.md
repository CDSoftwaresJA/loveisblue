 # Love is Blue(LIB) - Flutter Hackathon 2020

 [![INSERT YOUR GRAPHIC HERE](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/Copy%20of%20Love%20is%20Blue.gif?alt=media&token=ee456ff0-1f34-45dc-8051-1b5e55d8c58c)](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/Copy%20of%20Love%20is%20Blue.gif?alt=media&token=ee456ff0-1f34-45dc-8051-1b5e55d8c58c)

| Community | Messages | Profile |Alert | Profile Detailed | Community-Members | Map-View  |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| ![community](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-161906.png?alt=media&token=ca8b339a-2116-4002-9d2b-df54730c0d83) | ![messages](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-161954.png?alt=media&token=1c6ede66-944e-49c8-8fee-2fc506f60021) | ![profile screen](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162146.png?alt=media&token=d055c09e-bfe7-4c05-a8e5-8c6e0dcc78e4) | ![alert-screen](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162256.png?alt=media&token=15e58fcc-18e3-45a4-b7a4-e984174f9529) | ![details screen](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162318.png?alt=media&token=3c485c62-a2f8-44dc-aa2f-8fc2e4db171f) | ![members](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162223.png?alt=media&token=9608adf5-6f18-45e9-bd9e-862481573f50) | ![map](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162407.png?alt=media&token=6768c144-9156-4746-83c2-65272ec54f91) |

 
## Table of Contents 
- [Introduction](#introduction)
- [Setup](#setup)
- [Features](#features)
- [Links](#links)
- [Team](#team)
- [FAQ](#faq)
- [License](#license)


---
### Introduction

We are living in a world where our “new normal” has shifted from being carefree and unaware of others around us to being acutely aware of our surroundings to ensure health, safety and well-being for our fellow man. From these emerging routines and norms, we have developed a social distancing network called Love is Blue.

---
### Setup


> run the following commands

```shell
$ git clone https://github.com/CDSoftwaresJA/loveisblue.git
$ flutter clean
$ flutter pub get
$ flutter run
```
- Add your Google Play Services JSON
- Add your Google Maps API key

---

## Features
 [![INSERT YOUR GRAPHIC HERE](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/Love%20is%20Blue%20(2).png?alt=media&token=e03b2d40-3fb4-4e1b-ae46-e11f4cb3d2e0)](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/Love%20is%20Blue%20(2).png?alt=media&token=e03b2d40-3fb4-4e1b-ae46-e11f4cb3d2e0)

- AmorBlue uses custom Java Platform code to detect devices nearby and calculates the distance based off the Received Signal Strength Indicator(RSSI)  and the Transmission Power (TX Power).

- AmorBlue uses Firestore for the back-end , future plan is to use a local database for the recording of values

- If the distance is less than 2 meters AmorBlue will notifiy you using a FlutterTTS package for Text to Speech and a Dialog Box as well as record the exact time , how close they were to you and if they have AmorBlue installed their profile information

- AmorBlue allows you to send preset messages to anyone who has AmorBlue installed , these messages can be images , audio , text and links

- AmorBlue then checks if the Unqiue ID (UUID) belongs to a device with AmorBlue installed. , if it does then AmorBlue will send your preset message to the other device.

- Each Device that has AmorBlue turned on displays a unique ID that is based off the bluetooth mac address of the device which is obtained using flutter_bluetooth_serial,padded by 8 zeros and encrypted using Salsa20 encryption which is done with the encrypt plugin, This ID is broadcasted using the beacon_broadcast plugin

## Links 
- Please click this link [here](https://www.youtube.com/watch?v=fu85XpZWydI&feature=youtu.be) to watch the pitch.
- Please click this link [here](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/loveisblue.apk?alt=media&token=571413fa-a568-4c63-a065-49a1f5071105) to download.
- Please click this link [here](https://www.youtube.com/watch?v=Duegs2A3pzM) to watch the social distance report demo.
- Please click this link [here](https://www.youtube.com/watch?v=yLqMJTuOzss&feature=youtu.be) to watch the social distance notifications demo.


---
## Core Functions and Snippets

```dart
// Dart function to calculate the distance based off the txPower and RSSI
double getDistance(int rssi, int txPower) {
    return pow(10, (txPower - rssi) / (10 * 2));
}

```
```java
// Java platform code that powers Love is Blue
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import java.util.HashMap;
import io.flutter.plugin.common.EventChannel;

public  class BleHandler implements EventChannel.StreamHandler {

    private BluetoothAdapter mBluetoothAdapter= BluetoothAdapter.getDefaultAdapter();;
    private EventChannel.EventSink eventSink;

    @Override
    public void onListen(Object o, final EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
        mBluetoothAdapter.startLeScan(mLeScanCallback);
    }

    @Override
    public void onCancel(Object o) {
        eventSink.endOfStream();
        mBluetoothAdapter.stopLeScan(mLeScanCallback
        );
    }

    private BluetoothAdapter.LeScanCallback mLeScanCallback = new
            BluetoothAdapter.LeScanCallback() {
                @Override
                public void onLeScan(final BluetoothDevice device, final int rssi,
                                     final byte[] scanRecord) {
                            String uuid = IntToHex2(scanRecord[6] & 0xff) + IntToHex2(scanRecord[7] & 0xff) + IntToHex2(scanRecord[8] & 0xff) + IntToHex2(scanRecord[9] & 0xff)
                                    + "-" + IntToHex2(scanRecord[10] & 0xff) + IntToHex2(scanRecord[11] & 0xff)
                                    + "-" + IntToHex2(scanRecord[12] & 0xff) + IntToHex2(scanRecord[13] & 0xff)
                                    + "-" + IntToHex2(scanRecord[14] & 0xff) + IntToHex2(scanRecord[15] & 0xff)
                                    + "-" + IntToHex2(scanRecord[16] & 0xff) + IntToHex2(scanRecord[17] & 0xff)
                                    + IntToHex2(scanRecord[18] & 0xff) + IntToHex2(scanRecord[19] & 0xff)
                                    + IntToHex2(scanRecord[20] & 0xff) + IntToHex2(scanRecord[21] & 0xff);
                            HashMap<String,Object> HashMap=new HashMap<String,Object>();
                            HashMap.put("uuid",uuid);
                            HashMap.put("rssi",rssi);
                            eventSink.success(HashMap);
                }
            };

    public String IntToHex2(int i) {
        char hex_2[] = {Character.forDigit((i >> 4) & 0x0f, 16), Character.forDigit(i & 0x0f, 16)};
        String hex_2_str = new String(hex_2);
        return hex_2_str.toUpperCase();
    }


}

```
---


## Team


| **Carl Duncan** | **Juliet Duncan** |
| :---: |:---:|
|[![Carl Duncan](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/me.jpg?alt=media&token=ff71f7a7-99ae-4f2d-91ab-2d9479342a0c)](https://play.google.com/store/apps/developer?id=Carl+Duncan)    | [![Juliet Duncan](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/mom.jpg?alt=media&token=769086b2-9e13-4727-b714-a31e994ea048)](https://www.etsy.com/shop/JCEpiphany?ref=simple-shop-header-name&listing_id=749988199) | | <a href="http://github.com/fvcproductions" target="_blank">`github.com/fvcproductions`</a> | <a href="http://github.com/fvcproductions" target="_blank">`github.com/fvcproductions`</a> | <a 
| Software Developer | Business Lead |
---

## FAQ
- **How accurate is the distance?**
    - The distance is a close approximation. The accuracy can be increased by configuring the sensitivity

- **What are the different applications of LIB?**
  - 1. Personal Use – track your daily social distancing progress.
    2. Family Use – Monitor social distancing within customized family and friends communities. Allow members to send preset alerts in various forms; audio, texts or links. 
    3. Business Use – Create a community for staffing. Allows managers to send preset messages in various forms; audio, texts or links to help maintain social distancing
    4. Business Manager tool – conveniently monitor social distancing in the workplace. Track offenders and allow for adjustments to workflows and positions to improve distance guidelines.

- **Can LIB work on any smart phone?**
    - Love is Blue works on most smart phone devices. To check compatibility use :
    https://play.google.com/store/apps/details?id=com.myan.michaelyanyoga.bluetoothchecker


- **Does LIB have to be installed on both phones to work**
    - For LIB social distance detecting, it only has to be installed on one phone; However for the bluetooth messaging to work, LIB  needs to be installed on both devices.

- **Can LIB work in the background?** 
    - LIB works in the background.
    
---

## Support
[![INSERT YOUR GRAPHIC HERE](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/mockup.png?alt=media&token=7bf6d9ff-f55a-4ac0-8b4f-1af4ea4cc8af)](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/mockup.png?alt=media&token=7bf6d9ff-f55a-4ac0-8b4f-1af4ea4cc8af)
Reach out to me at one of the following places!

- Email at cdsoftwaresja@gmail.com
- Twitter at <a href="https://twitter.com/carlthenerd">`@carlthenerd`</a>

---

## Donations
 [![INSERT YOUR GRAPHIC HERE](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/carlduncan)
 


---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**

