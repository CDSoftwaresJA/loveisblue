import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loveisblue/providers/seekchange.dart';
import 'package:loveisblue/widgets/tilenormal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeekBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildSeekBar(context);
  }

  buildSeekBar(BuildContext context) {
    SeekChange seekBarProvider = Provider.of<SeekChange>(context, listen: true);
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, string) {
              if (string.hasData) {
                int limit = string.data.getInt("limit");
                if (limit == null) {
                  string.data.setInt("limit", -50);
                  limit = -50;
                  
                }
                double format= (limit*-0.1);
                return ListTile(
                  leading: Icon(Icons.bluetooth),
                  title: Text(
                    "Sensitivity",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Hexcolor("#00FFFF"),
                      inactiveTrackColor: CupertinoColors.systemGrey,
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 2.0,
                      thumbColor: CupertinoColors.white,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 7.0),
                      overlayColor: Colors.red.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                    ),
                    child: Column(
                      children: [
                        Slider(
                          max: 100,
                          value: seekBarProvider.sensitivity.toDouble(),
                          onChanged: (value) {
                            seekBarProvider.setValue(value);
                            double negative =value*-0.1;
                             string.data.setInt("limit",negative.toInt() );
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
