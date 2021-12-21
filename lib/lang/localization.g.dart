// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localization.dart';

// **************************************************************************
// SheetLocalizationGenerator
// **************************************************************************

final localizedLabels = <Locale, AppLocalizationsData>{
  Locale.fromSubtags(languageCode: 'en'): const AppLocalizationsData(
    artworkDetails: 'Artwork details',
    artistDetails: 'Artist details',
    galleryName: 'State Gallery of Contemporary Art',
    description: 'Description',
    artworksBy: 'Artworks by',
    biography: 'Short biography',
    featuredArtwork: 'Featured artwork',
    artists: 'Artists',
    artworks: 'Artworks',
    stngs: const AppLocalizationsDataStngs(
      expandableOther: 'Other settings',
      groupOther: 'Other',
      groupDatabase: 'Database',
      groupAbout: 'About',
      title: 'Settings',
      stng: const AppLocalizationsDataStngsStng(
        historyExportSummary:
            'Allows exporting & sharing the artwork recognition history so far',
        historyExport: 'Export recognition history',
        galleryWebsiteSummary: 'Website for the Gallery',
        databaseBrowserSummary:
            'Shows all tables and items in the app\'s database',
        databaseBrowser: 'App database browser',
        changelogSummary: 'Timeline of changes in the app',
        changelog: 'Changelog',
        appVersion: 'App version',
        appMadeBy:
            'Made by the BIO-SCENT MRG at CYENS (RISE) Centre of Excellence.',
        appDescription:
            'App for the State Gallery of Contemporary Cypriot Art.',
        appInfoSummary: 'App version & Open source libraries',
        appInfo: 'App information',
      ),
    ),
    msg: const AppLocalizationsDataMsg(
      unableToLaunchUrl: 'Unable to launch url',
      pointTheCamera: 'Point the camera to an artwork',
      noneIdentified: 'No artworks identified',
      analysing: 'Analysing...',
    ),
    button: const AppLocalizationsDataButton(
      close: 'Close',
      more: 'more',
    ),
    nav: const AppLocalizationsDataNav(
      identify: 'Identify artwork',
      explore: 'Explore',
    ),
  ),
  Locale.fromSubtags(languageCode: 'el'): const AppLocalizationsData(
    artworkDetails: 'Στοιχεία έργου τέχνης',
    artistDetails: 'Στοιχεία καλλιτέχνη/ιδας',
    galleryName: 'Κρατική Πινακοθήκη Σύγχρονης Τέχνης',
    description: 'Περιγραφή',
    artworksBy: 'Έργα τέχνης του/της',
    biography: 'Σύντομο βιογραφικό',
    featuredArtwork: 'Προτεινόμενο έργο τέχνης',
    artists: 'Καλλιτέχνες',
    artworks: 'Εργα τέχνης',
    stngs: const AppLocalizationsDataStngs(
      expandableOther: 'Άλλες ρυθμίσεις',
      groupOther: 'Πρόσθετα',
      groupDatabase: 'Βάση δεδομένων',
      groupAbout: 'Σχετικά',
      title: 'Ρυθμίσεις',
      stng: const AppLocalizationsDataStngsStng(
        historyExportSummary:
            'Επιτρέπει την εξαγωγή και κοινοποίηση του ιστορικού αναγνώρισης έργων τέχνης μέχρι τώρα',
        historyExport: 'Εξαγωγή ιστορικού αναγνωρίσεων',
        galleryWebsiteSummary: 'Ιστοσελίδα της Πινακοθήκης',
        databaseBrowserSummary:
            'Όλοι οι πίνακες και αντικείμενα στην βάση δεδομένων της εφαρμογής',
        databaseBrowser: 'Περιήγηση βάσης δεδομένων εφαρμογής',
        changelogSummary: 'Ιστορικό αλλαγών στην εφαρμογή',
        changelog: 'Ιστορικό αλλαγών',
        appVersion: 'Έκδοση εφαρμογής',
        appMadeBy:
            'Δημιουργία του BIO-SCENT MRG στο CYENS (RISE) Centre of Excellence.',
        appDescription:
            'Εφαρμογή για την Κρατική Πινακοθήκη Σύγχρονης Κυπριακής Τέχνης.',
        appInfoSummary: 'Εκδοση εφαρμογής & Βιβλιοθήκες ανοιχτού κώδικα',
        appInfo: 'Πληροφορίες για την εφαρμογή',
      ),
    ),
    msg: const AppLocalizationsDataMsg(
      unableToLaunchUrl: 'Δεν είναι δυνατή η εκκίνηση του url',
      pointTheCamera: 'Στρέψτε την κάμερα σε ένα έργο τέχνης',
      noneIdentified: 'Καμία αναγνώριση',
      analysing: 'Ανάλυση εικόνας...',
    ),
    button: const AppLocalizationsDataButton(
      close: 'Κλείσιμο',
      more: 'περισσότερα',
    ),
    nav: const AppLocalizationsDataNav(
      identify: 'Αναγνώριση έργου',
      explore: 'Εξερευνήστε',
    ),
  ),
};

