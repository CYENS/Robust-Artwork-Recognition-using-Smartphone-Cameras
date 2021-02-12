import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/inference_algorithms.dart';
import 'package:modern_art_app/data/viewings_dao.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:modern_art_app/ui/pages/changelog_page.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:modern_art_app/utils/utils.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

// All settings keys are specified here, to avoid mistakes typing them
// manually every time.
const String keyCnnModel = "keyCnnModel";
const String keyRecognitionAlgo = "recognitionAlgorithm";
const String keyCnnSensitivity = "keyCnnSensitivity";
const String keyWinThreshP = "keyWinThreshP";
const String keyWinThreshPName = "keyWinThreshPName";
const String keyNavigateToDetails = "keyNavigateToDetails";
const String keyDisplayExtraInfo = "keyDisplayExtraInfo";

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget build(BuildContext context) {
    // TODO check if settings are set on first launch
    final strings = context.strings();
    ViewingsDao viewingsDao = Provider.of<ViewingsDao>(context);
    return Container(
      key: UniqueKey(),
      child: SettingsScreen(
        title: strings.stngs.title,
        children: [
          SettingsGroup(
            title: "Computer Vision options",
            children: [
              RadioModalSettingsTile<String>(
                title: "CNN type used",
                settingKey: keyCnnModel,
                values: tfLiteModelNames,
                selected: mobNetNoArt500_4,
                onChange: (value) {
                  debugPrint("$keyCnnModel: $value");
                },
              ),
              RadioModalSettingsTile<String>(
                title: "Recognition algorithm",
                settingKey: keyRecognitionAlgo,
                values: Map<String, String>.fromIterable(
                  allAlgorithms.keys,
                  key: (key) => key,
                  value: (key) => key,
                ),
                selected: firstAlgorithm,
                onChange: (value) {
                  debugPrint("$keyRecognitionAlgo: $value");
                  // reset values for algorithm settings every time a new
                  // algorithm is chosen
                  _setDefaultAlgorithmSettings(value);
                  setState(() {});
                },
              ),
              SliderSettingsTile(
                leading: Icon(Icons.adjust),
                title: "CNN sensitivity",
                settingKey: keyCnnSensitivity,
                defaultValue: 99.0,
                min: 0.0,
                max: 100.0,
                step: 0.2,
                onChange: (value) {
                  debugPrint("$keyCnnSensitivity: $value");
                },
              ),
              SliderSettingsTile(
                leading: Icon(Icons.multiline_chart),
                title: _getCurrentWinThreshPName(),
                settingKey: keyWinThreshP,
                defaultValue: 5,
                min: 5,
                max: 50,
                step: 1,
                onChange: (value) {
                  debugPrint("$keyWinThreshP: $value");
                },
              ),
              SwitchSettingsTile(
                leading: Icon(Icons.navigation),
                title: "Navigate to recognised artworks' details",
                settingKey: keyNavigateToDetails,
                defaultValue: true,
              ),
              SwitchSettingsTile(
                leading: Icon(Icons.list_alt_outlined),
                title: "Display model & algorithm information in camera view",
                settingKey: keyDisplayExtraInfo,
                defaultValue: true,
              ),
            ],
          ),
          SettingsGroup(
            title: strings.stngs.groupDatabase.customToUpperCase(),
            children: [
              SimpleSettingsTile(
                title: strings.stngs.stng.databaseBrowser,
                subtitle: strings.stngs.stng.databaseBrowserSummary,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MoorDbViewer(Provider.of<AppDatabase>(context)))),
              ),
              SimpleSettingsTile(
                title: strings.stngs.stng.historyExport,
                subtitle: strings.stngs.stng.historyExportSummary,
                onTap: () async {
                  viewingsDao.allViewingEntries.then((viewings) {
                    String viewingsInStr = jsonEncode(viewings);
                    print(viewingsInStr);
                    // write to file
                    saveToJsonFile(viewingsInStr).then((jsonFile) {
                      print(jsonFile);
                      // share saved json file via share dialog
                      Share.shareFiles([jsonFile], subject: "Viewings history");
                    });
                  });
                },
              ),
            ],
          ),
          SettingsGroup(
            title: strings.stngs.groupAbout.customToUpperCase(),
            children: [
              SimpleSettingsTile(
                title: strings.stngs.stng.appInfo,
                subtitle: strings.stngs.stng.appInfoSummary,
                onTap: () {
                  PackageInfo.fromPlatform()
                      .then((packageInfo) => showAboutDialog(
                            context: context,
                            applicationIcon: const SizedBox(
                              width: 80,
                              height: 80,
                              child: Image(
                                image: AssetImage(
                                    'assets/app_launcher_icons/hadjida_untitled_app_icon_square_android_adaptive.png'),
                              ),
                            ),
                            applicationName: strings.galleryName,
                            applicationVersion:
                                "${strings.stngs.stng.appVersion}: ${packageInfo.version}",
                            children: [
                              Text(strings.stngs.stng.appDescription),
                              Text(""),
                              Text(strings.stngs.stng.appMadeBy),
                            ],
                          ));
                },
              ),
              SimpleSettingsTile(
                title: strings.stngs.stng.changelog,
                subtitle: strings.stngs.stng.changelogSummary,
                onTap: () {
                  // here the root navigator is used, so that the changelog is
                  // displayed on top of the rest of the UI (and the NavBar)
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeLogPage(
                        changelogAssetsPath: "assets/CHANGELOG.md",
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// (Re)Sets the default values for the algorithms' settings each time a
/// new algorithm is chosen in settings.
void _setDefaultAlgorithmSettings(String algorithmName) {
  var defValues = _defaultSettings(algorithmName);
  Settings.setValue<double>(keyCnnSensitivity, defValues[keyCnnSensitivity]);
  Settings.setValue<double>(keyWinThreshP, defValues[keyWinThreshP]);
}

/// Returns the default values for the settings of each algorithm used.
Map<String, dynamic> _defaultSettings(String algorithmName) {
  return {
    firstAlgorithm: {
      keyCnnSensitivity: 99.0,
      keyWinThreshP: 5.0,
      keyWinThreshPName: "Window length",
    },
    secondAlgorithm: {
      keyCnnSensitivity: 90.0,
      keyWinThreshP: 10.0,
      keyWinThreshPName: "Window length",
    },
    thirdAlgorithm: {
      keyCnnSensitivity: 90.0,
      keyWinThreshP: 10.0,
      keyWinThreshPName: "Count threshold"
    },
    fourthAlgorithm: {
      keyCnnSensitivity: 90.0,
      keyWinThreshP: 20.0,
      keyWinThreshPName: "P",
    },
  }[algorithmName];
}

/// Returns the actual name for the 2nd setting (besides sensitivity) of each
/// of the recognition algorithms.
String _getCurrentWinThreshPName() {
  var currentAlgo =
      Settings.getValue<String>(keyRecognitionAlgo, firstAlgorithm);
  return _defaultSettings(currentAlgo)[keyWinThreshPName];
}
