import 'dart:async';

import 'package:flutter/material.dart';

class Loader {
  bool _isLoading = false;

  bool isLoading() {
    return _isLoading;
  }

  Future onLoading(context, {titleWidget}) async {
    Completer ret = new Completer();
    if (_isLoading) {
      return ret.future;
    }
    _isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            _isLoading = false;
            ret.complete();
            return Future.value(true);
          },
          child: new Dialog(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: titleWidget ?? new Text("Loading.."),
                  )
                ],
              )
            ),
          )
        );
      },
    );
    return ret.future;
  }

  void unloading(context) {
    if (_isLoading) {
      Navigator.pop(context); //pop dialog
      _isLoading = false;
    }
  }
}