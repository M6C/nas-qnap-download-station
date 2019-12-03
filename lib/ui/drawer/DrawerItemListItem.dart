import 'package:flutter/material.dart';

class DrawerItemListItem extends StatelessWidget {
  IconData _icon;
  String _title;
  WidgetBuilder _downloadTable;

  DrawerItemListItem(this._icon, this._title, this._downloadTable);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_icon),
      title: Text(_title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: this._downloadTable),
        );
      },
    );
  }
}
