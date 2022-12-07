import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;

class LocationApi{

 latlngapi() async {
    var apiurl = Uri.parse("http://eatechgps.in/get_user_gps_location");
    String mapdata = jsonEncode({'imei': '535837189702664'});
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

    double lat = double.parse(data["gps_data"]["latitude"]);
    double lng = double.parse(data["gps_data"]["longitude"]);
    double speed = double.parse(data["gps_data"]["speed"]);

    // Speed = speed;
    // _markers.add(
    //   Marker(
    //       markerId: MarkerId('id-1'),
    //       position: LatLng(lat, lng),
    //       icon: mapMarker),
    // );
    // mapController
    //     .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 18));
    // points.add(LatLng(lat, lng));
    // print(points);
    // print(points.length);
    // _polyline.add(Polyline(
    //   polylineId: PolylineId(_lastMapPosition.toString()),
    //   visible: true,
    //   width: 3,
    //   //points is List<LatLng>
    //   points: points,
    //   color: Colors.blue,
    // ));
  }



  //  try {
  //     final Url = Uri.parse('http://api.ipinfy.org');
  //     final response = await http.get(Url);
  //     return response.statusCode == 200 ? response.body : null;
  //   } catch (e) {
  //     return null;
  // }
}