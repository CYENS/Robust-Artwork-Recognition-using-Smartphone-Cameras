// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Artwork extends DataClass implements Insertable<Artwork> {
  final String id;
  final String artistId;
  final String year;
  final String name;
  final String description;
  final String artist;
  Artwork(
      {@required this.id,
      @required this.artistId,
      this.year,
      this.name,
      this.description,
      this.artist});
  factory Artwork.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Artwork(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      artistId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_id']),
      year: stringType.mapFromDatabaseResponse(data['${effectivePrefix}year']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      artist:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}artist']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || artistId != null) {
      map['artist_id'] = Variable<String>(artistId);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<String>(year);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    return map;
  }

  ArtworksCompanion toCompanion(bool nullToAbsent) {
    return ArtworksCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      artistId: artistId == null && nullToAbsent
          ? const Value.absent()
          : Value(artistId),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      artist:
          artist == null && nullToAbsent ? const Value.absent() : Value(artist),
    );
  }

  factory Artwork.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Artwork(
      id: serializer.fromJson<String>(json['id']),
      artistId: serializer.fromJson<String>(json['artistid']),
      year: serializer.fromJson<String>(json['year']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      artist: serializer.fromJson<String>(json['artist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'artistid': serializer.toJson<String>(artistId),
      'year': serializer.toJson<String>(year),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'artist': serializer.toJson<String>(artist),
    };
  }

  Artwork copyWith(
          {String id,
          String artistId,
          String year,
          String name,
          String description,
          String artist}) =>
      Artwork(
        id: id ?? this.id,
        artistId: artistId ?? this.artistId,
        year: year ?? this.year,
        name: name ?? this.name,
        description: description ?? this.description,
        artist: artist ?? this.artist,
      );
  @override
  String toString() {
    return (StringBuffer('Artwork(')
          ..write('id: $id, ')
          ..write('artistId: $artistId, ')
          ..write('year: $year, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('artist: $artist')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          artistId.hashCode,
          $mrjc(
              year.hashCode,
              $mrjc(name.hashCode,
                  $mrjc(description.hashCode, artist.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Artwork &&
          other.id == this.id &&
          other.artistId == this.artistId &&
          other.year == this.year &&
          other.name == this.name &&
          other.description == this.description &&
          other.artist == this.artist);
}

class ArtworksCompanion extends UpdateCompanion<Artwork> {
  final Value<String> id;
  final Value<String> artistId;
  final Value<String> year;
  final Value<String> name;
  final Value<String> description;
  final Value<String> artist;
  const ArtworksCompanion({
    this.id = const Value.absent(),
    this.artistId = const Value.absent(),
    this.year = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.artist = const Value.absent(),
  });
  ArtworksCompanion.insert({
    @required String id,
    @required String artistId,
    this.year = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.artist = const Value.absent(),
  })  : id = Value(id),
        artistId = Value(artistId);
  static Insertable<Artwork> custom({
    Expression<String> id,
    Expression<String> artistId,
    Expression<String> year,
    Expression<String> name,
    Expression<String> description,
    Expression<String> artist,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (artistId != null) 'artist_id': artistId,
      if (year != null) 'year': year,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (artist != null) 'artist': artist,
    });
  }

  ArtworksCompanion copyWith(
      {Value<String> id,
      Value<String> artistId,
      Value<String> year,
      Value<String> name,
      Value<String> description,
      Value<String> artist}) {
    return ArtworksCompanion(
      id: id ?? this.id,
      artistId: artistId ?? this.artistId,
      year: year ?? this.year,
      name: name ?? this.name,
      description: description ?? this.description,
      artist: artist ?? this.artist,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtworksCompanion(')
          ..write('id: $id, ')
          ..write('artistId: $artistId, ')
          ..write('year: $year, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('artist: $artist')
          ..write(')'))
        .toString();
  }
}

class $ArtworksTable extends Artworks with TableInfo<$ArtworksTable, Artwork> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtworksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _artistIdMeta = const VerificationMeta('artistId');
  GeneratedTextColumn _artistId;
  @override
  GeneratedTextColumn get artistId => _artistId ??= _constructArtistId();
  GeneratedTextColumn _constructArtistId() {
    return GeneratedTextColumn('artist_id', $tableName, false,
        $customConstraints: 'NULL REFERENCES artists(id)');
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

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
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
    return GeneratedTextColumn(
      'artist',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, artistId, year, name, description, artist];
  @override
  $ArtworksTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'artworks';
  @override
  final String actualTableName = 'artworks';
  @override
  VerificationContext validateIntegrity(Insertable<Artwork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id'], _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year'], _yearMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Artwork map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Artwork.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtworksTable createAlias(String alias) {
    return $ArtworksTable(_db, alias);
  }
}

class ArtworkTranslation extends DataClass
    implements Insertable<ArtworkTranslation> {
  final String id;
  final String languageCode;
  final String name;
  final String description;
  ArtworkTranslation(
      {@required this.id,
      @required this.languageCode,
      @required this.name,
      this.description});
  factory ArtworkTranslation.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ArtworkTranslation(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      languageCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language_code']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || languageCode != null) {
      map['language_code'] = Variable<String>(languageCode);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ArtworkTranslationsCompanion toCompanion(bool nullToAbsent) {
    return ArtworkTranslationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory ArtworkTranslation.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArtworkTranslation(
      id: serializer.fromJson<String>(json['id']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  ArtworkTranslation copyWith(
          {String id, String languageCode, String name, String description}) =>
      ArtworkTranslation(
        id: id ?? this.id,
        languageCode: languageCode ?? this.languageCode,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('ArtworkTranslation(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          languageCode.hashCode, $mrjc(name.hashCode, description.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ArtworkTranslation &&
          other.id == this.id &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.description == this.description);
}

class ArtworkTranslationsCompanion extends UpdateCompanion<ArtworkTranslation> {
  final Value<String> id;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String> description;
  const ArtworkTranslationsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  ArtworkTranslationsCompanion.insert({
    @required String id,
    @required String languageCode,
    @required String name,
    this.description = const Value.absent(),
  })  : id = Value(id),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtworkTranslation> custom({
    Expression<String> id,
    Expression<String> languageCode,
    Expression<String> name,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  ArtworkTranslationsCompanion copyWith(
      {Value<String> id,
      Value<String> languageCode,
      Value<String> name,
      Value<String> description}) {
    return ArtworkTranslationsCompanion(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtworkTranslationsCompanion(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $ArtworkTranslationsTable extends ArtworkTranslations
    with TableInfo<$ArtworkTranslationsTable, ArtworkTranslation> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtworkTranslationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'NULL REFERENCES artworks(id)');
  }

  final VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  GeneratedTextColumn _languageCode;
  @override
  GeneratedTextColumn get languageCode =>
      _languageCode ??= _constructLanguageCode();
  GeneratedTextColumn _constructLanguageCode() {
    return GeneratedTextColumn(
      'language_code',
      $tableName,
      false,
    );
  }

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

  @override
  List<GeneratedColumn> get $columns => [id, languageCode, name, description];
  @override
  $ArtworkTranslationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'artwork_translations';
  @override
  final String actualTableName = 'artwork_translations';
  @override
  VerificationContext validateIntegrity(Insertable<ArtworkTranslation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code'], _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, languageCode};
  @override
  ArtworkTranslation map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ArtworkTranslation.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtworkTranslationsTable createAlias(String alias) {
    return $ArtworkTranslationsTable(_db, alias);
  }
}

class Artist extends DataClass implements Insertable<Artist> {
  final String id;
  final String yearBirth;
  final String yearDeath;
  final String name;
  final String biography;
  Artist(
      {@required this.id,
      this.yearBirth,
      this.yearDeath,
      this.name,
      this.biography});
  factory Artist.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Artist(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      yearBirth: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}year_birth']),
      yearDeath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}year_death']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      biography: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}biography']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || yearBirth != null) {
      map['year_birth'] = Variable<String>(yearBirth);
    }
    if (!nullToAbsent || yearDeath != null) {
      map['year_death'] = Variable<String>(yearDeath);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String>(biography);
    }
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      yearBirth: yearBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(yearBirth),
      yearDeath: yearDeath == null && nullToAbsent
          ? const Value.absent()
          : Value(yearDeath),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
    );
  }

  factory Artist.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Artist(
      id: serializer.fromJson<String>(json['id']),
      yearBirth: serializer.fromJson<String>(json['yearbirth']),
      yearDeath: serializer.fromJson<String>(json['yeardeath']),
      name: serializer.fromJson<String>(json['name']),
      biography: serializer.fromJson<String>(json['biography']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'yearbirth': serializer.toJson<String>(yearBirth),
      'yeardeath': serializer.toJson<String>(yearDeath),
      'name': serializer.toJson<String>(name),
      'biography': serializer.toJson<String>(biography),
    };
  }

  Artist copyWith(
          {String id,
          String yearBirth,
          String yearDeath,
          String name,
          String biography}) =>
      Artist(
        id: id ?? this.id,
        yearBirth: yearBirth ?? this.yearBirth,
        yearDeath: yearDeath ?? this.yearDeath,
        name: name ?? this.name,
        biography: biography ?? this.biography,
      );
  @override
  String toString() {
    return (StringBuffer('Artist(')
          ..write('id: $id, ')
          ..write('yearBirth: $yearBirth, ')
          ..write('yearDeath: $yearDeath, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          yearBirth.hashCode,
          $mrjc(
              yearDeath.hashCode, $mrjc(name.hashCode, biography.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Artist &&
          other.id == this.id &&
          other.yearBirth == this.yearBirth &&
          other.yearDeath == this.yearDeath &&
          other.name == this.name &&
          other.biography == this.biography);
}

class ArtistsCompanion extends UpdateCompanion<Artist> {
  final Value<String> id;
  final Value<String> yearBirth;
  final Value<String> yearDeath;
  final Value<String> name;
  final Value<String> biography;
  const ArtistsCompanion({
    this.id = const Value.absent(),
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  });
  ArtistsCompanion.insert({
    @required String id,
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Artist> custom({
    Expression<String> id,
    Expression<String> yearBirth,
    Expression<String> yearDeath,
    Expression<String> name,
    Expression<String> biography,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (yearBirth != null) 'year_birth': yearBirth,
      if (yearDeath != null) 'year_death': yearDeath,
      if (name != null) 'name': name,
      if (biography != null) 'biography': biography,
    });
  }

  ArtistsCompanion copyWith(
      {Value<String> id,
      Value<String> yearBirth,
      Value<String> yearDeath,
      Value<String> name,
      Value<String> biography}) {
    return ArtistsCompanion(
      id: id ?? this.id,
      yearBirth: yearBirth ?? this.yearBirth,
      yearDeath: yearDeath ?? this.yearDeath,
      name: name ?? this.name,
      biography: biography ?? this.biography,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (yearBirth.present) {
      map['year_birth'] = Variable<String>(yearBirth.value);
    }
    if (yearDeath.present) {
      map['year_death'] = Variable<String>(yearDeath.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String>(biography.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistsCompanion(')
          ..write('id: $id, ')
          ..write('yearBirth: $yearBirth, ')
          ..write('yearDeath: $yearDeath, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }
}

class $ArtistsTable extends Artists with TableInfo<$ArtistsTable, Artist> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtistsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
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

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
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

  @override
  List<GeneratedColumn> get $columns =>
      [id, yearBirth, yearDeath, name, biography];
  @override
  $ArtistsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'artists';
  @override
  final String actualTableName = 'artists';
  @override
  VerificationContext validateIntegrity(Insertable<Artist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('year_birth')) {
      context.handle(_yearBirthMeta,
          yearBirth.isAcceptableOrUnknown(data['year_birth'], _yearBirthMeta));
    }
    if (data.containsKey('year_death')) {
      context.handle(_yearDeathMeta,
          yearDeath.isAcceptableOrUnknown(data['year_death'], _yearDeathMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography'], _biographyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Artist map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Artist.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtistsTable createAlias(String alias) {
    return $ArtistsTable(_db, alias);
  }
}

class ArtistTranslation extends DataClass
    implements Insertable<ArtistTranslation> {
  final String id;
  final String languageCode;
  final String name;
  final String biography;
  ArtistTranslation(
      {@required this.id,
      @required this.languageCode,
      @required this.name,
      this.biography});
  factory ArtistTranslation.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ArtistTranslation(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      languageCode: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language_code']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      biography: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}biography']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || languageCode != null) {
      map['language_code'] = Variable<String>(languageCode);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String>(biography);
    }
    return map;
  }

  ArtistTranslationsCompanion toCompanion(bool nullToAbsent) {
    return ArtistTranslationsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
    );
  }

  factory ArtistTranslation.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArtistTranslation(
      id: serializer.fromJson<String>(json['id']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      biography: serializer.fromJson<String>(json['biography']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'biography': serializer.toJson<String>(biography),
    };
  }

  ArtistTranslation copyWith(
          {String id, String languageCode, String name, String biography}) =>
      ArtistTranslation(
        id: id ?? this.id,
        languageCode: languageCode ?? this.languageCode,
        name: name ?? this.name,
        biography: biography ?? this.biography,
      );
  @override
  String toString() {
    return (StringBuffer('ArtistTranslation(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(languageCode.hashCode, $mrjc(name.hashCode, biography.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ArtistTranslation &&
          other.id == this.id &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.biography == this.biography);
}

class ArtistTranslationsCompanion extends UpdateCompanion<ArtistTranslation> {
  final Value<String> id;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String> biography;
  const ArtistTranslationsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  });
  ArtistTranslationsCompanion.insert({
    @required String id,
    @required String languageCode,
    @required String name,
    this.biography = const Value.absent(),
  })  : id = Value(id),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtistTranslation> custom({
    Expression<String> id,
    Expression<String> languageCode,
    Expression<String> name,
    Expression<String> biography,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (biography != null) 'biography': biography,
    });
  }

  ArtistTranslationsCompanion copyWith(
      {Value<String> id,
      Value<String> languageCode,
      Value<String> name,
      Value<String> biography}) {
    return ArtistTranslationsCompanion(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      biography: biography ?? this.biography,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String>(biography.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistTranslationsCompanion(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }
}

class $ArtistTranslationsTable extends ArtistTranslations
    with TableInfo<$ArtistTranslationsTable, ArtistTranslation> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtistTranslationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false,
        $customConstraints: 'NULL REFERENCES artists(id)');
  }

  final VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  GeneratedTextColumn _languageCode;
  @override
  GeneratedTextColumn get languageCode =>
      _languageCode ??= _constructLanguageCode();
  GeneratedTextColumn _constructLanguageCode() {
    return GeneratedTextColumn(
      'language_code',
      $tableName,
      false,
    );
  }

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

  @override
  List<GeneratedColumn> get $columns => [id, languageCode, name, biography];
  @override
  $ArtistTranslationsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'artist_translations';
  @override
  final String actualTableName = 'artist_translations';
  @override
  VerificationContext validateIntegrity(Insertable<ArtistTranslation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code'], _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography'], _biographyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, languageCode};
  @override
  ArtistTranslation map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ArtistTranslation.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtistTranslationsTable createAlias(String alias) {
    return $ArtistTranslationsTable(_db, alias);
  }
}

class Viewing extends DataClass implements Insertable<Viewing> {
  final int id;
  final String artworkId;
  final String artworkScore;
  final String cnnModelUsed;
  final String algorithmUsed;
  final double sensitivity;
  final int threshold;
  final DateTime startTime;
  final DateTime endTime;
  final int totalTime;
  Viewing(
      {@required this.id,
      @required this.artworkId,
      this.artworkScore,
      this.cnnModelUsed,
      this.algorithmUsed,
      this.sensitivity,
      this.threshold,
      @required this.startTime,
      @required this.endTime,
      @required this.totalTime});
  factory Viewing.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final doubleType = db.typeSystem.forDartType<double>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Viewing(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      artworkId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork_id']),
      artworkScore: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork_score']),
      cnnModelUsed: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}cnn_model_used']),
      algorithmUsed: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}algorithm_used']),
      sensitivity: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}sensitivity']),
      threshold:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}threshold']),
      startTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_time']),
      endTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_time']),
      totalTime:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}total_time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || artworkId != null) {
      map['artwork_id'] = Variable<String>(artworkId);
    }
    if (!nullToAbsent || artworkScore != null) {
      map['artwork_score'] = Variable<String>(artworkScore);
    }
    if (!nullToAbsent || cnnModelUsed != null) {
      map['cnn_model_used'] = Variable<String>(cnnModelUsed);
    }
    if (!nullToAbsent || algorithmUsed != null) {
      map['algorithm_used'] = Variable<String>(algorithmUsed);
    }
    if (!nullToAbsent || sensitivity != null) {
      map['sensitivity'] = Variable<double>(sensitivity);
    }
    if (!nullToAbsent || threshold != null) {
      map['threshold'] = Variable<int>(threshold);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || totalTime != null) {
      map['total_time'] = Variable<int>(totalTime);
    }
    return map;
  }

  ViewingsCompanion toCompanion(bool nullToAbsent) {
    return ViewingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      artworkId: artworkId == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkId),
      artworkScore: artworkScore == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkScore),
      cnnModelUsed: cnnModelUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(cnnModelUsed),
      algorithmUsed: algorithmUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(algorithmUsed),
      sensitivity: sensitivity == null && nullToAbsent
          ? const Value.absent()
          : Value(sensitivity),
      threshold: threshold == null && nullToAbsent
          ? const Value.absent()
          : Value(threshold),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      totalTime: totalTime == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTime),
    );
  }

  factory Viewing.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Viewing(
      id: serializer.fromJson<int>(json['id']),
      artworkId: serializer.fromJson<String>(json['artworkId']),
      artworkScore: serializer.fromJson<String>(json['artworkScore']),
      cnnModelUsed: serializer.fromJson<String>(json['cnnModelUsed']),
      algorithmUsed: serializer.fromJson<String>(json['algorithmUsed']),
      sensitivity: serializer.fromJson<double>(json['sensitivity']),
      threshold: serializer.fromJson<int>(json['threshold']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      totalTime: serializer.fromJson<int>(json['totalTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'artworkId': serializer.toJson<String>(artworkId),
      'artworkScore': serializer.toJson<String>(artworkScore),
      'cnnModelUsed': serializer.toJson<String>(cnnModelUsed),
      'algorithmUsed': serializer.toJson<String>(algorithmUsed),
      'sensitivity': serializer.toJson<double>(sensitivity),
      'threshold': serializer.toJson<int>(threshold),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'totalTime': serializer.toJson<int>(totalTime),
    };
  }

  Viewing copyWith(
          {int id,
          String artworkId,
          String artworkScore,
          String cnnModelUsed,
          String algorithmUsed,
          double sensitivity,
          int threshold,
          DateTime startTime,
          DateTime endTime,
          int totalTime}) =>
      Viewing(
        id: id ?? this.id,
        artworkId: artworkId ?? this.artworkId,
        artworkScore: artworkScore ?? this.artworkScore,
        cnnModelUsed: cnnModelUsed ?? this.cnnModelUsed,
        algorithmUsed: algorithmUsed ?? this.algorithmUsed,
        sensitivity: sensitivity ?? this.sensitivity,
        threshold: threshold ?? this.threshold,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        totalTime: totalTime ?? this.totalTime,
      );
  @override
  String toString() {
    return (StringBuffer('Viewing(')
          ..write('id: $id, ')
          ..write('artworkId: $artworkId, ')
          ..write('artworkScore: $artworkScore, ')
          ..write('cnnModelUsed: $cnnModelUsed, ')
          ..write('algorithmUsed: $algorithmUsed, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('threshold: $threshold, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('totalTime: $totalTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          artworkId.hashCode,
          $mrjc(
              artworkScore.hashCode,
              $mrjc(
                  cnnModelUsed.hashCode,
                  $mrjc(
                      algorithmUsed.hashCode,
                      $mrjc(
                          sensitivity.hashCode,
                          $mrjc(
                              threshold.hashCode,
                              $mrjc(
                                  startTime.hashCode,
                                  $mrjc(endTime.hashCode,
                                      totalTime.hashCode))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Viewing &&
          other.id == this.id &&
          other.artworkId == this.artworkId &&
          other.artworkScore == this.artworkScore &&
          other.cnnModelUsed == this.cnnModelUsed &&
          other.algorithmUsed == this.algorithmUsed &&
          other.sensitivity == this.sensitivity &&
          other.threshold == this.threshold &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.totalTime == this.totalTime);
}

class ViewingsCompanion extends UpdateCompanion<Viewing> {
  final Value<int> id;
  final Value<String> artworkId;
  final Value<String> artworkScore;
  final Value<String> cnnModelUsed;
  final Value<String> algorithmUsed;
  final Value<double> sensitivity;
  final Value<int> threshold;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> totalTime;
  const ViewingsCompanion({
    this.id = const Value.absent(),
    this.artworkId = const Value.absent(),
    this.artworkScore = const Value.absent(),
    this.cnnModelUsed = const Value.absent(),
    this.algorithmUsed = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.threshold = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.totalTime = const Value.absent(),
  });
  ViewingsCompanion.insert({
    this.id = const Value.absent(),
    @required String artworkId,
    this.artworkScore = const Value.absent(),
    this.cnnModelUsed = const Value.absent(),
    this.algorithmUsed = const Value.absent(),
    this.sensitivity = const Value.absent(),
    this.threshold = const Value.absent(),
    @required DateTime startTime,
    @required DateTime endTime,
    @required int totalTime,
  })  : artworkId = Value(artworkId),
        startTime = Value(startTime),
        endTime = Value(endTime),
        totalTime = Value(totalTime);
  static Insertable<Viewing> custom({
    Expression<int> id,
    Expression<String> artworkId,
    Expression<String> artworkScore,
    Expression<String> cnnModelUsed,
    Expression<String> algorithmUsed,
    Expression<double> sensitivity,
    Expression<int> threshold,
    Expression<DateTime> startTime,
    Expression<DateTime> endTime,
    Expression<int> totalTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (artworkId != null) 'artwork_id': artworkId,
      if (artworkScore != null) 'artwork_score': artworkScore,
      if (cnnModelUsed != null) 'cnn_model_used': cnnModelUsed,
      if (algorithmUsed != null) 'algorithm_used': algorithmUsed,
      if (sensitivity != null) 'sensitivity': sensitivity,
      if (threshold != null) 'threshold': threshold,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (totalTime != null) 'total_time': totalTime,
    });
  }

  ViewingsCompanion copyWith(
      {Value<int> id,
      Value<String> artworkId,
      Value<String> artworkScore,
      Value<String> cnnModelUsed,
      Value<String> algorithmUsed,
      Value<double> sensitivity,
      Value<int> threshold,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<int> totalTime}) {
    return ViewingsCompanion(
      id: id ?? this.id,
      artworkId: artworkId ?? this.artworkId,
      artworkScore: artworkScore ?? this.artworkScore,
      cnnModelUsed: cnnModelUsed ?? this.cnnModelUsed,
      algorithmUsed: algorithmUsed ?? this.algorithmUsed,
      sensitivity: sensitivity ?? this.sensitivity,
      threshold: threshold ?? this.threshold,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalTime: totalTime ?? this.totalTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (artworkId.present) {
      map['artwork_id'] = Variable<String>(artworkId.value);
    }
    if (artworkScore.present) {
      map['artwork_score'] = Variable<String>(artworkScore.value);
    }
    if (cnnModelUsed.present) {
      map['cnn_model_used'] = Variable<String>(cnnModelUsed.value);
    }
    if (algorithmUsed.present) {
      map['algorithm_used'] = Variable<String>(algorithmUsed.value);
    }
    if (sensitivity.present) {
      map['sensitivity'] = Variable<double>(sensitivity.value);
    }
    if (threshold.present) {
      map['threshold'] = Variable<int>(threshold.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (totalTime.present) {
      map['total_time'] = Variable<int>(totalTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewingsCompanion(')
          ..write('id: $id, ')
          ..write('artworkId: $artworkId, ')
          ..write('artworkScore: $artworkScore, ')
          ..write('cnnModelUsed: $cnnModelUsed, ')
          ..write('algorithmUsed: $algorithmUsed, ')
          ..write('sensitivity: $sensitivity, ')
          ..write('threshold: $threshold, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('totalTime: $totalTime')
          ..write(')'))
        .toString();
  }
}

class $ViewingsTable extends Viewings with TableInfo<$ViewingsTable, Viewing> {
  final GeneratedDatabase _db;
  final String _alias;
  $ViewingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _artworkIdMeta = const VerificationMeta('artworkId');
  GeneratedTextColumn _artworkId;
  @override
  GeneratedTextColumn get artworkId => _artworkId ??= _constructArtworkId();
  GeneratedTextColumn _constructArtworkId() {
    return GeneratedTextColumn('artwork_id', $tableName, false,
        $customConstraints: 'NULL REFERENCES artworks(id)');
  }

  final VerificationMeta _artworkScoreMeta =
      const VerificationMeta('artworkScore');
  GeneratedTextColumn _artworkScore;
  @override
  GeneratedTextColumn get artworkScore =>
      _artworkScore ??= _constructArtworkScore();
  GeneratedTextColumn _constructArtworkScore() {
    return GeneratedTextColumn(
      'artwork_score',
      $tableName,
      true,
    );
  }

  final VerificationMeta _cnnModelUsedMeta =
      const VerificationMeta('cnnModelUsed');
  GeneratedTextColumn _cnnModelUsed;
  @override
  GeneratedTextColumn get cnnModelUsed =>
      _cnnModelUsed ??= _constructCnnModelUsed();
  GeneratedTextColumn _constructCnnModelUsed() {
    return GeneratedTextColumn(
      'cnn_model_used',
      $tableName,
      true,
    );
  }

  final VerificationMeta _algorithmUsedMeta =
      const VerificationMeta('algorithmUsed');
  GeneratedTextColumn _algorithmUsed;
  @override
  GeneratedTextColumn get algorithmUsed =>
      _algorithmUsed ??= _constructAlgorithmUsed();
  GeneratedTextColumn _constructAlgorithmUsed() {
    return GeneratedTextColumn(
      'algorithm_used',
      $tableName,
      true,
    );
  }

  final VerificationMeta _sensitivityMeta =
      const VerificationMeta('sensitivity');
  GeneratedRealColumn _sensitivity;
  @override
  GeneratedRealColumn get sensitivity =>
      _sensitivity ??= _constructSensitivity();
  GeneratedRealColumn _constructSensitivity() {
    return GeneratedRealColumn(
      'sensitivity',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thresholdMeta = const VerificationMeta('threshold');
  GeneratedIntColumn _threshold;
  @override
  GeneratedIntColumn get threshold => _threshold ??= _constructThreshold();
  GeneratedIntColumn _constructThreshold() {
    return GeneratedIntColumn(
      'threshold',
      $tableName,
      true,
    );
  }

  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  GeneratedDateTimeColumn _startTime;
  @override
  GeneratedDateTimeColumn get startTime => _startTime ??= _constructStartTime();
  GeneratedDateTimeColumn _constructStartTime() {
    return GeneratedDateTimeColumn(
      'start_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _endTimeMeta = const VerificationMeta('endTime');
  GeneratedDateTimeColumn _endTime;
  @override
  GeneratedDateTimeColumn get endTime => _endTime ??= _constructEndTime();
  GeneratedDateTimeColumn _constructEndTime() {
    return GeneratedDateTimeColumn(
      'end_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _totalTimeMeta = const VerificationMeta('totalTime');
  GeneratedIntColumn _totalTime;
  @override
  GeneratedIntColumn get totalTime => _totalTime ??= _constructTotalTime();
  GeneratedIntColumn _constructTotalTime() {
    return GeneratedIntColumn(
      'total_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        artworkId,
        artworkScore,
        cnnModelUsed,
        algorithmUsed,
        sensitivity,
        threshold,
        startTime,
        endTime,
        totalTime
      ];
  @override
  $ViewingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'viewings';
  @override
  final String actualTableName = 'viewings';
  @override
  VerificationContext validateIntegrity(Insertable<Viewing> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('artwork_id')) {
      context.handle(_artworkIdMeta,
          artworkId.isAcceptableOrUnknown(data['artwork_id'], _artworkIdMeta));
    } else if (isInserting) {
      context.missing(_artworkIdMeta);
    }
    if (data.containsKey('artwork_score')) {
      context.handle(
          _artworkScoreMeta,
          artworkScore.isAcceptableOrUnknown(
              data['artwork_score'], _artworkScoreMeta));
    }
    if (data.containsKey('cnn_model_used')) {
      context.handle(
          _cnnModelUsedMeta,
          cnnModelUsed.isAcceptableOrUnknown(
              data['cnn_model_used'], _cnnModelUsedMeta));
    }
    if (data.containsKey('algorithm_used')) {
      context.handle(
          _algorithmUsedMeta,
          algorithmUsed.isAcceptableOrUnknown(
              data['algorithm_used'], _algorithmUsedMeta));
    }
    if (data.containsKey('sensitivity')) {
      context.handle(
          _sensitivityMeta,
          sensitivity.isAcceptableOrUnknown(
              data['sensitivity'], _sensitivityMeta));
    }
    if (data.containsKey('threshold')) {
      context.handle(_thresholdMeta,
          threshold.isAcceptableOrUnknown(data['threshold'], _thresholdMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time'], _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time'], _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('total_time')) {
      context.handle(_totalTimeMeta,
          totalTime.isAcceptableOrUnknown(data['total_time'], _totalTimeMeta));
    } else if (isInserting) {
      context.missing(_totalTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Viewing map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Viewing.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ViewingsTable createAlias(String alias) {
    return $ViewingsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ArtworksTable _artworks;
  $ArtworksTable get artworks => _artworks ??= $ArtworksTable(this);
  $ArtworkTranslationsTable _artworkTranslations;
  $ArtworkTranslationsTable get artworkTranslations =>
      _artworkTranslations ??= $ArtworkTranslationsTable(this);
  $ArtistsTable _artists;
  $ArtistsTable get artists => _artists ??= $ArtistsTable(this);
  $ArtistTranslationsTable _artistTranslations;
  $ArtistTranslationsTable get artistTranslations =>
      _artistTranslations ??= $ArtistTranslationsTable(this);
  $ViewingsTable _viewings;
  $ViewingsTable get viewings => _viewings ??= $ViewingsTable(this);
  ArtworksDao _artworksDao;
  ArtworksDao get artworksDao =>
      _artworksDao ??= ArtworksDao(this as AppDatabase);
  ArtistsDao _artistsDao;
  ArtistsDao get artistsDao => _artistsDao ??= ArtistsDao(this as AppDatabase);
  ViewingsDao _viewingsDao;
  ViewingsDao get viewingsDao =>
      _viewingsDao ??= ViewingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artworks, artworkTranslations, artists, artistTranslations, viewings];
}
