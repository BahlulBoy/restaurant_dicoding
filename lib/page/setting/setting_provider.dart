import 'dart:developer';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/page/setting/setting_state.dart';
import 'package:restaurant_dicoding/utils/background_service.dart';
import 'package:restaurant_dicoding/utils/date_time_helper.dart';
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
    if (isOn) {
      await SharedPreferenceUtils().setNotification(isNotification: isOn);
      state.notification = isOn;
      final date = DateTimeHelper.format();
      log(date.toString());
      AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: date,
        exact: true,
        wakeup: true,
      );
      notifyListeners();
    } else {
      await SharedPreferenceUtils().setNotification(isNotification: isOn);
      state.notification = isOn;
      AndroidAlarmManager.cancel(1);
      notifyListeners();
    }
  }
}
