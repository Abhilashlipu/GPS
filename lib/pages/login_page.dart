import 'dart:convert';

import 'package:eagle_eye/constant.dart';
import 'package:eagle_eye/localdb.dart';
import 'package:eagle_eye/pages/forgot_password_page.dart';
import 'package:eagle_eye/pages/onboarding_page.dart';
import 'package:eagle_eye/pages/second_page.dart';
import 'package:eagle_eye/pages/sign_up_page.dart';
import 'package:eagle_eye/pages/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit ?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  //close the app when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.greenAccent[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => SystemNavigator.pop(),
            //close the app when click on "<-"

            icon: const Icon(Icons.arrow_back),
          ),
          title: Text("EA TECH GPS",
              style: TextStyle(
                fontSize: 23,
              )),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.gif"),
                  fit: BoxFit.cover)),
          child: const SignForm(),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  //late VideoPlayerController _controller;
  var email = "";
  var password = "";
  bool remember = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _controller = VideoPlayerController.network(
  //     'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
  //   ..initialize().then((_) {
  //     _controller.play();
  //     _controller.setLooping(true);
  //     // Ensure the first frame is shown after the video is initialized
  //     setState(() {});
  // });

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await storage.write(key: "uid", value: userCredential.user?.uid);
      //loginapi();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          "Login  Successfully....",
          style: TextStyle(fontSize: 20.0),
        ),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserMain()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "No user found for that email",
            style: TextStyle(fontSize: 15.0),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided by user");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Wrong password provided by user",
            style: TextStyle(fontSize: 15.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return SingleChildScrollView(
      child: Form(
        // autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Text(
                  "WELCOME ",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          labelText: "EMAIL",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(34),
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(34),
                              gapPadding: 10),
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter user name';
                          } else if (!value.contains('@')) {
                            return 'Please enter valid user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "PASSWORD",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(34),
                              gapPadding: 10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(34),
                              gapPadding: 10),
                        ),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can not be empty";
                          } else if (value.length < 6) {
                            return "Password should be at least 6 characters";
                          } else if (value.length > 15) {
                            return "Password should not be more than 15 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.blue,
                            activeColor: Colors.black,
                            value: remember,
                            onChanged: (value) {
                              setState(() {
                                remember = value!;
                              });
                            },
                          ),
                          Text("Remember me"),
                          const Spacer(),
                          GestureDetector(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage())),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          onPrimary: Colors.white,
                          shadowColor: Colors.blueAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(500, 50), //////// HERE
                        ),
                        child: Text("Login", style: TextStyle(fontSize: 25)),
                        // style: TextButton.styleFrom(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userLogin();
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16),
                            child: Text(
                              "     New User?",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue[900],
                                onPrimary: Colors.white,
                                shadowColor: Colors.blueAccent,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0)),
                                minimumSize: Size(100, 50), //////// HERE
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                              child: Text("Sign up",
                                  style: TextStyle(fontSize: 25)))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginapi() async {
    var apiurl = Uri.parse("http://eatechgps.in/user_login");
    String mapdata = jsonEncode({
      'user_name': email,
      'password': password,
    });
    Map<String, String> setheaders = {
      'Content-Type': 'application/json',
      'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
    }; 
    http.Response response =
        await http.post(apiurl, headers: setheaders, body: mapdata);
    var data = jsonDecode(response.body);
    print("DATA: ${data}");
    //print("${data["message"]}");
    String msg = data["message"].toString();
    
    LocalDataSaver.saveMsg(msg.toString());
    //constant.msg = (await LocalDataSaver.getMsg())!;
    print(msg);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserMain()),
    );
  }
}
