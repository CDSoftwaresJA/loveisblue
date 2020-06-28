import 'package:loveisblue/navigator.dart';
import 'package:loveisblue/pages/splash.dart';
import 'package:loveisblue/providers/seekchange.dart';
import 'package:loveisblue/utils/btcontrol.dart';
import 'package:loveisblue/widgets/seekbar.dart';
import 'package:loveisblue/widgets/tilenormal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loveisblue/pages/map.dart';

import 'package:loveisblue/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

enum TtsState { playing, stopped }

class _SettingsState extends State<Settings> {
  static Themes themes = Themes();
  BTControl btControl = BTControl();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          middle: Text("Settings"),
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                )
              ]),
            ),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              TileNormal(
                icon: Icons.bluetooth,
                title: "Enable BLE Detection",
                subtitle:
                    "Enables BLE and allows scanning for other users/beacons",
                onPressed: () async {
                  btControl.enableBLE();
                },
              ),
              TileNormal(
                icon: Icons.bluetooth,
                title: "Disable BLE Detection",
                subtitle: "Disables BLE",
                onPressed: () {
                  btControl.disableBLE();
                },
              ),
              TileNormal(
                icon: Icons.bluetooth_searching,
                title: "Enable BLE Broadcasing",
                subtitle:
                    "Enables BLE broadcasting to allow other loveisblue users to send messages to you",
                onPressed: () {
                  btControl.enableBeacon();
                },
              ),
              TileNormal(
                icon: Icons.bluetooth_searching,
                title: "Disable BLE Broadcasting",
                subtitle: "Disables BLE broadcasting",
                onPressed: () {
                  btControl.disableBeacon();
                },
              ),
              SeekBar(),
              TileNormal(
                icon: Icons.time_to_leave,
                title: "Sign out",
                subtitle: "Time to go!",
                onPressed: () {
                  Navigator.push(
                    Nav.context,
                    CupertinoPageRoute(builder: (context) => Splash()),
                  );
                },
              ),
              FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, string) {
                  if (string.hasData) {
                    SeekChange seekBarProvider =
                        Provider.of<SeekChange>(context, listen: true);
                    int limit = string.data.getInt("limit");
                    if (limit == null) {
                      string.data.setInt("limit", -50);
                      BTControl.limit = -50;
                      limit = -50;
                    }

                    BTControl.limit = limit * 10;
                    print(BTControl.limit);
                    return Text(
                      'Current Sensitivity Configuration: ${seekBarProvider.sensitivity}',
                      style: TextStyle(fontSize: 10),
                    );
                  }
                  return Container();
                },
              ),
            ])),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            ])),
          ],
        ));
  }
}
