import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/page/setting/setting_state.dart';
import 'package:restaurant_dicoding/utils/shared_preferences_utils.dart';

class SettingProvider extends ChangeNotifier {
  final state = SettingState();

  SettingProvider() {
    getNotificationSetting();
  }

  Future<void> getNotificationSetting() async {
    state.notification = await SharedPreferenceUtils().getNotification();
    notifyListeners();
  }

  Future<void> setNotification(bool isOn) async {
    await SharedPreferenceUtils().setNotification(isNotification: isOn);
    state.notification = isOn;
    notifyListeners();
  }
}
