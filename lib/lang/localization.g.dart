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
      artworks: "Artworks",
      artists: "Artists",
      artworkOfTheWeek: "Artwork of the week",
      pointTheCamera: "Point the camera to an artwork",
      nav: AppLocalizations_Labels_Nav(
        explore: "Explore",
        identify: "Identify artwork",
        settings: "Settings",
      ),
      button: AppLocalizations_Labels_Button(
        more: "more",
      ),
    ),
    Locale.fromSubtags(languageCode: "el"): AppLocalizations_Labels(
      artworks: "Εργα τέχνης",
      artists: "Καλλιτέχνες",
      artworkOfTheWeek: "Έργο τέχνης της εβδομάδας",
      pointTheCamera: "Στρέψτε την κάμερα σε ένα έργο τέχνης",
      nav: AppLocalizations_Labels_Nav(
        explore: "Εξερευνήστε",
        identify: "Αναγνώριση έργου τέχνης",
        settings: "Ρυθμίσεις",
      ),
      button: AppLocalizations_Labels_Button(
        more: "περισσότερα",
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

class AppLocalizations_Labels_Button {
  const AppLocalizations_Labels_Button({this.more});

  final String more;

  String getByKey(String key) {
    switch (key) {
      case 'more':
        return more;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels {
  const AppLocalizations_Labels(
      {this.artworks,
      this.artists,
      this.artworkOfTheWeek,
      this.pointTheCamera,
      this.nav,
      this.button});

  final String artworks;

  final String artists;

  final String artworkOfTheWeek;

  final String pointTheCamera;

  final AppLocalizations_Labels_Nav nav;

  final AppLocalizations_Labels_Button button;

  String getByKey(String key) {
    switch (key) {
      case 'artworks':
        return artworks;
      case 'artists':
        return artists;
      case 'artworkOfTheWeek':
        return artworkOfTheWeek;
      case 'pointTheCamera':
        return pointTheCamera;
      default:
        return '';
    }
  }
}
