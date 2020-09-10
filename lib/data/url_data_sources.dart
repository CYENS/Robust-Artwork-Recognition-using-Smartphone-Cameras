import 'package:modern_art_app/data/database.dart';
import 'package:modern_art_app/data/sensitive.dart';

/// This file contains links to the Google Sheet with artist/artwork information
/// used to build the app's database. The [docId] is saved separately on a
/// different file, so it is not included in the Git history.

/// The following url provides a json of the first sheet only, which is not very
/// useful, so it is not used anymore; left here for future reference.
const String gSheetDbUrlOld =
    "https://spreadsheets.google.com/feeds/list/$docId/od6/public/values?alt=json";

/// Google Sheets doc url with [Artwork] information in JSON format, that can
/// be parsed by the app and update its database.
const String gSheetUrlArtworks =
    "https://spreadsheets.google.com/feeds/list/$docId/3/public/values?alt=json";

/// Google Sheets doc url with [Artist] information in JSON format, that can
/// be parsed by the app and update its database.
const String gSheetUrlArtists =
    "https://spreadsheets.google.com/feeds/list/$docId/4/public/values?alt=json";

/// Sheet id that contains localization/internationalization fields, used by the
/// "flutter_sheet_localization" library, along with the [docId].
const String i18nSheetID = "1681157874";
