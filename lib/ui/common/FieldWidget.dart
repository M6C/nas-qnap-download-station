import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  String initialVaue;
  String hintText;
  dynamic onSubmitted;
  TextEditingController ctrl;
  dynamic ctrlListener;
  bool obscureText;

  FieldWidget(this.initialVaue, this.hintText, {this.obscureText = false, this.onSubmitted, this.ctrl, this.ctrlListener, Key key}) : super(key: key);

  @override
  _FieldWidget createState() => new _FieldWidget();
}

class _FieldWidget extends State<FieldWidget> {

  _FieldWidget();

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
          child: new TextField(
//            decoration: new InputDecoration(hintText: widget.hintText, contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0)),
            decoration: InputDecoration(labelText: widget.hintText, hintText: widget.hintText,),
            obscureText: widget.obscureText,
            controller: _ctrl,
            textCapitalization: TextCapitalization.none,
            onSubmitted: widget.onSubmitted,
          ),
        );
    } //])
}
