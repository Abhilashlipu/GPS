// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geocoder/geocoder.dart';
// const kGoogleApiKey = "AIzaSyDrVyLu7te4Da8KLr9dOKV99Z1THSz_2jg";


// class  GoogleMapPage2 extends StatefulWidget {
//   const GoogleMapPage2({ Key? key }) : super(key: key);

//   @override
//   _GoogleMapPage2State createState() => _GoogleMapPage2State();
// }

// class _GoogleMapPage2State extends State<GoogleMapPage2> {
//    var start = 10;
//   //double lat;
//   // double lng;
//   Timer? timer;
//    static const LatLng _center = const LatLng(20.325365, 85.813346);
//   Set<Marker> _markers = {};
//   final Set<Polyline> _polyline = {};
//   late BitmapDescriptor mapMarker;
//   late GoogleMapController mapController;
//   List<LatLng> points = <LatLng>[];
//   LatLng _lastMapPosition = _center;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setCustomMarker();
//   }
//   void setCustomMarker() async {
//     mapMarker = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/images/gps_icon.png');
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _markers.add(
//         Marker(markerId: MarkerId('id-1'), position: _center, icon: mapMarker),
//       );
//       mapController = controller;
//     });
//     points.add(_center);
//     //startTimer();
//   }

//   void startTimer() {
//     const onsec = Duration(seconds: 1);
//     Timer _timer = Timer.periodic(onsec, (timer) {
//       if (start == 0) {
//         print('$start');

//         setState(() {
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

//   Future latlngapi() async {
//     var apiurl = Uri.parse("http://eatechgps.in/get_user_gps_location");
//     String mapdata = jsonEncode({'imei': '535837189702664'});
//     Map<String, String> setheaders = {
//       'Content-Type': 'application/json',
//       'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
//     };
//     http.Response response =
//         await http.post(apiurl, headers: setheaders, body: mapdata);
//     var data = jsonDecode(response.body);
//     print("DATA: ${data}");
//     print("${data["message"]}");
//     print("${data["gps_data"]["latitude"]}");
//     double lat = double.parse(data["gps_data"]["latitude"]);
//     double lng = double.parse(data["gps_data"]["longitude"]);
//     _markers.add(
//       Marker(
//           markerId: MarkerId('id-1'),
//           position: LatLng(lat, lng),
//           icon: mapMarker),
//     );
//     mapController
//         .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18));
//     points.add(LatLng(lat, lng));
//     print(points);
//     print(points.length);
//     _polyline.add(Polyline(
//       polylineId: PolylineId(_lastMapPosition.toString()),
//       visible: true,
//       width: 3,
//       //points is List<LatLng>
//       points: points,
//       color: Colors.blue,
//     ));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//          alignment: Alignment.center,
//         child: ElevatedButton(
//           onPressed: () async {
//             // show input autocomplete with selected mode
//             // then get the Prediction selected
//             Prediction p = await PlacesAutocomplete.show(
//                 context: context, apiKey: kGoogleApiKey);
//             displayPrediction(p);
//           },
//           child: Text('Find address'),

//         )
//       ),
      
//     );
//   }
//   Future<Null> displayPrediction(Prediction p) async {
//     if (p != null) {
//       PlacesDetailsResponse detail =
//       await _places.getDetailsByPlaceId(p.placeId);

//       var placeId = p.placeId;
//       double lat = detail.result.geometry.location.lat;
//       double lng = detail.result.geometry.location.lng;

//       var address = await Geocoder.local.findAddressesFromQuery(p.description);

//       print(lat);
//       print(lng);
//     }
//   }

// }