import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'login_page.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        title: Text("Sign up", style: TextStyle(fontSize: 25)),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Register Account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text("complete your details ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SignUpForm(),
            ]),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmpassword = "";
  var phnumber = "";

  //var user = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final phnumberController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    phnumberController.dispose();
    super.dispose();
  }

  String mobileDeviceId = 'Unknown';
  //String firebaseUID = 'Unknown';
  // @override
  // void initState() {
  //   super.initState();
  //   initUniqueIdentifierState();
  // }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      mobileDeviceId = identifier;
      print("IMEI =" + mobileDeviceId);
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  registration() async {
    if (password == confirmpassword) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        User? user = FirebaseAuth.instance.currentUser;
        String firebaseUID = user!.uid.toString();
        //print("firebase uid =" + user!.uid);
        print("firebase uid =" + firebaseUID);
        var apiurl = Uri.parse("http://eatechgps.in/user_registration");
        String mapdata = jsonEncode({
          'user_name': email,
          'phone_number': phnumber,
          'password': password,
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

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue[900],
          content: Text(
            "Registration Success....",
            style: TextStyle(fontSize: 15.0),
          ),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak password') {
          print("password provided is too weak");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "password provided is too weak",
              style: TextStyle(fontSize: 15.0),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          print("Account already exists");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Account already exists",
              style: TextStyle(fontSize: 15.0),
            ),
          ));
        }
      }
    } else {
      print("password mismatch");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "password mismatch",
          style: TextStyle(fontSize: 15.0),
        ),
      ));
    }
  }

  // Future regapi() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   String firebaseUID = user!.uid.toString();

  //   var apiurl = Uri.parse("http://eatechgps.in/user_registration");
  //   String mapdata = jsonEncode({
  //     'user_name': email,
  //     'phone_number': phnumber,
  //     'password': password,
  //     'firebase_id': firebaseUID,
  //     //'mobileDeviceId': mobileDeviceId,
  //   });
  //   Map<String, String> setheaders = {
  //     'Content-Type': 'application/json',
  //     'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL'
  //   };
  //   http.Response response =
  //       await http.post(apiurl, headers: setheaders, body: mapdata);
  //   var data = jsonDecode(response.body);
  //   print("DATA: ${data}");
  //   print("${data["message"]}");
  // }





  // _setHeaders()=> {
  //   'Content-Type' : 'application/json',
  //   'Auth-Token': 'API-EATECH-NsVjeTwJ21MDhkItL',
  // };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    labelText: "EMAIL",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34),
                        gapPadding: 10),
                  ),
                  controller: emailController,
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
                  decoration: InputDecoration(
                    hintText: "Enter  your Phone no.",
                    labelText: "PHONE NUMBER",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34),
                        gapPadding: 10),
                  ),
                  controller: phnumberController,
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
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Re-enter password",
                    labelText: "PASSWORD",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34),
                        gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34),
                        gapPadding: 10),
                  ),
                  controller: confirmpasswordController,
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
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    onPrimary: Colors.white,
                    shadowColor: Colors.blueAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(400, 60), //////// HERE
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: 25)),
                  //style: TextButton.styleFrom(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                        confirmpassword = confirmpasswordController.text;
                        phnumber = phnumberController.text;
                      });
                      registration();
                      initUniqueIdentifierState();
                       //regapi();
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
