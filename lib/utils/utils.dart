import 'package:modern_art_app/data/database.dart';

/// Formats an [Artist]'s lifespan properly, returning only year of birth if
/// they are alive, or their lifespan otherwise.
///
/// TODO implement this in [ArtistTranslated] class perhaps
///
/// TODO return e.g. "b. 2000" in the first case, if [ArtistTranslated] is used as an input argument, the locale will be available, and can adjust accordingly for language
String lifespan(Artist artist) => artist.yearDeath.isNotEmpty
    ? "${artist.yearBirth}–${artist.yearDeath}"
    : artist.yearBirth;
