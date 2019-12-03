import 'package:flutter/material.dart';
import 'package:nas_qnap_download_station/ui/common/SwitchChoiceWidget.dart';
import 'package:nas_qnap_download_station/ui/drawer/DrawerItemAccountHeader.dart';
import 'package:nas_qnap_download_station/ui/pref/GrabDownPref.dart';

class GrabSiteDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        Expanded(
          // ListView contains a group of widgets that scroll inside the drawer
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerItemAccountHeader(),
                SwitchChoiceWidget(GrabDownPref.getInstance()),
//            DrawerItemListItem(Icons.table_chart, 'Downloads', (context) => DownloadTableRoute()),
//            DrawerItemListItem(Icons.schedule, 'Donwloads Fetch Monitor', (context) => DownloadFetchRoute()),
              ],
            )
        )
        ,
        // This container holds the align
        Container(
//          alignment: AlignmentDirectional.center,
            // This align moves the children to the bottom
//            child: Align(
//                alignment: FractionalOffset.bottomCenter,
                // This container holds all the children that will be aligned
                // on the bottom and should not scroll with the above ListView
                child: Container(
                    child: Column(
                  children: <Widget>[
//                    Divider(),
//                    DrawerItemListItem(Icons.settings, 'Settings', (context) => SettingRoute()),
//                    DrawerItemListItem(Icons.bug_report, 'Logs', (context) => LogTableRoute()),
                  ],
                ))
//            )
        ),
      ]),
    );
  }
}
