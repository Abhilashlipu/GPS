import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trips extends StatefulWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  // static const LatLng _center = const LatLng(20.325365, 85.813346);
  // Set<Marker> _markers = {};
  // final Set<Polyline> _polyline = {};
  // late BitmapDescriptor mapMarker;
  // late GoogleMapController mapController;
  // List<LatLng> points = <LatLng>[];
  // LatLng _lastMapPosition = _center;

  List<LatLng> Trip1 = [LatLng(20.325561,85.813300),LatLng(20.325762,85.812354),LatLng(20.326918,85.812584),LatLng(20.327135,85.811194),
  LatLng(20.328108,85.811381)]; 

  String date = "";
  DateTime selectedDate = DateTime.now();
  bool choicedate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setCustomMarker();
  }

  // void setCustomMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), 'assets/images/gps_icon1.jpeg');
  // }

  // void _onMapCreated(GoogleMapController controller) {
  //   setState(() {
  //     _markers.add(
  //       Marker(markerId: MarkerId('id-1'), position: _center, icon: mapMarker),
  //     );
  //     mapController = controller;
  //   });
  //   points.add(_center);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trips",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              choicedate
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                        onPrimary: Colors.white,
                        shadowColor: Colors.blueAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(350, 60), //////// HERE
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        style: TextStyle(
                          fontSize: 25.0,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                        onPrimary: Colors.white,
                        shadowColor: Colors.blueAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(350, 60), //////// HERE
                      ),
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(
                        "Select  Date",
                        style: TextStyle(
                          fontSize: 25.0,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
              // Text(
              //     "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")

              SizedBox(
                height: 20,
              ),

              // Container(
              //   height: 390,
              //   // width: 800,

              //   child: GoogleMap(
              //     onMapCreated: _onMapCreated,
              //     mapType: MapType.normal,
              //     polylines: _polyline,
              //     markers: _markers,
              //     initialCameraPosition: CameraPosition(
              //       target: _center,
              //       zoom: 18,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 15),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        choicedate = true;
        print("$selectedDate");
      });
  }
}
