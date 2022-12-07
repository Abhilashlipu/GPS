import 'dart:ffi';

import 'package:eagle_eye/pages/new_userid_password_page.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int start = 60;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Please Enter your otp"),
              SizedBox(
                height: 20,
              ),
              builderTimer(),
              SizedBox(
                height: 40,
              ),
              OtpForm(),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OtpPage())),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row builderTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: " This code will expire in ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              TextSpan(
                  text: " 00:$start ",
                  style: TextStyle(fontSize: 20, color: Colors.red)),
              TextSpan(
                  text: " sec ",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ],
          ),
        ),

      ],
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60.0,
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black))),
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60.0,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black))),
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60.0,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black))),
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60.0,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  autofocus: true,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.black))),
                  onChanged: (value) {
                    pin4FocusNode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeuseridpasswordPage()));
              },
              child: Text("Continue"))
        ],
      ),
    );
  }
}
