import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  final String _notifKey = 'notification';

  Future<void> setNotification({required bool isNotification}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_notifKey, isNotification);
  }

  Future<bool> getNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_notifKey) ?? false;
    return value;
  }
}