class AppLocalizationsData {
  const AppLocalizationsData({
    required this.artworkDetails,
    required this.artistDetails,
    required this.galleryName,
    required this.description,
    required this.artworksBy,
    required this.biography,
    required this.featuredArtwork,
    required this.artists,
    required this.artworks,
    required this.stngs,
    required this.msg,
    required this.button,
    required this.nav,
  });

  final String artworkDetails;
  final String artistDetails;
  final String galleryName;
  final String description;
  final String artworksBy;
  final String biography;
  final String featuredArtwork;
  final String artists;
  final String artworks;
  final AppLocalizationsDataStngs stngs;
  final AppLocalizationsDataMsg msg;
  final AppLocalizationsDataButton button;
  final AppLocalizationsDataNav nav;
  factory AppLocalizationsData.fromJson(Map<String, Object?> map) =>
      AppLocalizationsData(
        artworkDetails: map['artworkDetails']! as String,
        artistDetails: map['artistDetails']! as String,
        galleryName: map['galleryName']! as String,
        description: map['description']! as String,
        artworksBy: map['artworksBy']! as String,
        biography: map['biography']! as String,
        featuredArtwork: map['featuredArtwork']! as String,
        artists: map['artists']! as String,
        artworks: map['artworks']! as String,
        stngs: AppLocalizationsDataStngs.fromJson(
            map['stngs']! as Map<String, Object?>),
        msg: AppLocalizationsDataMsg.fromJson(
            map['msg']! as Map<String, Object?>),
        button: AppLocalizationsDataButton.fromJson(
            map['button']! as Map<String, Object?>),
        nav: AppLocalizationsDataNav.fromJson(
            map['nav']! as Map<String, Object?>),
      );

  AppLocalizationsData copyWith({
    String? artworkDetails,
    String? artistDetails,
    String? galleryName,
    String? description,
    String? artworksBy,
    String? biography,
    String? featuredArtwork,
    String? artists,
    String? artworks,
    AppLocalizationsDataStngs? stngs,
    AppLocalizationsDataMsg? msg,
    AppLocalizationsDataButton? button,
    AppLocalizationsDataNav? nav,
  }) =>
      AppLocalizationsData(
        artworkDetails: artworkDetails ?? this.artworkDetails,
        artistDetails: artistDetails ?? this.artistDetails,
        galleryName: galleryName ?? this.galleryName,
        description: description ?? this.description,
        artworksBy: artworksBy ?? this.artworksBy,
        biography: biography ?? this.biography,
        featuredArtwork: featuredArtwork ?? this.featuredArtwork,
        artists: artists ?? this.artists,
        artworks: artworks ?? this.artworks,
        stngs: stngs ?? this.stngs,
        msg: msg ?? this.msg,
        button: button ?? this.button,
        nav: nav ?? this.nav,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsData &&
          artworkDetails == other.artworkDetails &&
          artistDetails == other.artistDetails &&
          galleryName == other.galleryName &&
          description == other.description &&
          artworksBy == other.artworksBy &&
          biography == other.biography &&
          featuredArtwork == other.featuredArtwork &&
          artists == other.artists &&
          artworks == other.artworks &&
          stngs == other.stngs &&
          msg == other.msg &&
          button == other.button &&
          nav == other.nav);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      artworkDetails.hashCode ^
      artistDetails.hashCode ^
      galleryName.hashCode ^
      description.hashCode ^
      artworksBy.hashCode ^
      biography.hashCode ^
      featuredArtwork.hashCode ^
      artists.hashCode ^
      artworks.hashCode ^
      stngs.hashCode ^
      msg.hashCode ^
      button.hashCode ^
      nav.hashCode;
}

