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
        $customConstraints: 'NULL REFERENCES artists(name)');
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
  final String artworkId;
  final String languageCode;
  final String name;
  final String description;
  ArtworkTranslation(
      {@required this.artworkId,
      @required this.languageCode,
      @required this.name,
      this.description});
  factory ArtworkTranslation.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ArtworkTranslation(
      artworkId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork_id']),
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
    if (!nullToAbsent || artworkId != null) {
      map['artwork_id'] = Variable<String>(artworkId);
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
      artworkId: artworkId == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkId),
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
      artworkId: serializer.fromJson<String>(json['artworkId']),
      languageCode: serializer.fromJson<String>(json['languagecode']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artworkId': serializer.toJson<String>(artworkId),
      'languagecode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  ArtworkTranslation copyWith(
          {String artworkId,
          String languageCode,
          String name,
          String description}) =>
      ArtworkTranslation(
        artworkId: artworkId ?? this.artworkId,
        languageCode: languageCode ?? this.languageCode,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('ArtworkTranslation(')
          ..write('artworkId: $artworkId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      artworkId.hashCode,
      $mrjc(
          languageCode.hashCode, $mrjc(name.hashCode, description.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ArtworkTranslation &&
          other.artworkId == this.artworkId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.description == this.description);
}

class ArtworkTranslationsCompanion extends UpdateCompanion<ArtworkTranslation> {
  final Value<String> artworkId;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String> description;
  const ArtworkTranslationsCompanion({
    this.artworkId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  ArtworkTranslationsCompanion.insert({
    @required String artworkId,
    @required String languageCode,
    @required String name,
    this.description = const Value.absent(),
  })  : artworkId = Value(artworkId),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtworkTranslation> custom({
    Expression<String> artworkId,
    Expression<String> languageCode,
    Expression<String> name,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (artworkId != null) 'artwork_id': artworkId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  ArtworkTranslationsCompanion copyWith(
      {Value<String> artworkId,
      Value<String> languageCode,
      Value<String> name,
      Value<String> description}) {
    return ArtworkTranslationsCompanion(
      artworkId: artworkId ?? this.artworkId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (artworkId.present) {
      map['artwork_id'] = Variable<String>(artworkId.value);
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
          ..write('artworkId: $artworkId, ')
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
  final VerificationMeta _artworkIdMeta = const VerificationMeta('artworkId');
  GeneratedTextColumn _artworkId;
  @override
  GeneratedTextColumn get artworkId => _artworkId ??= _constructArtworkId();
  GeneratedTextColumn _constructArtworkId() {
    return GeneratedTextColumn('artwork_id', $tableName, false,
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
  List<GeneratedColumn> get $columns =>
      [artworkId, languageCode, name, description];
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
    if (data.containsKey('artwork_id')) {
      context.handle(_artworkIdMeta,
          artworkId.isAcceptableOrUnknown(data['artwork_id'], _artworkIdMeta));
    } else if (isInserting) {
      context.missing(_artworkIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {artworkId, languageCode};
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
  final String artistId;
  final String languageCode;
  final String name;
  final String biography;
  ArtistTranslation(
      {@required this.artistId,
      @required this.languageCode,
      @required this.name,
      this.biography});
  factory ArtistTranslation.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ArtistTranslation(
      artistId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_id']),
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
    if (!nullToAbsent || artistId != null) {
      map['artist_id'] = Variable<String>(artistId);
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
      artistId: artistId == null && nullToAbsent
          ? const Value.absent()
          : Value(artistId),
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
      artistId: serializer.fromJson<String>(json['artistId']),
      languageCode: serializer.fromJson<String>(json['languagecode']),
      name: serializer.fromJson<String>(json['name']),
      biography: serializer.fromJson<String>(json['biography']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artistId': serializer.toJson<String>(artistId),
      'languagecode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'biography': serializer.toJson<String>(biography),
    };
  }

  ArtistTranslation copyWith(
          {String artistId,
          String languageCode,
          String name,
          String biography}) =>
      ArtistTranslation(
        artistId: artistId ?? this.artistId,
        languageCode: languageCode ?? this.languageCode,
        name: name ?? this.name,
        biography: biography ?? this.biography,
      );
  @override
  String toString() {
    return (StringBuffer('ArtistTranslation(')
          ..write('artistId: $artistId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(artistId.hashCode,
      $mrjc(languageCode.hashCode, $mrjc(name.hashCode, biography.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ArtistTranslation &&
          other.artistId == this.artistId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.biography == this.biography);
}

class ArtistTranslationsCompanion extends UpdateCompanion<ArtistTranslation> {
  final Value<String> artistId;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String> biography;
  const ArtistTranslationsCompanion({
    this.artistId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  });
  ArtistTranslationsCompanion.insert({
    @required String artistId,
    @required String languageCode,
    @required String name,
    this.biography = const Value.absent(),
  })  : artistId = Value(artistId),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtistTranslation> custom({
    Expression<String> artistId,
    Expression<String> languageCode,
    Expression<String> name,
    Expression<String> biography,
  }) {
    return RawValuesInsertable({
      if (artistId != null) 'artist_id': artistId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (biography != null) 'biography': biography,
    });
  }

  ArtistTranslationsCompanion copyWith(
      {Value<String> artistId,
      Value<String> languageCode,
      Value<String> name,
      Value<String> biography}) {
    return ArtistTranslationsCompanion(
      artistId: artistId ?? this.artistId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      biography: biography ?? this.biography,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
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
          ..write('artistId: $artistId, ')
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
  final VerificationMeta _artistIdMeta = const VerificationMeta('artistId');
  GeneratedTextColumn _artistId;
  @override
  GeneratedTextColumn get artistId => _artistId ??= _constructArtistId();
  GeneratedTextColumn _constructArtistId() {
    return GeneratedTextColumn('artist_id', $tableName, false,
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
  List<GeneratedColumn> get $columns =>
      [artistId, languageCode, name, biography];
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
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id'], _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {artistId, languageCode};
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
  ArtworksDao _artworksDao;
  ArtworksDao get artworksDao =>
      _artworksDao ??= ArtworksDao(this as AppDatabase);
  ArtistsDao _artistsDao;
  ArtistsDao get artistsDao => _artistsDao ??= ArtistsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artworks, artworkTranslations, artists, artistTranslations];
}
