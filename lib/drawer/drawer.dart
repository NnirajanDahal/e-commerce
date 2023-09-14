import 'package:ecommerce_app/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Future logOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('token');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged Out')),
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 260,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 70.0),
            width: double.infinity,
            height: 220,
            color: Colors.blueAccent,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: AssetImage("assets/logo.png"),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Kminchelle",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("View Details"),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite_outlined,
              color: Colors.red,
            ),
            title: Text("Favourites"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          ListTile(
            onTap: () {
              logOut(context);
            },
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
