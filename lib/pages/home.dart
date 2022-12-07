import 'package:eagle_eye/constant.dart';
import 'package:eagle_eye/notification.dart';
import 'package:eagle_eye/pages/change_password.dart';
import 'package:eagle_eye/pages/google_map_page.dart';
import 'package:eagle_eye/pages/ignition_page.dart';
import 'package:eagle_eye/pages/second_page.dart';
import 'package:eagle_eye/pages/speed_page.dart';
import 'package:eagle_eye/pages/trip_page.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ElevatedButton(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GoogleMapPage(/*lat: 20.325424, lng: 85.813545*/)));
              },
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/arrow_image_gps.png',
                    height: 30.0,
                    width: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: new Text(
                      "Tracker  ",
                      style: TextStyle(
                        fontSize: 25.0,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SpeedPage()));
              },
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/speed_img.jpg',
                    height: 50.0,
                    width: 50.0,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: new Text(
                      "Speed  ",
                      style: TextStyle(
                        fontSize: 25.0,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(constant.msg),
            ElevatedButton(
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
                NotificationService()
                    .showNotification(1, "Alert", "Battery Low", 5);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SpeedPage()));
              },
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/notification.png',
                    height: 50.0,
                    width: 50.0,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: new Text(
                      "Notification  ",
                      style: TextStyle(
                        fontSize: 25.0,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Trips()));
              },
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/arrow_image_gps.png',
                    height: 30.0,
                    width: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: new Text(
                      "Trip  ",
                      style: TextStyle(
                        fontSize: 25.0,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height:20),

            ElevatedButton(
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ignition_page()));
              },
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/power_button.png',
                    height: 60.0,
                    width: 60.0,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: new Text(
                      "Ignition  ",
                      style: TextStyle(
                        fontSize: 25.0,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
