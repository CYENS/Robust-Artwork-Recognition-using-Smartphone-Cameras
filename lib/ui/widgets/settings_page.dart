import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Settings",
      children: [
        SimpleSettingsTile(
          title: "About",
          subtitle: "subtitle",
          onTap: () => showAboutDialog(
              context: context, applicationName: "Modern Art App"),
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
