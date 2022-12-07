import 'package:eagle_eye/pages/google_map_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String name = "";
  var lat;
  var lng;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome $name"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
               'Open Google Map',
               style: TextStyle( 
                 fontSize: 24,
                 fontWeight: FontWeight.bold
               ),
              ),
              Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
          child: Column(
            children: [
                   TextField(
                        //controller: latitudeCon,
                    keyboardType: TextInputType.number,
                    onChanged: (Text) {
                      lat = double.parse(Text);
                    },
                    decoration: InputDecoration(hintText: 'Enter latitude'),
                     ),
                   TextField(
                      //controller: latitudeCon,
                    keyboardType: TextInputType.number,
                    onChanged: (Text) {
                      lng = double.parse(Text);
                    },
                    decoration: InputDecoration(hintText: 'Enter longitude'),
                     )
                  ],
                 ),
               )
             ],
            )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed:() =>Navigator.push(
              context,
               MaterialPageRoute(
                 builder:(context)=>GoogleMapPage(
                    //lat: lat,
                    //lng: lng,
                 ) ,
                 ) ,
            ),
            tooltip: 'Google Map',
            child: Icon(Icons.add_location_outlined),),
          );
  }
}