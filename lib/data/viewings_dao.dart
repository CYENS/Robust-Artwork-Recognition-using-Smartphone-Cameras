import 'package:modern_art_app/data/database.dart';
import 'package:moor/moor.dart';

part 'viewings_dao.g.dart';

/// Data access object for [Viewing] database related operations.
@UseDao(tables: [Viewings])
class ViewingsDao extends DatabaseAccessor<AppDatabase> with _$ViewingsDaoMixin {
  ViewingsDao(AppDatabase db) : super(db);

  Future insertTask(Viewing viewing) => into(viewings).insert(viewing);
}
