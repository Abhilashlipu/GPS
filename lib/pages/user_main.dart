
import 'package:eagle_eye/pages/home.dart';
import 'package:eagle_eye/pages/login_page.dart';
import 'package:eagle_eye/pages/profile.dart';
import 'package:eagle_eye/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final lastSigninTime =
      FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;
  int _selectedIndex = 0;
  final storage = new FlutterSecureStorage();
  static List<Widget> _widgetOption = <Widget>[
    Home(),
    Profile(),
    Settings(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("WELCOME", style: TextStyle(fontSize: 25, color: Colors.white)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red[900],
              onPrimary: Colors.white,
              shadowColor: Colors.blueAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(100, 50), //////// HERE
            ),
            child: Text('Logout',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            //style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
            onPressed: () async => {
              await FirebaseAuth.instance.signOut(),
              await storage.delete(key: "uid"),
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage()))
            },
          )
        ]),
      ),
      //starting of drawer
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(" "),
              accountEmail: new Text("$email"),
              currentAccountPicture: Image.asset(
                'assets/images/scootyprofile_icon.png',
              )
              // CircleAvatar(
              //     backgroundColor: Colors.yellow,
              //     child: Text('Lipu', style: TextStyle(color: Colors.black87))),
              ,
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.indigo,
                      Colors.purple,
                    ]),
              ),
            ),
            new ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.indigo,
                ),
               // tileColor: Colors.pink[100],
                title: new Text("Home"),
                onTap: () {
                  int Index = 0;
                  _onItemTapped(0);
                  Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => UserMain()));
                }),
            new ListTile(
                leading: Icon(Icons.person,
                color: Colors.indigo,),
               // tileColor: Colors.pink[100],
                title: new Text("My Account"),
                onTap: () {
                  int Index = 1;
                  _onItemTapped(1);
                  Navigator.pop(context);
                }),
            new ListTile(
                leading: Icon(Icons.history),
               // tileColor: Colors.pink[100],
                title: new Text("History"),
                onTap: () {
                  Navigator.pop(context);
                }),
           // new Divider(),
            new ListTile(
                leading: Icon(Icons.settings,
                color: Colors.indigo,),
                //tileColor: Colors.pink[100],
                title: new Text("Settings"),
                onTap: () {
                  int Index = 2;
                  _onItemTapped(2);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Settings()));
                  Navigator.pop(context);
                }),
            new ListTile(
                leading: Icon(Icons.power_settings_new,
                color: Colors.indigo,),
               // tileColor: Colors.pink[100],
                title: new Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  FirebaseAuth.instance.signOut();
                  storage.delete(key: "uid");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                  
                }),
          ],
        ),
      ),
      //ending of drawer
      body: _widgetOption.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountCircle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.tools),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
