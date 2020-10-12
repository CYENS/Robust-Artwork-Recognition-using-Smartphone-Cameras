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
      biography: "Short biography",
      artworksBy: "Artworks by",
      description: "Description",
      galleryName: "State Gallery of Contemporary Art",
      artistDetails: "Artist details",
      artworkDetails: "Artwork details",
      nav: AppLocalizations_Labels_Nav(
        explore: "Explore",
        identify: "Identify artwork",
      ),
      button: AppLocalizations_Labels_Button(
        more: "more",
      ),
      stngs: AppLocalizations_Labels_Stngs(
        title: "Settings",
        groupAbout: "About",
        stng: AppLocalizations_Labels_Stngs_Stng(
          appInfo: "App information",
          appInfoSummary: "App version & Open source libraries",
          changelog: "Changelog",
          changelogSummary: "Timeline of changes in the app",
        ),
      ),
    ),
    Locale.fromSubtags(languageCode: "el"): AppLocalizations_Labels(
      artworks: "Εργα τέχνης",
      artists: "Καλλιτέχνες/ιδες",
      artworkOfTheWeek: "Έργο τέχνης της εβδομάδας",
      pointTheCamera: "Στρέψτε την κάμερα σε ένα έργο τέχνης",
      biography: "Σύντομο βιογραφικό",
      artworksBy: "Έργα τέχνης από",
      description: "Περιγραφή",
      galleryName: "Κρατική Πινακοθήκη Σύγχρονης Τέχνης",
      artistDetails: "Στοιχεία καλλιτέχνη/ιδας",
      artworkDetails: "Στοιχεία έργου τέχνης",
      nav: AppLocalizations_Labels_Nav(
        explore: "Εξερευνήστε",
        identify: "Αναγνώριση έργου τέχνης",
      ),
      button: AppLocalizations_Labels_Button(
        more: "περισσότερα",
      ),
      stngs: AppLocalizations_Labels_Stngs(
        title: "Ρυθμίσεις",
        groupAbout: "Σχετικά",
        stng: AppLocalizations_Labels_Stngs_Stng(
          appInfo: "Πληροφορίες για την εφαρμογή",
          appInfoSummary: "Εκδοση εφαρμογής & Βιβλιοθήκες ανοιχτού κώδικα",
          changelog: "Ιστορικό αλλαγών",
          changelogSummary: "Ιστορικό αλλαγών στην εφαρμογή",
        ),
      ),
    ),
  };

  final AppLocalizations_Labels labels;

  static AppLocalizations_Labels of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)?.labels;
}

class AppLocalizations_Labels_Nav {
  const AppLocalizations_Labels_Nav({this.explore, this.identify});

  final String explore;

  final String identify;

  String getByKey(String key) {
    switch (key) {
      case 'explore':
        return explore;
      case 'identify':
        return identify;
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

class AppLocalizations_Labels_Stngs_Stng {
  const AppLocalizations_Labels_Stngs_Stng(
      {this.appInfo,
      this.appInfoSummary,
      this.changelog,
      this.changelogSummary});

  final String appInfo;

  final String appInfoSummary;

  final String changelog;

  final String changelogSummary;

  String getByKey(String key) {
    switch (key) {
      case 'appInfo':
        return appInfo;
      case 'appInfoSummary':
        return appInfoSummary;
      case 'changelog':
        return changelog;
      case 'changelogSummary':
        return changelogSummary;
      default:
        return '';
    }
  }
}

class AppLocalizations_Labels_Stngs {
  const AppLocalizations_Labels_Stngs({this.title, this.groupAbout, this.stng});

  final String title;

  final String groupAbout;

  final AppLocalizations_Labels_Stngs_Stng stng;

  String getByKey(String key) {
    switch (key) {
      case 'title':
        return title;
      case 'groupAbout':
        return groupAbout;
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
      this.biography,
      this.artworksBy,
      this.description,
      this.galleryName,
      this.artistDetails,
      this.artworkDetails,
      this.nav,
      this.button,
      this.stngs});

  final String artworks;

  final String artists;

  final String artworkOfTheWeek;

  final String pointTheCamera;

  final String biography;

  final String artworksBy;

  final String description;

  final String galleryName;

  final String artistDetails;

  final String artworkDetails;

  final AppLocalizations_Labels_Nav nav;

  final AppLocalizations_Labels_Button button;

  final AppLocalizations_Labels_Stngs stngs;

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
      case 'biography':
        return biography;
      case 'artworksBy':
        return artworksBy;
      case 'description':
        return description;
      case 'galleryName':
        return galleryName;
      case 'artistDetails':
        return artistDetails;
      case 'artworkDetails':
        return artworkDetails;
      default:
        return '';
    }
  }
}
