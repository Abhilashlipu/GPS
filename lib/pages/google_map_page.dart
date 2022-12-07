import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:eagle_eye/API/getusergps_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapPage extends StatefulWidget {
  //const GoogleMapPage({Key? key}) : super(key: key);
  //double lat;
  //double lng;
  GoogleMapPage(/*{required this.lat, required this.lng}*/);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState(/*lat, lng*/);
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  var start = 30;
  int Speed = 0;
  double lat1 = 20.325365;
  double lng1 = 85.813346;

  // double lng;
  Timer? timer;
  // late GetUserGpsModel _gpsuser;

  // _GoogleMapPageState(this.lat, this.lng);
  static const LatLng _center = const LatLng(20.325365, 85.813346);
  Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  late BitmapDescriptor mapMarker;
  late GoogleMapController mapController;
  List<LatLng> points = <LatLng>[];
  LatLng _lastMapPosition = _center;
  //String firebaseUID = 'Unknown';

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMarker();
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/gps_icon1.jpeg');
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      // latlngapi();

      latlngapi1();

      startTimer();

      // _markers.add(
      //   Marker(markerId: MarkerId('id-1'), position: _center, icon: mapMarker),
      // );
      mapController = controller;
    });
    points.add(_center);
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        print('$start');

        setState(() {
          // final GetUserGpsModel gpsuser = await latlngapi();
          // _gpsuser = gpsuser;
          // print("${_gpsuser.gpsData.speed}");
          // print("${_gpsuser.gpsData.latitude}");
          latlngapi();
          start = 30;
        });
      } else {
        setState(() {
          print('$start');
          start--;
        });
      }
    });
  }

  // Future<GetUserGpsModel>
  latlngapi() async {
    User? user = FirebaseAuth.instance.currentUser;
    String firebaseUID = user!.uid.toString();
    var apiurl = Uri.parse("http://eatechgps.in/get_user_gps_location");
    String mapdata = jsonEncode({'imei': firebaseUID});
    Map<String, String> setheaders = {
      'Content-Type': 'application/json',
      'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
    };
    http.Response response =
        await http.post(apiurl, headers: setheaders, body: mapdata);
    var data = jsonDecode(response.body);
    // return getUserGpsModelFromJson(data);

    print("DATA: ${data}");
    print("${data["message"]}");
    print("${data["gps_data"]["latitude"]}");
    String latitude = (data["gps_data"]["latitude"]).toString();
    String longitude = (data["gps_data"]["longitude"]).toString();

    // var lat11 = latitude.substring(0, 9);
    // var lat22 = latitude.substring(2, 2);

    // double? lat1 = double.tryParse('${lat11}');
    // double? lat2 = double.tryParse('${lat22}');

    double lat11 = double.parse('${latitude.substring(0, 2)}');
    print("lat1: ${lat11}");
    print("latitude: ${latitude}");
    double lat22 = double.parse('${latitude.substring(2, 9)}');

    print("lat2: ${lat22}");

    double lat = (lat11 + (lat22 / 60.0));

    //  var lng11 = longitude.substring(0, 9);
    // var lng22 = longitude.substring(3, 2);

    // double? lng1 = double.tryParse('${lat11}');
    // double? lng2 = double.tryParse('${lat22}');

    double lng11 = double.parse('${longitude.substring(0, 3)}');
    double lng22 = double.parse('${longitude.substring(3, 9)}');

    double lng = lng11 + (lng22 / 60.0);

    // double lat = 22.565743;
    // double lng = 88.353013;

    // double lat = double.parse(data["gps_data"]["latitude"]);
    // double lng = double.parse(data["gps_data"]["longitude"]);

    double lat2 = lat;
    double lng2 = lng;

    double distance = calculateDistance(lat1, lng1, lat2, lng2);

    double s = distance / 0.0083333333333;

    int speed = s.round();

    lat1 = lat2;
    lng1 = lng2;

    // double speed = double.parse(data["gps_data"]["speed"]);

    Speed = speed;
    _markers.add(
      Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(lat, lng),
          icon: mapMarker),
    );
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18));
    points.add(LatLng(lat, lng));
    print(points);
    print(points.length);
    // _polyline.add(Polyline(
    //   polylineId: PolylineId(_lastMapPosition.toString()),
    //   visible: true,
    //   width: 3,
    //   //points is List<LatLng>
    //   points: points,
    //   color: Colors.blue,
    // ));
  }

  latlngapi1() async {
    User? user = FirebaseAuth.instance.currentUser;
    String firebaseUID = user!.uid.toString();
    var apiurl = Uri.parse("http://eatechgps.in/get_user_gps_location");
    String mapdata = jsonEncode({'imei': firebaseUID});
    Map<String, String> setheaders = {
      'Content-Type': 'application/json',
      'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
    };
    http.Response response =
        await http.post(apiurl, headers: setheaders, body: mapdata);
    var data = jsonDecode(response.body);
    // return getUserGpsModelFromJson(data);

    print("DATA: ${data}");
    print("${data["message"]}");
    print("${data["gps_data"]["latitude"]}");
    String latitude = (data["gps_data"]["latitude"]).toString();
    String longitude = (data["gps_data"]["longitude"]).toString();

    // var lat11 = latitude.substring(0, 9);
    // var lat22 = latitude.substring(2, 2);

    // double? lat1 = double.tryParse('${lat11}');
    // double? lat2 = double.tryParse('${lat22}');

    double lat11 = double.parse('${latitude.substring(0, 2)}');
    print("lat1: ${lat11}");
    print("latitude: ${latitude}");
    double lat22 = double.parse('${latitude.substring(2, 9)}');

    print("lat2: ${lat22}");

    double lat = (lat11 + (lat22 / 60.0));
    double Lat1 = lat;

    lat1 = Lat1;

    //  var lng11 = longitude.substring(0, 9);
    // var lng22 = longitude.substring(3, 2);

    // double? lng1 = double.tryParse('${lat11}');
    // double? lng2 = double.tryParse('${lat22}');

    double lng11 = double.parse('${longitude.substring(0, 3)}');
    double lng22 = double.parse('${longitude.substring(3, 9)}');

    double lng = lng11 + (lng22 / 60.0);
    double Lng1 = lng;

    lng1 = Lng1;

    // double lat = 22.565743;
    // double lng = 88.353013;

    // double lat = double.parse(data["gps_data"]["latitude"]);
    // double lng = double.parse(data["gps_data"]["longitude"]);

    //double speed = double.parse(data["gps_data"]["speed"]);

    // Speed = speed;
    _markers.add(
      Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(lat, lng),
          icon: mapMarker),
    );
    mapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18));
    points.add(LatLng(lat, lng));
    print(points);
    print(points.length);
    // _polyline.add(Polyline(
    //   polylineId: PolylineId(_lastMapPosition.toString()),
    //   visible: true,
    //   width: 3,
    //   //points is List<LatLng>
    //   points: points,
    //   color: Colors.blue,
    // ));
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' EA Tech Gps',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 590,
                // width: 800,
        
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  polylines: _polyline,
                  markers: _markers,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 18,
                  ),
                ),
              ),
              // Container(
              //   child: Text('Speed  '),
              //   color: Colors.white,
              //   alignment: Alignment.center,
              //   //width: 150,
              //   height: 50,
              // )
              Container(
                width: 500,
                height: 50,
                color: Colors.blue,
                margin: EdgeInsets.all(3),
                child: Card(
                  color: Colors.blue,
                  margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "             SPEED:    $Speed   " + " Km/hr",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      // Text(
                      //   '    $email',
                      //   style: TextStyle(
                      //     fontSize: 14.0,
                      //     color: Colors.white,
                      //    ),
                      //  ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
