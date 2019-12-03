import 'package:flutter/material.dart';

class DrawerItemAccountPicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
//          _launchURL('http://www.google.fr');
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://loremflickr.com/160/120/music,metal'),
        ));
  }
}
