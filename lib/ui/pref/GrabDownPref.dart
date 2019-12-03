import 'dart:async';

import 'package:nas_qnap_download_station/pref/BoolPref.dart';
import 'package:nas_qnap_download_station/pref/CommonPref.dart';

class GrabDownPref implements BoolPref {

  static const bool DEFAULT_VALUE = false;

  static final String _key = "flutter.audio";
  static GrabDownPref instance;

  static GrabDownPref getInstance() => instance = instance ?? new GrabDownPref();

  @override
  Future<bool> get() async => CommonPref.getBool(_key, true);

  @override
  Future<bool> set(bool value) async => CommonPref.setBool(_key, value);

  @override
  String text(bool b) => b ? 'Grab and Download' : 'Grab Only';
}
