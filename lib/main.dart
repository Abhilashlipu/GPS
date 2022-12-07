//import 'dart:html';
import 'package:eagle_eye/notification.dart';
import 'package:eagle_eye/pages/login_page.dart';
import 'package:eagle_eye/pages/onboarding_page.dart';
import 'package:eagle_eye/pages/user_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:workmanager/workmanager.dart';

 const simpleTaskKey = "simpleTask";
  const simplePeriodicTask = "simplePeriodicTask"; 


 void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
       
       
        break;
     
      case simplePeriodicTask:

      NotificationService()
                    .showNotification(1, "Alert", "Battery Low", 1);
        print("$simplePeriodicTask was executed");
        break;
      
    }

    return Future.value(true);
  });
}
void main() async {
  await Future.delayed(Duration(seconds: 1));
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await GetStorage.init();

  Workmanager().initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  


  runApp(MyApp());

  

 


}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final storage = new FlutterSecureStorage();
  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
                future: checkLoginStatus(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == false) {
                    return OnBoardingPage();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return UserMain();
                }),
            themeMode: ThemeMode.light,
            theme: ThemeData(primarySwatch: Colors.blue),
            darkTheme: ThemeData(brightness: Brightness.dark),
          );
        });

    //  MaterialApp(
    //   home: HomePage(),
    //   themeMode: ThemeMode.light,
    //   theme: ThemeData(primarySwatch: Colors.blue[900]),
    //   darkTheme: ThemeData(brightness: Brightness.dark),
    // );
  }
}
