import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nas_qnap_download_station/pref/BoolPref.dart';
import 'package:nas_qnap_download_station/pref/IntPref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonPref {

  static bool doLog = false;

  static Future<bool> getBool(String key, bool valueDefault) async {
    Completer<bool> ret = new Completer();
    try {
      SharedPreferences.getInstance().then((prefs) {
        bool b = prefs.getBool(key) ?? valueDefault;
      _logInfo(text:"getBool value:$b");
        ret.complete(b);
      });
    } catch (e) {
      print(e);
      ret.complete(BoolPref.DEFAULT_VALUE);
    }
    return ret.future;
  }

  static Future<bool> setBool(String key, bool value) async {
    Completer<bool> ret = new Completer();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool(key, value).then((v) {
      _logInfo(text:"setBool:$value");
        ret.complete(value);
      });
    } catch (e) {
      print(e);
      ret.complete(BoolPref.DEFAULT_VALUE);
    }
    return ret.future;
  }

  static Future<int> getInt(String key, int valueDefault) async {
    Completer<int> ret = new Completer();
    try {
      SharedPreferences.getInstance().then((prefs) {
        int b = prefs.getInt(key) ?? valueDefault;
      _logInfo(text:"getBool value:$b");
        ret.complete(b);
      });
    } catch (e) {
      print(e);
      ret.complete(IntPref.DEFAULT_VALUE);
    }
    return ret.future;
  }

  static Future<int> setInt(String key, int value) async {
    Completer<int> ret = new Completer();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt(key, value).then((v) {
      _logInfo(text:"setBool:$value");
        ret.complete(value);
      });
    } catch (e) {
      print(e);
      ret.complete(IntPref.DEFAULT_VALUE);
    }
    return ret.future;
  }

  static void _logInfo({String className, String methodName, @required String text,}) {
    if (doLog) {
//      ALog.info(className:className, methodName:methodName, text:text);
      print(text);
    }
  }
}