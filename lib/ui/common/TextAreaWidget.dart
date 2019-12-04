import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAreaWidget extends StatefulWidget {

  String text;
  TextEditingController ctrl;
  bool obscureText;

  TextAreaWidget(this.text, this.ctrl, {this.obscureText = false, Key key,}) : super(key: key);

  @override
  _TextAreaWidget createState() => new _TextAreaWidget();
}

class _TextAreaWidget extends State<TextAreaWidget> {
  TextEditingController _ctrl;

  _TextAreaWidget();
  @override
  void initState() {
    super.initState();
    _ctrl = widget.ctrl ?? new TextEditingController(text:widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return
      /*new Expanded(
        child: */Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white70,
            child: Container(
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300.0,
                ),
//                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
//                    reverse: true,
                    child: new TextField(
                      decoration: new InputDecoration.collapsed(hintText: ""),
                      obscureText: widget.obscureText,
//                      readOnly: true,
                      maxLines: null,
                      controller: _ctrl,
                      onTap: _onTag,
                    ),
                  ),
//                ),
              ),
            )
          )
        )//,
      //)
    ;
     //])
  }

  _onTag() {
    if (_ctrl.text.isEmpty) {
      Clipboard.getData("text/plain").then((txt) {
        setState(() {
          _ctrl.text = txt.text;
        });
      });
    }
  }
}
