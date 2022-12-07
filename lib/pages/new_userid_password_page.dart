import 'package:eagle_eye/pages/login_page.dart';
import 'package:flutter/material.dart';

class ChangeuseridpasswordPage extends StatelessWidget {
  const ChangeuseridpasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Change Userid and Password"),
        ),
        body: ChangeuseridForm());
  }
}

class ChangeuseridForm extends StatefulWidget {
  const ChangeuseridForm({Key? key}) : super(key: key);

  @override
  _ChangeuseridFormState createState() => _ChangeuseridFormState();
}

class _ChangeuseridFormState extends State<ChangeuseridForm> {
  final _formKey = GlobalKey<FormState>();
  var _Password = TextEditingController();
  var _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Enter New email",
              labelText: "EMAIL",
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34), gapPadding: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34), gapPadding: 10),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return "User name can not be empty";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _Password,
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
          TextFormField(
            controller: _confirmPassword,
            decoration: InputDecoration(
              hintText: "Re-enter  New Password",
              labelText: "PASSWORD",
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34), gapPadding: 10),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34), gapPadding: 10),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value != _Password.value.text) {
                return "Please Enter same Password";
              }
              // if (value!.isEmpty) {
              //   return "Password can not be empty";
              // } else if (value.length < 6) {
              //   return "Password should be at least 6 characters";
              // } else if (value.length > 15) {
              //   return "Password should not be more than 15 characters";
              // } else {
              //   return null;
              // }
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
