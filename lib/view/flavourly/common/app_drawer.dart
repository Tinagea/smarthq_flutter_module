import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class AppDrawer {
  static Widget commonAppDrawer({required GlobalKey<ScaffoldState> scaffoldKey, required BuildContext context}) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Text(
              'Koustuv',
              style: TextStyle(
                fontSize: 24,
                color: Colors.purple,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            textColor: Colors.grey,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.FLAVOURLY_HOME_SCREEN);
              scaffoldKey.currentState!.closeDrawer();
            },
          ),
          ListTile(
            title: Text('My History'),
            textColor: Colors.grey,
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
            },
          ),
          ListTile(
            title: Text('Sign Out'),
            textColor: Colors.red,
            onTap: () {
              scaffoldKey.currentState!.closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}
