// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:kdgaugeview/kdgaugeview.dart';
// import 'package:http/http.dart' as http;

// class SpeedPage extends StatefulWidget {
//   const SpeedPage({Key? key}) : super(key: key);

//   @override
//   _SpeedPageState createState() => _SpeedPageState();
// }

// class _SpeedPageState extends State<SpeedPage> {
//   double Speed = 0;
//   var start = 10;
//   Timer? timer;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     startTimer();
//   }

//  void startTimer() {
//     const onsec = Duration(seconds: 1);
//     Timer _timer = Timer.periodic(onsec, (timer) {
//       if (start == 0) {
//         print('$start');

//         setState(()  {
        
//           latlngapi();
//           start = 10;
//         });
//       } else {
//         setState(() {
//           print('$start');
//           start--;
//         });
//       }
//     });
//   }

//   latlngapi() async {
//     var apiurl = Uri.parse("http://eatechgps.in/get_user_gps_location");
//     String mapdata = jsonEncode({'imei': '535837189702664'});
//     Map<String, String> setheaders = {
//       'Content-Type': 'application/json',
//       'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
//     };
//     http.Response response =
//         await http.post(apiurl, headers: setheaders, body: mapdata);
//     var data = jsonDecode(response.body);

//     double speed = double.parse(data["gps_data"]["speed"]);
   
//     Speed = speed;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Speed',
//           style: TextStyle(fontSize: 25),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           height: 400,
//           width: 400,
//           padding: EdgeInsets.all(20),
//           child: KdGaugeView(
//             minSpeed: 0.0,
//             maxSpeed: 120.0,
//             speed: 100,
//             speedTextStyle: TextStyle(
//                 color: Colors.blue[900],
//                 fontSize: 65,
//                 fontWeight: FontWeight.bold),
//             animate: true,
//             duration: Duration(seconds: 2),
//             subDivisionCircleColors: Colors.red,
//             divisionCircleColors: Colors.amber,
//             unitOfMeasurementTextStyle: TextStyle(
//                 color: Colors.redAccent,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold),
//             minMaxTextStyle: TextStyle(
//                 color: Colors.red, fontSize: 25, fontWeight: FontWeight.bold),
//             gaugeWidth: 16,
//             alertColorArray: [Colors.green, Colors.yellow, Colors.red],
//             alertSpeedArray: [0, 40, 80],
//           ),
//         ),
//       ),
//     );
//   }
// }
