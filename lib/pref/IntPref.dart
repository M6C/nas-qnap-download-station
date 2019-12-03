
abstract class IntPref {

  static const int DEFAULT_VALUE = -1;

  Future<int> get() async => Future.value(DEFAULT_VALUE);

  Future<int> set(int value) async => Future.value(DEFAULT_VALUE);

  String text(int b) => "";

  String hintText() => "";
}