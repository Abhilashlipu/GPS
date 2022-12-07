
import 'package:eagle_eye/pages/change_password.dart';
import 'package:eagle_eye/pages/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'alert_notification.dart';
import 'forgot_password_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  User? user = FirebaseAuth.instance.currentUser;
  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[900],
        content: Text(
          "Verify email link has  been sent....",
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    }
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
          children: <Widget>[
            SizedBox(height: 20,),
           ElevatedButton(
             
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      onPrimary: Colors.white,
                      shadowColor: Colors.red,                     
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(350, 60),
                       //////// HERE
                    ),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/change_pass.png',
                          height: 35.0,
                          width: 35.0,
                          color: Colors.orange[900],
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: new Text(
                              "Change password",
                              style: TextStyle(
                                  fontSize: 25.0, 
                                  //fontWeight: FontWeight.bold
                                  ),
                            ))
                      ],  
                    ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangepasswordPage()));
              },
            ),
            SizedBox(height: 20),
            user!.emailVerified
                ? Container(
                    width: 350,
                    height: 60,
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 4,
                          offset: Offset(4, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                       //vertical: 20,
                       horizontal: 30,
                      ),
                      child:new Row(
                      mainAxisSize: MainAxisSize.min,
                      children:<Widget>[
                        new Image.asset(
                          'assets/images/email_verified.png',
                          height: 40.0,
                          width: 40.0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: new Text(
                              "Email verified",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white 
                                  //fontWeight: FontWeight.bold
                                  ),
                            ))
                      ],  
                    ),
                      // Text(
                      //   'Email Verified',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(height: 20, fontSize: 25,color: Colors.white)
                      // ),
                   ),
                  )
                //Text('Email verified')
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      onPrimary: Colors.white,
                      shadowColor: Colors.blueAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(350,60), //////// HERE
                    ),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/gmail_icon.png',
                          //color: Colors.orange[900],
                          height: 45.0,
                          width: 45.0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: new Text(
                              " Verify Email       ",
                              style: TextStyle(
                                  fontSize: 25.0, 
                                  //fontWeight: FontWeight.bold
                                  ),
                            ))
                      ],  
                    ),
                    onPressed: () {
                      verifyEmail();
                    }),

              SizedBox(height: 20,),      

              ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      onPrimary: Colors.white,
                      shadowColor: Colors.blueAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(350,60), //////// HERE
                    ),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Image.asset(
                          'assets/images/notification.png',
                          //color: Colors.orange[900],
                          height: 45.0,
                          width: 45.0,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: new Text(
                              " Alert       ",
                              style: TextStyle(
                                  fontSize: 25.0, 
                                  //fontWeight: FontWeight.bold
                                  ),
                            ))
                      ],  
                    ),
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => AlertPage()));
                    }),

                    SizedBox(height: 20,),
                    // ElevatedButton(
                    //   onPressed: (){
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //     builder: (context) => SliderWidget())); 
                    // },
                    //  child: Text('Slider')),      
          ],
        ),
      ),
    );
  }
}