class AppLocalizationsDataStngs {
  const AppLocalizationsDataStngs({
    required this.expandableOther,
    required this.groupOther,
    required this.groupDatabase,
    required this.groupAbout,
    required this.title,
    required this.stng,
  });

  final String expandableOther;
  final String groupOther;
  final String groupDatabase;
  final String groupAbout;
  final String title;
  final AppLocalizationsDataStngsStng stng;
  factory AppLocalizationsDataStngs.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataStngs(
        expandableOther: map['expandableOther']! as String,
        groupOther: map['groupOther']! as String,
        groupDatabase: map['groupDatabase']! as String,
        groupAbout: map['groupAbout']! as String,
        title: map['title']! as String,
        stng: AppLocalizationsDataStngsStng.fromJson(
            map['stng']! as Map<String, Object?>),
      );

  AppLocalizationsDataStngs copyWith({
    String? expandableOther,
    String? groupOther,
    String? groupDatabase,
    String? groupAbout,
    String? title,
    AppLocalizationsDataStngsStng? stng,
  }) =>
      AppLocalizationsDataStngs(
        expandableOther: expandableOther ?? this.expandableOther,
        groupOther: groupOther ?? this.groupOther,
        groupDatabase: groupDatabase ?? this.groupDatabase,
        groupAbout: groupAbout ?? this.groupAbout,
        title: title ?? this.title,
        stng: stng ?? this.stng,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataStngs &&
          expandableOther == other.expandableOther &&
          groupOther == other.groupOther &&
          groupDatabase == other.groupDatabase &&
          groupAbout == other.groupAbout &&
          title == other.title &&
          stng == other.stng);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      expandableOther.hashCode ^
      groupOther.hashCode ^
      groupDatabase.hashCode ^
      groupAbout.hashCode ^
      title.hashCode ^
      stng.hashCode;
}

class AppLocalizationsDataStngsStng {
  const AppLocalizationsDataStngsStng({
    required this.historyExportSummary,
    required this.historyExport,
    required this.galleryWebsiteSummary,
    required this.databaseBrowserSummary,
    required this.databaseBrowser,
    required this.changelogSummary,
    required this.changelog,
    required this.appVersion,
    required this.appMadeBy,
    required this.appDescription,
    required this.appInfoSummary,
    required this.appInfo,
  });

  final String historyExportSummary;
  final String historyExport;
  final String galleryWebsiteSummary;
  final String databaseBrowserSummary;
  final String databaseBrowser;
  final String changelogSummary;
  final String changelog;
  final String appVersion;
  final String appMadeBy;
  final String appDescription;
  final String appInfoSummary;
  final String appInfo;
  factory AppLocalizationsDataStngsStng.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataStngsStng(
        historyExportSummary: map['historyExportSummary']! as String,
        historyExport: map['historyExport']! as String,
        galleryWebsiteSummary: map['galleryWebsiteSummary']! as String,
        databaseBrowserSummary: map['databaseBrowserSummary']! as String,
        databaseBrowser: map['databaseBrowser']! as String,
        changelogSummary: map['changelogSummary']! as String,
        changelog: map['changelog']! as String,
        appVersion: map['appVersion']! as String,
        appMadeBy: map['appMadeBy']! as String,
        appDescription: map['appDescription']! as String,
        appInfoSummary: map['appInfoSummary']! as String,
        appInfo: map['appInfo']! as String,
      );

