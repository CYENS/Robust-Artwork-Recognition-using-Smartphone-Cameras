import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'viewings_dao.g.dart';

/// Data access object for [Viewing] database related operations.
@UseDao(tables: [Viewings])
class ViewingsDao extends DatabaseAccessor<AppDatabase>
    with _$ViewingsDaoMixin {
  ViewingsDao(AppDatabase db) : super(db);

  /// Inserts a [ViewingsCompanion] into the database; used for keeping track
  /// of which artworks the user saw and in which order.
  Future insertTask(ViewingsCompanion viewing) =>
      into(viewings).insert(viewing);

  /// Gets a list of all viewing entries in the db.
  Future<List<Viewing>> get allViewingEntries => select(viewings).get();
}
