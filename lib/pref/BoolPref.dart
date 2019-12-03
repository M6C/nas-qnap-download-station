
abstract class BoolPref {

  static const bool DEFAULT_VALUE = false;

  Future<bool> get() async => Future.value(false);

  Future<bool> set(bool value) async => Future.value(false);

  String text(bool b) => "";
}