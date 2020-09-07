import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
import 'package:package_info/package_info.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Settings",
      children: [
        SimpleSettingsTile(
          title: "About",
          subtitle: "App info & Open source licences",
          onTap: () {
            PackageInfo.fromPlatform().then((packageInfo) => showAboutDialog(
                  context: context,
                  applicationName: packageInfo.appName,
                  applicationVersion: packageInfo.version,
                ));
          },
        ),
        SimpleSettingsTile(
          title: 'Changelog',
          subtitle: "Timeline of changes in the app",
          onTap: () {
            print("tapped");
            return WhatsNewPage.changelog(
              title: Text("whats new"),
              buttonText: Text("null"),
              // path: "/assets/CHANGELOG.md",
            );
          },
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
