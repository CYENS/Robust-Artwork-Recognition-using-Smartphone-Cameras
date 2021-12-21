import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/inference_algorithms.dart';
import 'package:modern_art_app/data/viewings_dao.dart';
import 'package:modern_art_app/tensorflow/models.dart';
import 'package:modern_art_app/ui/pages/changelog_page.dart';
import 'package:modern_art_app/ui/pages/demo_identify_page.dart';
import 'package:modern_art_app/utils/extensions.dart';
import 'package:modern_art_app/utils/utils.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

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
    List<SettingsGroup> _settingsList = [
      SettingsGroup(
        title: strings.stngs.groupAbout.customToUpperCase(),
        children: [
          SimpleSettingsTile(
            // launch the Gallery's url in external browser
            title: strings.galleryName,
            subtitle: strings.stngs.stng.galleryWebsiteSummary,
            leading: Icon(Icons.web),
            onTap: () async {
              String url = "https://www.nicosia.org.cy/"
                  "${context.locale().languageCode == "en" ? 'en-GB' : 'el-GR'}"
                  "/discover/picture-galleries/state-gallery-of-contemporary-art/";
              if (await canLaunch(url)) {
                launch(url);
              } else {
                Fluttertoast.showToast(msg: strings.msg.unableToLaunchUrl);
              }
            },
          ),
          SimpleSettingsTile(
            title: strings.stngs.stng.appInfo,
            subtitle: strings.stngs.stng.appInfoSummary,
            leading: Icon(Icons.info_outline_rounded),
            onTap: () {
              PackageInfo.fromPlatform().then((packageInfo) => showAboutDialog(
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
            leading: Icon(Icons.history_rounded),
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
      ),
      SettingsGroup(
        title: strings.stngs.groupDatabase.customToUpperCase(),
        children: [
          SimpleSettingsTile(
            title: strings.stngs.stng.historyExport,
            subtitle: strings.stngs.stng.historyExportSummary,
            leading: Icon(Icons.share_rounded),
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
        title: strings.stngs.groupOther.customToUpperCase(),
        children: [
          ExpandableSettingsTile(
            title: strings.stngs.expandableOther,
            leading: Icon(Icons.settings_applications_rounded),
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
                defaultValue: 75.0,
                min: 0.0,
                max: 100.0,
                step: 0.2,
                onChange: (value) {
                  debugPrint("$keyCnnSensitivity: $value");
                },
              ),
              SliderSettingsTile(
                leading: Icon(Icons.space_bar),
                title: _getCurrentWinThreshPName(),
                settingKey: keyWinThreshP,
                defaultValue: 6,
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
                defaultValue: false,
              ),
              SimpleSettingsTile(
                title: "Navigate to demo Identify page",
                subtitle: "Used only for demo purposes",
                leading: Icon(Icons.history_rounded),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DemoIdentifyPage(),
                    ),
                  );
                },
              ),
              Padding(
                // padding to account for the convex app bar
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SimpleSettingsTile(
                  title: strings.stngs.stng.databaseBrowser,
                  subtitle: strings.stngs.stng.databaseBrowserSummary,
                  leading: Icon(Icons.table_rows),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            MoorDbViewer(Provider.of<AppDatabase>(context))),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ];
    return Scaffold(
      // by giving the scaffold a unique key, it's rebuild every time a setting
      // changes, so that the screen is updated with the new setting values
      key: UniqueKey(),
      appBar: AppBar(
        // todo override up button's default behaviour to fix nav bar issue
        title: Text(strings.stngs.title),
      ),
      // here a custom ListView is used instead of the SettingsScreen widget
      // provided by the library, to allow customizing the AppBar above and to
      // set BouncingScrollPhysics below
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _settingsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _settingsList[index];
        },
      ),
    );
  }
}

/// (Re)Sets the default values for the algorithms' settings each time a
/// new algorithm is chosen in settings.
void _setDefaultAlgorithmSettings(String algorithmName) {
  var defValues = defaultSettings(algorithmName);
  Settings.setValue<double>(keyCnnSensitivity, defValues![keyCnnSensitivity]);
  Settings.setValue<double>(keyWinThreshP, defValues[keyWinThreshP]);
}

/// Returns the default values for the settings of each algorithm used.
Map<String, dynamic>? defaultSettings(String algorithmName) {
  return {
    firstAlgorithm: {
      keyCnnSensitivity: 75.0,
      keyWinThreshP: 6.0,
      keyWinThreshPName: "Window length",
    },
    secondAlgorithm: {
      keyCnnSensitivity: 75.0,
      keyWinThreshP: 10.0,
      keyWinThreshPName: "Window length",
    },
    thirdAlgorithm: {
      keyCnnSensitivity: 75.0,
      keyWinThreshP: 10.0,
      keyWinThreshPName: "Count threshold"
    },
    fourthAlgorithm: {
      keyCnnSensitivity: 75.0,
      keyWinThreshP: 15.0,
      keyWinThreshPName: "P",
    },
  }[algorithmName];
}

/// Returns the actual name for the 2nd setting (besides sensitivity) of each
/// of the recognition algorithms.
String _getCurrentWinThreshPName() {
  var currentAlgo =
      Settings.getValue<String>(keyRecognitionAlgo, firstAlgorithm);
  return defaultSettings(currentAlgo)![keyWinThreshPName];
}
