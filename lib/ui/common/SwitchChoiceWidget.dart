import 'package:flutter/material.dart';

import 'package:nas_qnap_download_station/pref/BoolPref.dart';

class SwitchChoiceWidget extends StatefulWidget {
  BoolPref _boolPref;
  SwitchChoiceWidget(this._boolPref, {Key key}) : super(key: key);

  @override
  _SwitchChoiceWidget createState() => new _SwitchChoiceWidget(_boolPref);
}

class _SwitchChoiceWidget extends State<SwitchChoiceWidget> {
  BoolPref _boolPref;
  bool _choice = BoolPref.DEFAULT_VALUE;

  _SwitchChoiceWidget(this._boolPref) {
    _boolPref.get().then((v) {
      setState(() {
        _choice= v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*new Column(children: <Widget>[*/
        new Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(_boolPref.text(_choice)),
      Switch(
          value: _choice,
          onChanged: (value) {
            _boolPref.set(value).then((v) {
              setState(() {
                _choice = v;
              });
            });
          }),
    ]); //])
  }
}
