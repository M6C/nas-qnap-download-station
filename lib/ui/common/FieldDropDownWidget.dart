import 'package:flutter/material.dart';

class FieldDropDownWidget extends StatefulWidget {
  String initialVaue;
  String hintText;
  dynamic onSubmitted;
  TextEditingController ctrl;
  dynamic ctrlListener;
  List<String> items = [];

  FieldDropDownWidget(this.initialVaue, this.hintText, {this.onSubmitted, this.ctrl, this.ctrlListener, this.items, Key key}) : super(key: key);

  @override
  _FieldDropDownWidget createState() => new _FieldDropDownWidget();
}

class _FieldDropDownWidget extends State<FieldDropDownWidget> {
  TextEditingController _controller;

  _FieldDropDownWidget();

  @override
  void initState() {
    super.initState();
    var _ctrl = widget.ctrl;
    if (_ctrl == null) {
      _ctrl = new TextEditingController(text: widget.initialVaue);
      _ctrl.addListener(widget.ctrlListener);
    }
    _controller = _ctrl;
  }

  @override
  Widget build(BuildContext context) {
    var _ctrl = widget.ctrl;
    if (_ctrl == null) {
      _ctrl = new TextEditingController(text: widget.initialVaue);
      _ctrl.addListener(widget.ctrlListener);
    }
      return
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    decoration: InputDecoration(labelText: widget.hintText, hintText: widget.hintText,),
                    controller: _controller,
                    onSubmitted: widget.onSubmitted,)
                ),
                new PopupMenuButton<String>(
                  icon: const Icon(Icons.arrow_drop_down),
                  onSelected: (String value) {
                    _controller.text = value;
                  },
                  itemBuilder: (BuildContext context) {
                    return widget.items.map<PopupMenuItem<String>>((String value) {
                      return new PopupMenuItem(child: new Text(value), value: value);
                    }).toList();
                  },
                ),
              ],
            ),
        );
    } //])
}
