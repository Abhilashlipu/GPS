import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class ignition_page extends StatefulWidget {
  const ignition_page({Key? key}) : super(key: key);

  @override
  State<ignition_page> createState() => _ignition_pageState();
}

class _ignition_pageState extends State<ignition_page> {
  int? _selection;
  final email = FirebaseAuth.instance.currentUser!.email;

  engineapi()async{

    User? user = FirebaseAuth.instance.currentUser;
        String firebaseUID = user!.uid.toString();
        //print("firebase uid =" + user!.uid);
        print("firebase uid =" + firebaseUID);
        var apiurl = Uri.parse("http://eatechgps.in/engineStatus");
        String mapdata = jsonEncode({
          'engineStatus':_selection,
          'user_name': email,
          'firebase_id': firebaseUID,
          //'mobileDeviceId': mobileDeviceId,
        });
        Map<String, String> setheaders = {
          'Content-Type': 'application/json',
          'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
        };
        http.Response response =
            await http.post(apiurl, headers: setheaders, body: mapdata);
        var data = jsonDecode(response.body);
        print("DATA: ${data}");
        print("${data["message"]}");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Iginition",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        //color: Colors.amber,
        child: SingleChildScrollView(
          child:
              //  Padding(
              //   padding: const EdgeInsets.all(14.0),
              // child:
              Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selection = 1;

                            engineapi();
                            //showBottomSheet(context);
                          });
                        },
                        child: Container(
                          height: 200,
                          width: 160,
                          decoration: BoxDecoration(
                            color:
                                _selection == 1 ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(1, 1), // Shadow position
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //   alignment: Alignment.topCenter,
                              //   width: 90,
                              //   height: 90,
                              //   child: Image.asset(
                              //       'asset/image/chanakya logo.png'),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Ignition",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "ON",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: _selection == 1
                                        ? Colors.black
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          // margin: EdgeInsets.only(left: 50.0),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selection = 0;
                            engineapi();
                            // showBottomSheet(context);
                          });
                        },
                        child: Container(
                          height: 200,
                          width: 160,
                          decoration: BoxDecoration(
                            color: _selection == 0 ? Colors.red : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: Offset(1, 1), // Shadow position
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              // Container(
                              //   alignment: Alignment.topCenter,
                              //   width: 90,
                              //   height: 90,
                              //   child: Image.asset(
                              //       'asset/image/chanakya logo.png'),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Ignition",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "OFF",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: _selection == 0
                                        ? Colors.black
                                        : Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          // margin: EdgeInsets.only(left: 50.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
