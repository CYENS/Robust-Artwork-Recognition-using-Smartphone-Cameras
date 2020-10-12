import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = context.strings();
    return SettingsScreen(
      title: strings.stngs.title,
      children: [
        SliderSettingsTile(
          title: 'CNN sensitivity',
          settingKey: 'key-slider-volume',
          defaultValue: 99.5,
          min: 90,
          max: 100,
          step: 0.5,
          // leading: Icon(Icons.volume_up),
          onChange: (value) {
            debugPrint('key-slider-volume: $value');
          },
        ),
        SettingsGroup(
          title: strings.stngs.groupAbout,
          children: [
            SimpleSettingsTile(
              title: strings.stngs.stng.appInfo,
              subtitle: strings.stngs.stng.appInfoSummary,
              onTap: () {
                PackageInfo.fromPlatform()
                    .then((packageInfo) => showAboutDialog(
                          context: context,
                          applicationName: packageInfo.appName,
                          applicationVersion: packageInfo.version,
                        ));
              },
            ),
            SimpleSettingsTile(
              title: strings.stngs.stng.changelog,
              subtitle: strings.stngs.stng.changelogSummary,
              onTap: () {
                print("tapped");
                return WhatsNewPage.changelog(
                  title: Text("whats new"),
                  buttonText: Text("null"),
                  // path: "/assets/CHANGELOG.md",
                );
              },
            ),
            SimpleSettingsTile(
              title: "App database browser",
              subtitle: "Shows all tables and items in the app's database",
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MoorDbViewer(Provider.of<AppDatabase>(context)))),
            ),
          ],
        )
      ],
    );
  }
}
