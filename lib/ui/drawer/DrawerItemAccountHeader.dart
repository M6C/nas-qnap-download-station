import 'package:flutter/material.dart';
import 'package:nas_qnap_download_station/ui/drawer/DrawerItemAccountPicture.dart';

class DrawerItemAccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text('QNap Download Station'),
      accountEmail: FlatButton(
        padding: EdgeInsets.zero,
//        onPressed: () => _launchURL('mailto:roca.david@gmail.com?subject=Down%20Your%20Music&body=Your%20Feedback...'),
        child: Text(
          'roca.david@gmail.com',
          style: TextStyle(decoration: TextDecoration.underline, color: Colors.lightBlue[100]),
        ),
      ),
      currentAccountPicture: DrawerItemAccountPicture(),
      decoration: BoxDecoration(color: Colors.blue[900]),
    );
  }
}
