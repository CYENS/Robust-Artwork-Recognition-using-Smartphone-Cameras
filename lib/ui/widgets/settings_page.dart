import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_whatsnew/flutter_whatsnew.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/inference_algorithms.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

// All settings keys are specified here, to avoid mistakes typing them
// manually every time.
const String keyCnnModel = "keyCnnModel";
const String keyRecognitionAlgo = "recognitionAlgorithm";
const String keyCnnSensitivity = "keyCnnSensitivity";
const String keyWinThreshP = "keyWinThreshP";

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
              settingKey: keyCnnModel,
              values: tfLiteModelNames,
              selected: mobileNetNoArt,
              onChange: (value) {
                debugPrint("$keyCnnModel: $value");
              },
            ),
            RadioModalSettingsTile<String>(
              title: "Recognition algorithm",
              settingKey: keyRecognitionAlgo,
              values: Map<String, String>.fromIterable(
                algorithmList,
                key: (key) => key,
                value: (key) => key,
              ),
              selected: firstAlgorithm,
              onChange: (value) {
                debugPrint("$keyRecognitionAlgo: $value");
                setState(() {});
              },
            ),
            SliderSettingsTile(
              title: "CNN sensitivity",
              settingKey: keyCnnSensitivity,
              defaultValue: 99,
              min: 98,
              max: 100,
              step: 0.2,
              onChange: (value) {
                debugPrint("$keyCnnSensitivity: $value");
              },
            ),
            SliderSettingsTile(
              title: _getIntSettingName(),
              settingKey: keyWinThreshP,
              defaultValue: 5,
              min: 5,
              max: 50,
              step: 1,
              onChange: (value) {
                debugPrint("$keyWinThreshP: $value");
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

/// Returns the default values for the settings of each algorithm used.
Map<String, num> _defaultSettings(String modelName) {
  return {
    firstAlgorithm: {keyCnnSensitivity: 99.0, keyWinThreshP: 5},
    secondAlgorithm: {keyCnnSensitivity: 90.0, keyWinThreshP: 10},
    thirdAlgorithm: {keyCnnSensitivity: 90.0, keyWinThreshP: 10},
    fourthAlgorithm: {keyCnnSensitivity: 90.0, keyWinThreshP: 20},
  }[modelName];
}

String _getIntSettingName() {
  var currentAlgo = Settings.getValue(keyRecognitionAlgo, firstAlgorithm);
  if ([firstAlgorithm, secondAlgorithm].contains(currentAlgo)) {
    return "Window length";
  } else if (currentAlgo == thirdAlgorithm) {
    return "Count threshold";
  } else {
    return "P";
  }
}