  AppLocalizationsDataStngsStng copyWith({
    String? historyExportSummary,
    String? historyExport,
    String? galleryWebsiteSummary,
    String? databaseBrowserSummary,
    String? databaseBrowser,
    String? changelogSummary,
    String? changelog,
    String? appVersion,
    String? appMadeBy,
    String? appDescription,
    String? appInfoSummary,
    String? appInfo,
  }) =>
      AppLocalizationsDataStngsStng(
        historyExportSummary: historyExportSummary ?? this.historyExportSummary,
        historyExport: historyExport ?? this.historyExport,
        galleryWebsiteSummary:
            galleryWebsiteSummary ?? this.galleryWebsiteSummary,
        databaseBrowserSummary:
            databaseBrowserSummary ?? this.databaseBrowserSummary,
        databaseBrowser: databaseBrowser ?? this.databaseBrowser,
        changelogSummary: changelogSummary ?? this.changelogSummary,
        changelog: changelog ?? this.changelog,
        appVersion: appVersion ?? this.appVersion,
        appMadeBy: appMadeBy ?? this.appMadeBy,
        appDescription: appDescription ?? this.appDescription,
        appInfoSummary: appInfoSummary ?? this.appInfoSummary,
        appInfo: appInfo ?? this.appInfo,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataStngsStng &&
          historyExportSummary == other.historyExportSummary &&
          historyExport == other.historyExport &&
          galleryWebsiteSummary == other.galleryWebsiteSummary &&
          databaseBrowserSummary == other.databaseBrowserSummary &&
          databaseBrowser == other.databaseBrowser &&
          changelogSummary == other.changelogSummary &&
          changelog == other.changelog &&
          appVersion == other.appVersion &&
          appMadeBy == other.appMadeBy &&
          appDescription == other.appDescription &&
          appInfoSummary == other.appInfoSummary &&
          appInfo == other.appInfo);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      historyExportSummary.hashCode ^
      historyExport.hashCode ^
      galleryWebsiteSummary.hashCode ^
      databaseBrowserSummary.hashCode ^
      databaseBrowser.hashCode ^
      changelogSummary.hashCode ^
      changelog.hashCode ^
      appVersion.hashCode ^
      appMadeBy.hashCode ^
      appDescription.hashCode ^
      appInfoSummary.hashCode ^
      appInfo.hashCode;
}

class AppLocalizationsDataMsg {
  const AppLocalizationsDataMsg({
    required this.unableToLaunchUrl,
    required this.pointTheCamera,
    required this.noneIdentified,
    required this.analysing,
  });

  final String unableToLaunchUrl;
  final String pointTheCamera;
  final String noneIdentified;
  final String analysing;
  factory AppLocalizationsDataMsg.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataMsg(
        unableToLaunchUrl: map['unableToLaunchUrl']! as String,
        pointTheCamera: map['pointTheCamera']! as String,
        noneIdentified: map['noneIdentified']! as String,
        analysing: map['analysing']! as String,
      );

  AppLocalizationsDataMsg copyWith({
    String? unableToLaunchUrl,
    String? pointTheCamera,
    String? noneIdentified,
    String? analysing,
  }) =>
      AppLocalizationsDataMsg(
        unableToLaunchUrl: unableToLaunchUrl ?? this.unableToLaunchUrl,
        pointTheCamera: pointTheCamera ?? this.pointTheCamera,
        noneIdentified: noneIdentified ?? this.noneIdentified,
        analysing: analysing ?? this.analysing,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataMsg &&
          unableToLaunchUrl == other.unableToLaunchUrl &&
          pointTheCamera == other.pointTheCamera &&
          noneIdentified == other.noneIdentified &&
          analysing == other.analysing);
  @override
  int get hashCode =>
      runtimeType.hashCode ^
      unableToLaunchUrl.hashCode ^
      pointTheCamera.hashCode ^
      noneIdentified.hashCode ^
      analysing.hashCode;
}

class AppLocalizationsDataButton {
  const AppLocalizationsDataButton({
    required this.close,
    required this.more,
  });

  final String close;
  final String more;
  factory AppLocalizationsDataButton.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataButton(
        close: map['close']! as String,
        more: map['more']! as String,
      );

  AppLocalizationsDataButton copyWith({
    String? close,
    String? more,
  }) =>
      AppLocalizationsDataButton(
        close: close ?? this.close,
        more: more ?? this.more,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataButton &&
          close == other.close &&
          more == other.more);
  @override
  int get hashCode => runtimeType.hashCode ^ close.hashCode ^ more.hashCode;
}

class AppLocalizationsDataNav {
  const AppLocalizationsDataNav({
    required this.identify,
    required this.explore,
  });

  final String identify;
  final String explore;
  factory AppLocalizationsDataNav.fromJson(Map<String, Object?> map) =>
      AppLocalizationsDataNav(
        identify: map['identify']! as String,
        explore: map['explore']! as String,
      );

  AppLocalizationsDataNav copyWith({
    String? identify,
    String? explore,
  }) =>
      AppLocalizationsDataNav(
        identify: identify ?? this.identify,
        explore: explore ?? this.explore,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppLocalizationsDataNav &&
          identify == other.identify &&
          explore == other.explore);
  @override
  int get hashCode =>
      runtimeType.hashCode ^ identify.hashCode ^ explore.hashCode;
}
