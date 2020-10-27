import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget build(BuildContext context) {
    final strings = context.strings();
    return SettingsScreen(
      title: strings.stngs.title,
      children: [
        SettingsGroup(
          title: "Computer Vision options",
          children: [
            RadioModalSettingsTile<String>(
              title: "CNN type used",
              // TODO make keys constants in utils perhaps
              settingKey: "key-cnn-type",
              values: Map<String, String>.fromIterable(
                tfLiteModels.keys,
                key: (key) => key,
                value: (key) => key,
              ),
              selected: mobileNetNoArt,
              onChange: (value) {
                debugPrint("key-cnn-type: $value");
              },
            ),
            RadioModalSettingsTile<String>(
              title: "Recognition algorithm",
              settingKey: "key-recognition-algo",
              values: {
                "taverriti": "Taverriti et al. (2016)",
                "fiveFrameAverage": "5 frame inference average"
              },
              selected: "fiveFrameAverage",
              onChange: (value) {
                debugPrint("key-recognition-algo: $value");
              },
            ),
            SliderSettingsTile(
              title: "CNN sensitivity",
              settingKey: "key-cnn-sensitivity",
              defaultValue: 99,
              min: 98,
              max: 100,
              step: 0.2,
              onChange: (value) {
                debugPrint("key-cnn-sensitivity: $value");
              },
            )
          ],
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
