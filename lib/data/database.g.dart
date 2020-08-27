// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Painting extends DataClass implements Insertable<Painting> {
  final int id;
  final String title;
  final String year;
  final String description;
  final String artist;
  final String fileName;
  Painting(
      {@required this.id,
      @required this.title,
      this.year,
      this.description,
      this.artist,
      this.fileName});
  factory Painting.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Painting(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      year: stringType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
      fileName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}file_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<String>(year);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    return map;
  }

  PaintingsCompanion toCompanion(bool nullToAbsent) {
    return PaintingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
    );
  }

  factory Painting.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Painting(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      year: serializer.fromJson<String>(json['year']),
      description: serializer.fromJson<String>(json['description']),
      artist: serializer.fromJson<String>(json['artist']),
      fileName: serializer.fromJson<String>(json['fileName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'year': serializer.toJson<String>(year),
      'description': serializer.toJson<String>(description),
      'artist': serializer.toJson<String>(artist),
      'fileName': serializer.toJson<String>(fileName),
    };
  }

  Painting copyWith(
          {int id,
          String title,
          String year,
          String description,
          String artist,
          String fileName}) =>
      Painting(
        id: id ?? this.id,
        title: title ?? this.title,
        year: year ?? this.year,
        description: description ?? this.description,
        artist: artist ?? this.artist,
        fileName: fileName ?? this.fileName,
      );
  @override
  String toString() {
    return (StringBuffer('Painting(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('year: $year, ')
          ..write('description: $description, ')
          ..write('artist: $artist, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              year.hashCode,
              $mrjc(description.hashCode,
                  $mrjc(artist.hashCode, fileName.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Painting &&
          other.id == this.id &&
          other.title == this.title &&
          other.year == this.year &&
          other.description == this.description &&
          other.artist == this.artist &&
          other.fileName == this.fileName);
}

class PaintingsCompanion extends UpdateCompanion<Painting> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> year;
  final Value<String> description;
  final Value<String> artist;
  final Value<String> fileName;
  const PaintingsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.year = const Value.absent(),
    this.description = const Value.absent(),
    this.artist = const Value.absent(),
    this.fileName = const Value.absent(),
  });
  PaintingsCompanion.insert({
    this.id = const Value.absent(),
    @required String title,
    this.year = const Value.absent(),
    this.description = const Value.absent(),
    this.artist = const Value.absent(),
    this.fileName = const Value.absent(),
  }) : title = Value(title);
  static Insertable<Painting> custom({
    Expression<int> id,
    Expression<String> title,
    Expression<String> year,
    Expression<String> description,
    Expression<String> artist,
    Expression<String> fileName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (year != null) 'year': year,
      if (description != null) 'description': description,
      if (artist != null) 'artist': artist,
      if (fileName != null) 'file_name': fileName,
    });
  }

  PaintingsCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<String> year,
      Value<String> description,
      Value<String> artist,
      Value<String> fileName}) {
    return PaintingsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      description: description ?? this.description,
      artist: artist ?? this.artist,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaintingsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('year: $year, ')
          ..write('description: $description, ')
          ..write('artist: $artist, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }
}

class $PaintingsTable extends Paintings
    with TableInfo<$PaintingsTable, Painting> {
  final GeneratedDatabase _db;
  final String _alias;
  $PaintingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        minTextLength: 2, maxTextLength: 32);
  }

  final VerificationMeta _yearMeta = const VerificationMeta('year');
  GeneratedTextColumn _year;
  @override
  GeneratedTextColumn get year => _year ??= _constructYear();
  GeneratedTextColumn _constructYear() {
    return GeneratedTextColumn(
      'year',
      $tableName,
      true,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  GeneratedTextColumn _artist;
  @override
  GeneratedTextColumn get artist => _artist ??= _constructArtist();
  GeneratedTextColumn _constructArtist() {
    return GeneratedTextColumn('artist', $tableName, true,
        $customConstraints: 'NULL REFERENCES painters(name)');
  }

  final VerificationMeta _fileNameMeta = const VerificationMeta('fileName');
  GeneratedTextColumn _fileName;
  @override
  GeneratedTextColumn get fileName => _fileName ??= _constructFileName();
  GeneratedTextColumn _constructFileName() {
    return GeneratedTextColumn(
      'file_name',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, title, year, description, artist, fileName];
  @override
  $PaintingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'paintings';
  @override
  final String actualTableName = 'paintings';
  @override
  VerificationContext validateIntegrity(Insertable<Painting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist'], _artistMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name'], _fileNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Painting map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Painting.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PaintingsTable createAlias(String alias) {
    return $PaintingsTable(_db, alias);
  }
}

class Painter extends DataClass implements Insertable<Painter> {
  final String name;
  final String yearBirth;
  final String yearDeath;
  final String biography;
  final String fileName;
  Painter(
      {@required this.name,
      this.yearBirth,
      this.yearDeath,
      this.biography,
      this.fileName});
  factory Painter.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Painter(
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      yearBirth: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}year_birth']),
      yearDeath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}year_death']),
      biography: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}biography']),
      fileName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}file_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || yearBirth != null) {
      map['year_birth'] = Variable<String>(yearBirth);
    }
    if (!nullToAbsent || yearDeath != null) {
      map['year_death'] = Variable<String>(yearDeath);
    }
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String>(biography);
    }
    if (!nullToAbsent || fileName != null) {
      map['file_name'] = Variable<String>(fileName);
    }
    return map;
  }

  PaintersCompanion toCompanion(bool nullToAbsent) {
    return PaintersCompanion(
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      yearBirth: yearBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(yearBirth),
      yearDeath: yearDeath == null && nullToAbsent
          ? const Value.absent()
          : Value(yearDeath),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
      fileName: fileName == null && nullToAbsent
          ? const Value.absent()
          : Value(fileName),
    );
  }

  factory Painter.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Painter(
      name: serializer.fromJson<String>(json['name']),
      yearBirth: serializer.fromJson<String>(json['yearBirth']),
      yearDeath: serializer.fromJson<String>(json['yearDeath']),
      biography: serializer.fromJson<String>(json['biography']),
      fileName: serializer.fromJson<String>(json['fileName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'yearBirth': serializer.toJson<String>(yearBirth),
      'yearDeath': serializer.toJson<String>(yearDeath),
      'biography': serializer.toJson<String>(biography),
      'fileName': serializer.toJson<String>(fileName),
    };
  }

  Painter copyWith(
          {String name,
          String yearBirth,
          String yearDeath,
          String biography,
          String fileName}) =>
      Painter(
        name: name ?? this.name,
        yearBirth: yearBirth ?? this.yearBirth,
        yearDeath: yearDeath ?? this.yearDeath,
        biography: biography ?? this.biography,
        fileName: fileName ?? this.fileName,
      );
  @override
  String toString() {
    return (StringBuffer('Painter(')
          ..write('name: $name, ')
          ..write('yearBirth: $yearBirth, ')
          ..write('yearDeath: $yearDeath, ')
          ..write('biography: $biography, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      name.hashCode,
      $mrjc(
          yearBirth.hashCode,
          $mrjc(yearDeath.hashCode,
              $mrjc(biography.hashCode, fileName.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Painter &&
          other.name == this.name &&
          other.yearBirth == this.yearBirth &&
          other.yearDeath == this.yearDeath &&
          other.biography == this.biography &&
          other.fileName == this.fileName);
}

class PaintersCompanion extends UpdateCompanion<Painter> {
  final Value<String> name;
  final Value<String> yearBirth;
  final Value<String> yearDeath;
  final Value<String> biography;
  final Value<String> fileName;
  const PaintersCompanion({
    this.name = const Value.absent(),
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.biography = const Value.absent(),
    this.fileName = const Value.absent(),
  });
  PaintersCompanion.insert({
    @required String name,
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.biography = const Value.absent(),
    this.fileName = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Painter> custom({
    Expression<String> name,
    Expression<String> yearBirth,
    Expression<String> yearDeath,
    Expression<String> biography,
    Expression<String> fileName,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (yearBirth != null) 'year_birth': yearBirth,
      if (yearDeath != null) 'year_death': yearDeath,
      if (biography != null) 'biography': biography,
      if (fileName != null) 'file_name': fileName,
    });
  }

  PaintersCompanion copyWith(
      {Value<String> name,
      Value<String> yearBirth,
      Value<String> yearDeath,
      Value<String> biography,
      Value<String> fileName}) {
    return PaintersCompanion(
      name: name ?? this.name,
      yearBirth: yearBirth ?? this.yearBirth,
      yearDeath: yearDeath ?? this.yearDeath,
      biography: biography ?? this.biography,
      fileName: fileName ?? this.fileName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (yearBirth.present) {
      map['year_birth'] = Variable<String>(yearBirth.value);
    }
    if (yearDeath.present) {
      map['year_death'] = Variable<String>(yearDeath.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String>(biography.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaintersCompanion(')
          ..write('name: $name, ')
          ..write('yearBirth: $yearBirth, ')
          ..write('yearDeath: $yearDeath, ')
          ..write('biography: $biography, ')
          ..write('fileName: $fileName')
          ..write(')'))
        .toString();
  }
}

class $PaintersTable extends Painters with TableInfo<$PaintersTable, Painter> {
  final GeneratedDatabase _db;
  final String _alias;
  $PaintersTable(this._db, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _yearBirthMeta = const VerificationMeta('yearBirth');
  GeneratedTextColumn _yearBirth;
  @override
  GeneratedTextColumn get yearBirth => _yearBirth ??= _constructYearBirth();
  GeneratedTextColumn _constructYearBirth() {
    return GeneratedTextColumn(
      'year_birth',
      $tableName,
      true,
    );
  }

  final VerificationMeta _yearDeathMeta = const VerificationMeta('yearDeath');
  GeneratedTextColumn _yearDeath;
  @override
  GeneratedTextColumn get yearDeath => _yearDeath ??= _constructYearDeath();
  GeneratedTextColumn _constructYearDeath() {
    return GeneratedTextColumn(
      'year_death',
      $tableName,
      true,
    );
  }

  final VerificationMeta _biographyMeta = const VerificationMeta('biography');
  GeneratedTextColumn _biography;
  @override
  GeneratedTextColumn get biography => _biography ??= _constructBiography();
  GeneratedTextColumn _constructBiography() {
    return GeneratedTextColumn(
      'biography',
      $tableName,
      true,
    );
  }

  final VerificationMeta _fileNameMeta = const VerificationMeta('fileName');
  GeneratedTextColumn _fileName;
  @override
  GeneratedTextColumn get fileName => _fileName ??= _constructFileName();
  GeneratedTextColumn _constructFileName() {
    return GeneratedTextColumn(
      'file_name',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [name, yearBirth, yearDeath, biography, fileName];
  @override
  $PaintersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'painters';
  @override
  final String actualTableName = 'painters';
  @override
  VerificationContext validateIntegrity(Insertable<Painter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('year_birth')) {
      context.handle(_yearBirthMeta,
          yearBirth.isAcceptableOrUnknown(data['year_birth'], _yearBirthMeta));
    }
    if (data.containsKey('year_death')) {
      context.handle(_yearDeathMeta,
          yearDeath.isAcceptableOrUnknown(data['year_death'], _yearDeathMeta));
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography'], _biographyMeta));
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name'], _fileNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Painter map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Painter.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PaintersTable createAlias(String alias) {
    return $PaintersTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PaintingsTable _paintings;
  $PaintingsTable get paintings => _paintings ??= $PaintingsTable(this);
  $PaintersTable _painters;
  $PaintersTable get painters => _painters ??= $PaintersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [paintings, painters];
}
