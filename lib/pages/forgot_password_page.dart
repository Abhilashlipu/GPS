import 'package:eagle_eye/pages/login_page.dart';
import 'package:eagle_eye/pages/otp_verification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Forgot Password"),
        ),
        body: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/background.gif"),
                        fit: BoxFit.cover)),
            
                 child:const ForgotpasswordForm() ,
                
                ),
         );
  }
}

class ForgotpasswordForm extends StatefulWidget {
  const ForgotpasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotpasswordFormState createState() => _ForgotpasswordFormState();
}

class _ForgotpasswordFormState extends State<ForgotpasswordForm> {
  var email = "";
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[900],
        content: Text(
          "password reset Email has been sent",
          style: TextStyle(fontSize: 16.0),
        ),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "No user found for that email",
            style: TextStyle(fontSize: 16.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Reset link will be sent to your email.. ",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    labelText: "EMAIL",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34), gapPadding: 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(34), gapPadding: 10),
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
                // TextFormField(
                //   decoration: InputDecoration(
                //     hintText: "Enter  your Phone no.",
                //     labelText: "PHONE NUMBER",
                //     enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(34), gapPadding: 10),
                //     focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(34), gapPadding: 10),
                //   ),
                //   keyboardType: TextInputType.phone,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return "Please Enter your Phone number";
                //     } else if (value.length < 10) {
                //       return "Please Enter Valid Phone number";
                //     } else if (value.length > 10) {
                //       return "Please Enter Valid Phone number";
                //     } else {
                //       return null;
                //     }
                //   },
                // ),
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
                        email = emailController.text;
                      });
                      resetPassword();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const OtpPage()));
                    }
                  },
                  child: Text("Send email"),
                ),
              ],
            ),
          ),
        ),     
    );
  }
}
