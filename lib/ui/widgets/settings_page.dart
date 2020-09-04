import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:package_info/package_info.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Settings",
      children: [
        SimpleSettingsTile(
          title: "About",
          subtitle: "subtitle",
          onTap: () {
            PackageInfo.fromPlatform().then((packageInfo) => showAboutDialog(
                  context: context,
                  applicationName: packageInfo.appName,
                  applicationVersion: packageInfo.version,
                ));
          },
        ),
        CheckboxSettingsTile(
          settingKey: 'key-setting-checkbox',
          title: 'Checkbox',
          subtitle: "subtitle",
        ),
        SwitchSettingsTile(
          settingKey: "switch-key",
          title: "Switch",
          subtitle: "subtitle",
        )
      ],
    );
  }
}
