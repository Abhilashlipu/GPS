// ignore_for_file: prefer_const_constructors

import 'package:eagle_eye/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangepasswordPage extends StatefulWidget {
  const ChangepasswordPage({Key? key}) : super(key: key);

  @override
  _ChangepasswordPageState createState() => _ChangepasswordPageState();
}

class _ChangepasswordPageState extends State<ChangepasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100] ,
        appBar: AppBar(
          title: Text("Change  Password",
          style: TextStyle(fontSize: 25)),
        ),
        body: ChangepasswordForm());
  }
}

class ChangepasswordForm extends StatefulWidget {
  const ChangepasswordForm({Key? key}) : super(key: key);

  @override
  _ChangepasswordFormState createState() => _ChangepasswordFormState();
}

class _ChangepasswordFormState extends State<ChangepasswordForm> {
  var newPassword = "";
  // var confirmnewPassword = "";

  final _formKey = GlobalKey<FormState>();
  final newpasswordController = TextEditingController();
  //final confirmnewpasswordController = TextEditingController();

  @override
  void dispose() {
    newpasswordController.dispose();
    //confirmnewPasswordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  modifyPassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          "Your password has been changed..Login again...",
          style: TextStyle(fontSize: 20.0),
        ),
      ));
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: newpasswordController,
              decoration: InputDecoration(
                hintText: "Enter  New Password",
                labelText: "PASSWORD",
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(34), gapPadding: 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(34), gapPadding: 10),
              ),
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
            SizedBox(height: 20),
            // TextFormField(
            //   controller: confirmnewpasswordController,
            //   decoration: InputDecoration(
            //     hintText: "Re-enter  New Password",
            //     labelText: "PASSWORD",
            //     enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(34), gapPadding: 10),
            //     focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(34), gapPadding: 10),
            //   ),
            //   keyboardType: TextInputType.text,
            //   validator: (value) {
            //     var _newpassword;
            //     if (value != confirmnewpasswordController.value.text) {
            //       return "Please Enter same Password";
            //     }
            //   },
            // ),
            // SizedBox(height: 20),
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = newpasswordController.text;
                  });
                  modifyPassword();
                }
              },
              child: Text("Continue",
              style: TextStyle(fontSize: 25),),
            ),
          ],
        ),
      ),
    );
  }
}
