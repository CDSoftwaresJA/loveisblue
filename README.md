 # Love is Blue - Flutter Hackathon 2020

 [![INSERT YOUR GRAPHIC HERE](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/title.gif?alt=media&token=bb652fef-a3ed-437d-8ea9-5b8d55e3a8e9)]()

| Community | Messages | Profile |Alert | Profile Detailed | Community-Members | Map-View  |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| ![community](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-161906.png?alt=media&token=ca8b339a-2116-4002-9d2b-df54730c0d83) | ![messages](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-161954.png?alt=media&token=1c6ede66-944e-49c8-8fee-2fc506f60021) | ![profile screen](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162146.png?alt=media&token=d055c09e-bfe7-4c05-a8e5-8c6e0dcc78e4) | ![alert-screen](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162256.png?alt=media&token=15e58fcc-18e3-45a4-b7a4-e984174f9529) | ![details screen](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162318.png?alt=media&token=3c485c62-a2f8-44dc-aa2f-8fc2e4db171f) | ![members](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162223.png?alt=media&token=9608adf5-6f18-45e9-bd9e-862481573f50) | ![map](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/device-2020-06-27-162407.png?alt=media&token=6768c144-9156-4746-83c2-65272ec54f91) |

 
## Table of Contents 
- [Introduction](#introduction)
- [Setup](#setup)
- [Features](#features)
- [Usage](#Usage)
- [Team](#team)
- [FAQ](#faq)
- [License](#license)


---
### Introduction
Recyclopedia is a vintage inspired digital platform that aims to save the planet from the pollution which is the major threat to the functioning of earth. Through this platform, **we are creating an energetic community that aims to combat the world from pollution**. The key features of our platform are,

1) The platform allows its users to engage in events related to preventing pollution in the world. Events like beach clean up, community gathering, and workshops are notified under the events section.
2) The users are allowed to donate to our body, to help us host events.
3) A gamification system is incorporated n the system to encourage the participation of the user in our platform. The users will get a tokens of appreciation related to their hierarchy in the levels of contribution.
---
### Setup


> run the following commands

```shell
$ git clone https://github.com/CDSoftwaresJA/loveisblue.git
$ flutter clean
$ flutter pub get
```
- Add your Google Play Services JSON
- Add your Google Maps API key

---

## Features
 [![INSERT YOUR GRAPHIC HERE](https://firebasestorage.googleapis.com/v0/b/amorblue-9d28f.appspot.com/o/title.gif?alt=media&token=bb652fef-a3ed-437d-8ea9-5b8d55e3a8e9)]()

- AmorBlue uses custom Java Platform code to detect devices nearby and calculates the distance based off the Received Signal Strength Indicator(RSSI)  and the Transmission Power (TX Power).

- AmorBlue uses Firestore for the back-end , future plan is to use a local database for the recording of values

- If the distance is less than 2 meters AmorBlue will notifiy you using a FlutterTTS package for Text to Speech and a Dialog Box as well as record the exact time , how close they were to you and if they have AmorBlue installed their profile information

- AmorBlue allows you to send preset messages to anyone who has AmorBlue installed , these messages can be images , audio , text and links

- AmorBlue then checks if the Unqiue ID (UUID) belongs to a device with AmorBlue installed. , if it does then AmorBlue will send your preset message to the other device.

- Each Device that has AmorBlue turned on displays a unique ID that is based off the bluetooth mac address of the device which is obtained using flutter_bluetooth_serial,padded by 8 zeros and encrypted using Salsa20 encryption which is done with the encrypt plugin, This ID is broadcasted using the beacon_broadcast plugin

## Usage 
- Please click here

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
|[![Carl Duncan](https://avatars1.githubusercontent.com/u/4284691?v=3&s=200)](http://fvcproductions.com)    | [![Juliet Duncan](https://avatars1.githubusercontent.com/u/4284691?v=3&s=200)](http://fvcproductions.com) | | <a href="http://github.com/fvcproductions" target="_blank">`github.com/fvcproductions`</a> | <a href="http://github.com/fvcproductions" target="_blank">`github.com/fvcproductions`</a> | <a 
| Software Developer | [PLEASE FILL] |
---

## FAQ

- **How do I do *specifically* so and so?**
    - No problem! Just do this.

---

## Support

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

