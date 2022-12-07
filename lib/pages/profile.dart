import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final lastSigninTime =
      FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;
  @override
  Widget build(BuildContext context) {
    return  Container(
            constraints: BoxConstraints.expand(),
             decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("assets/images/app_bg3.jpg"),
                    fit: BoxFit.cover)),
     child: Column(
      children: [
        SizedBox(height: 8,),
        Container(
         width: 500,
         height: 100,
         color: Colors.black,
         margin: EdgeInsets.all(5),
           child:
            Card(
              color: Colors.black,  
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                   height: 10.0,
                 ),
                  Text( 
                   "    EMAIL:",
                   style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                  SizedBox(
                   height: 8.0,
                 ),
                  Text(
                    '    $email',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                     ),
                   ),
                 ],
               ),
             ),
           ),
        // SizedBox(height: 20,),
          Container(
         width: 500,
         height: 100,
         color:Colors.black,
         margin: EdgeInsets.all(3),
           child:
            Card( 
              color:Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                   height: 10.0,
                 ),
                  Text( 
                   "    CREATED AT:",
                   style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white
                  ),
                ),
                  SizedBox(
                   height: 8.0,
                 ),
                  Text(
                    '    $creationTime',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                     ),
                   ),
                 ],
               ),
             ),
           ), 
            Container(
         width: 500,
         height: 100,
         color: Colors.black,
         margin: EdgeInsets.all(3),
           child:
            Card(  
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                   height: 10.0,
                 ),
                  Text( 
                   "    LAST LOGGED IN:",
                   style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                  SizedBox(
                   height: 8.0,
                 ),
                  Text(
                    '    $lastSigninTime',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                     ),
                   ),
                 ],
               ),
             ),
           ),  
      ],
     )
    );
    // Container(
    // ListView.builder(
    //   padding: EdgeInsets.all(10.0),
    //   itemCount: 1,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Card(
    //       child: Padding(
    //         padding: EdgeInsets.all(10.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "Email",
    //               style: TextStyle(
    //                 fontSize: 16.0,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 5.0,
    //             ),
    //             Text(
    //               '$email',
    //               style: TextStyle(
    //                 fontSize: 14.0,
    //                 color: Colors.grey,
    //               ),
    //             ),
    //           ],

    //        ),

    //       ),
    //     );
    //   },
    // ),
    //);

    // return Container(
    //   // color: Colors.blue[900],
    //   alignment: Alignment.center,
    //   width: 400,
    //   height: 400,
    //   margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
    //   decoration: BoxDecoration(
    //     color: Colors.blue[900],
    //     borderRadius: BorderRadius.circular(20),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.red,
    //         blurRadius: 4,
    //         offset: Offset(4, 8), // Shadow position
    //       ),
    //     ],
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    //     child: Column(
    //       children: [
    //         Text(
    //           'Email :''$email',
    //           style: TextStyle(
    //             fontSize: 20.0,
    //             color: Colors.white
    //           ),
    //         ),
    //         SizedBox(height: 20),
    //         Text(
    //           'Created:''$creationTime',
    //           style: TextStyle(
    //             fontSize: 20.0,
    //             color: Colors.white
    //           ),
    //         ),
    //          SizedBox(height: 20),
    //         Text(
    //           'Last Logged in:$lastSigninTime',
    //           style: TextStyle(
    //             fontSize: 20.0,
    //             color: Colors.white
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
