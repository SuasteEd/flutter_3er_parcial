import 'package:examen_3er_parcial/main.dart';

class SharedPrefs {
  void clean() {
    sharedPreferences.clear();
  }

  bool get isLogin {
    return sharedPreferences.getBool('isLogin') ?? false;
  }

  set isLogin(bool value) {
    sharedPreferences.setBool('isLogin', value);
  }

  String get uid {
    return sharedPreferences.getString('uid') ?? '';
  }

  set uid(String value) {
    sharedPreferences.setString('uid', value);
  }
}
