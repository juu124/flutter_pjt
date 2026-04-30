import 'package:flutter/material.dart';

import '../services/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingScreenState();
  }
}

class SettingScreenState extends State<SettingScreen> {
  bool _isNotification = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
    _loadDarkModeSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final value = await PreferenceService.getNotificationSetting();
    setState(() {
      _isNotification = value;
    });
  }

  Future<void> _loadDarkModeSetting() async {
    final value = await PreferenceService.getDarkModeSetting();
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '알림 설정',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('알림 On/OFF'),
                    Switch(
                      value: _isNotification,
                      onChanged: (value) async {
                        await PreferenceService.setNotificationSetting(value);
                        setState(() {
                          _isNotification = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            const Text(
              '테마 설정',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('다크 모드 설정'),
                    Switch(
                      value: _isDarkMode,
                      onChanged: (value) async {
                        await PreferenceService.setDarkModeSetting(value);
                        setState(() {
                          _isDarkMode = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            const Text(
              '앱 정보',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsetsGeometry.only(left: 10),
              child: Text('버전 1.0.0'),
            ),
          ],
        ),
      ),
    );
  }
}
