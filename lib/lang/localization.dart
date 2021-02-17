import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';
import 'package:modern_art_app/data/sensitive.dart';
import 'package:modern_art_app/data/url_data_sources.dart';

part 'localization.g.dart';

/// Generates a localizations delegate from an online Google Sheet file, see
/// [flutter\_sheet\_localization](https://github.com/aloisdeniel/flutter_sheet_localization)
/// library for more information.
///
/// Run the following in the terminal to generate the necessary code:
///
/// `flutter packages pub run build_runner build`
///
/// or the following to continuously regenerate code when the code changes:
///
/// `flutter packages pub run build_runner watch`
///
/// In case the commands above report conflicts, append
/// `--delete-conflicting-outputs` and re-run.
@SheetLocalization(docId, i18nSheetID, 23)
// The number is the generated version, and must be incremented each time the
// GSheet is updated, to regenerate a new version of the labels.
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languages.containsKey(locale);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
