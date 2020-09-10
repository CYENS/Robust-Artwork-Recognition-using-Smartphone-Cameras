// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

class AppLocalizations {
  AppLocalizations(this.locale) : this.labels = languages[locale];

  final Locale locale;

  static final Map<Locale, AppLocalizations_Labels> languages = {
    Locale.fromSubtags(languageCode: "en"): AppLocalizations_Labels(
      nav: AppLocalizations_Labels_Nav(
        explore: "Explore",
        identify: "Identify artwork",
        settings: "Settings",
      ),
    ),
    Locale.fromSubtags(languageCode: "el"): AppLocalizations_Labels(
      nav: AppLocalizations_Labels_Nav(
        explore: "Εξερευνήστε",
        identify: "Αναγνώριση έργου τέχνης",
        settings: "Ρυθμίσεις",
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

class AppLocalizations_Labels_Nav {
  const AppLocalizations_Labels_Nav(
      {this.explore, this.identify, this.settings});

  final String explore;

  final String identify;

  final String settings;

  String getByKey(String key) {
    switch (key) {
      case 'explore':
        return explore;
      case 'identify':
        return identify;
      case 'settings':
        return settings;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels({this.nav});

  final AppLocalizations_Labels_Nav nav;

  String getByKey(String key) {
    switch (key) {
      default:
        return '';
    }
  }
}
