import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';

import '../main.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  bool speedswitch = false;
  bool battery = false;
  double limit = 1;
  final switchbattery = GetStorage();
  final switchspeed = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (switchbattery.read('battery') != null) {
      setState(() {
        battery = switchbattery.read('battery');
      });
    }

    if (switchspeed.read('speedswitch') != null) {
      setState(() {
        speedswitch = switchspeed.read('speedswitch');
      });
    }
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, StateSetter myState) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Set your speed limit',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // SliderTheme(
                  //   data: SliderThemeData(
                  //     thumbColor: Colors.green,
                  //     overlayColor: Colors.green.shade200,
                  //     valueIndicatorColor: Colors.green,

                  //     /// track color
                  //     activeTrackColor: Colors.green.shade200,
                  //     inactiveTrackColor: Colors.black12,

                  //     /// ticks in between
                  //     activeTickMarkColor: Colors.transparent,
                  //     inactiveTickMarkColor: Colors.transparent,
                  //   ),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       // Slider(
                  //       //   value: value,
                  //       //   min: 0,
                  //       //   max: 100,
                  //       //   divisions: 10,
                  //       //   label: value.round().toString(),
                  //       //   onChanged: (value) => setState(() => this.value = value),
                  //       // ),
                  //       const SizedBox(height: 100),
                  StatefulBuilder(builder: (context, State) {
                    return Slider(
                        value: limit,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.red,
                        inactiveColor: Colors.red.shade100,
                        label: limit.round().toString(),
                        onChanged: (value) {
                          limit = value;
                          State(() {});

                          setState(() {
                            //print("Limit is $limit"+"km/hr");
                          });
                        });
                  }),
                  // ],
                  // ),
                  //),
                  ElevatedButton(
                      onPressed: () {
                        print("Limit is $limit" + "km/hr");
                        Navigator.pop(context);
                      },
                      child: Text('SET'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        title: Text("Alert", style: TextStyle(fontSize: 25)),
      ),
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/app_bg3.jpg"),
                  fit: BoxFit.cover)),
          //margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.black54,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: buildHeader(
                    text: '  Speed Limit Alert',
                    child: buildSwitch(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Colors.black54,
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: buildHeader(
                    text: '  Low Battery Alert',
                    child: batterySwitch(),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildHeader({
    required Widget child,
    required String text,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(width: 90),
          child,
        ],
      );

  Widget buildSwitch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
            // thumbColor: MaterialStateProperty.all(Colors.red),
            // trackColor: MaterialStateProperty.all(Colors.orange),

            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.blue.withOpacity(0.4),
            // inactiveThumbColor: Colors.orange,
            inactiveTrackColor: Colors.white38,
            splashRadius: 50,
            value: speedswitch,
            onChanged: (value) {
              setState(() {
                this.speedswitch = value;
                if (value == true) {
                  showBottomSheet(context);
                }
                switchspeed.write('speedswitch', speedswitch);
              });
            }

            //=> setState(() => this.value = value),
            ),
      );

  Widget batterySwitch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
            // thumbColor: MaterialStateProperty.all(Colors.red),
            // trackColor: MaterialStateProperty.all(Colors.orange),

            activeColor: Colors.blueAccent,
            activeTrackColor: Colors.blue.withOpacity(0.4),
            // inactiveThumbColor: Colors.orange,
            inactiveTrackColor: Colors.white38,
            splashRadius: 50,
            value: battery,
            onChanged: (value) {
              setState(() {
                this.battery = value;
                switchbattery.write('battery', battery);
                if (battery == true) {
                  // Workmanager().registerPeriodicTask(
                  //   "1",
                  //   simplePeriodicTask,
                  //   frequency: Duration(minutes: 15),
                  // );
                } else {}
              });
            }

            //=> setState(() => this.value = value),
            ),
      );
}
