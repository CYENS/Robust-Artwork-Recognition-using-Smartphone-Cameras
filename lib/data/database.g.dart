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

class Art extends DataClass implements Insertable<Art> {
  final int artId;
  final String yearBirth;
  final String yearDeath;
  final String photo;
  Art({@required this.artId, this.yearBirth, this.yearDeath, this.photo});
  factory Art.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Art(
      artId: intType.mapFromDatabaseResponse(data['${effectivePrefix}art_id']),
      yearBirth: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}year_birth']),
      yearDeath: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}year_death']),
      photo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}photo']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || artId != null) {
      map['art_id'] = Variable<int>(artId);
    }
    if (!nullToAbsent || yearBirth != null) {
      map['year_birth'] = Variable<String>(yearBirth);
    }
    if (!nullToAbsent || yearDeath != null) {
      map['year_death'] = Variable<String>(yearDeath);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    return map;
  }

  ArtsCompanion toCompanion(bool nullToAbsent) {
    return ArtsCompanion(
      artId:
          artId == null && nullToAbsent ? const Value.absent() : Value(artId),
      yearBirth: yearBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(yearBirth),
      yearDeath: yearDeath == null && nullToAbsent
          ? const Value.absent()
          : Value(yearDeath),
      photo:
          photo == null && nullToAbsent ? const Value.absent() : Value(photo),
    );
  }

  factory Art.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Art(
      artId: serializer.fromJson<int>(json['artId']),
      yearBirth: serializer.fromJson<String>(json['yearbirth']),
      yearDeath: serializer.fromJson<String>(json['yeardeath']),
      photo: serializer.fromJson<String>(json['photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artId': serializer.toJson<int>(artId),
      'yearbirth': serializer.toJson<String>(yearBirth),
      'yeardeath': serializer.toJson<String>(yearDeath),
      'photo': serializer.toJson<String>(photo),
    };
  }

  Art copyWith({int artId, String yearBirth, String yearDeath, String photo}) =>
      Art(
        artId: artId ?? this.artId,
        yearBirth: yearBirth ?? this.yearBirth,
        yearDeath: yearDeath ?? this.yearDeath,
        photo: photo ?? this.photo,
      );
  @override
  String toString() {
    return (StringBuffer('Art(')
          ..write('artId: $artId, ')
          ..write('yearBirth: $yearBirth, ')
          ..write('yearDeath: $yearDeath, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(artId.hashCode,
      $mrjc(yearBirth.hashCode, $mrjc(yearDeath.hashCode, photo.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Art &&
          other.artId == this.artId &&
          other.yearBirth == this.yearBirth &&
          other.yearDeath == this.yearDeath &&
          other.photo == this.photo);
}

class ArtsCompanion extends UpdateCompanion<Art> {
  final Value<int> artId;
  final Value<String> yearBirth;
  final Value<String> yearDeath;
  final Value<String> photo;
  const ArtsCompanion({
    this.artId = const Value.absent(),
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.photo = const Value.absent(),
  });
  ArtsCompanion.insert({
    this.artId = const Value.absent(),
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.photo = const Value.absent(),
  });
  static Insertable<Art> custom({
    Expression<int> artId,
    Expression<String> yearBirth,
    Expression<String> yearDeath,
    Expression<String> photo,
  }) {
    return RawValuesInsertable({
      if (artId != null) 'art_id': artId,
      if (yearBirth != null) 'year_birth': yearBirth,
      if (yearDeath != null) 'year_death': yearDeath,
      if (photo != null) 'photo': photo,
    });
  }

  ArtsCompanion copyWith(
      {Value<int> artId,
      Value<String> yearBirth,
      Value<String> yearDeath,
      Value<String> photo}) {
    return ArtsCompanion(
      artId: artId ?? this.artId,
      yearBirth: yearBirth ?? this.yearBirth,
      yearDeath: yearDeath ?? this.yearDeath,
      photo: photo ?? this.photo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (artId.present) {
      map['art_id'] = Variable<int>(artId.value);
    }
    if (yearBirth.present) {
      map['year_birth'] = Variable<String>(yearBirth.value);
    }
    if (yearDeath.present) {
      map['year_death'] = Variable<String>(yearDeath.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtsCompanion(')
          ..write('artId: $artId, ')
          ..write('yearBirth: $yearBirth, ')
          ..write('yearDeath: $yearDeath, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }
}

class $ArtsTable extends Arts with TableInfo<$ArtsTable, Art> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtsTable(this._db, [this._alias]);
  final VerificationMeta _artIdMeta = const VerificationMeta('artId');
  GeneratedIntColumn _artId;
  @override
  GeneratedIntColumn get artId => _artId ??= _constructArtId();
  GeneratedIntColumn _constructArtId() {
    return GeneratedIntColumn('art_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
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

  final VerificationMeta _photoMeta = const VerificationMeta('photo');
  GeneratedTextColumn _photo;
  @override
  GeneratedTextColumn get photo => _photo ??= _constructPhoto();
  GeneratedTextColumn _constructPhoto() {
    return GeneratedTextColumn(
      'photo',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [artId, yearBirth, yearDeath, photo];
  @override
  $ArtsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'arts';
  @override
  final String actualTableName = 'arts';
  @override
  VerificationContext validateIntegrity(Insertable<Art> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('art_id')) {
      context.handle(
          _artIdMeta, artId.isAcceptableOrUnknown(data['art_id'], _artIdMeta));
    }
    if (data.containsKey('year_birth')) {
      context.handle(_yearBirthMeta,
          yearBirth.isAcceptableOrUnknown(data['year_birth'], _yearBirthMeta));
    }
    if (data.containsKey('year_death')) {
      context.handle(_yearDeathMeta,
          yearDeath.isAcceptableOrUnknown(data['year_death'], _yearDeathMeta));
    }
    if (data.containsKey('photo')) {
      context.handle(
          _photoMeta, photo.isAcceptableOrUnknown(data['photo'], _photoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {artId};
  @override
  Art map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Art.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtsTable createAlias(String alias) {
    return $ArtsTable(_db, alias);
  }
}

class ArtI18n extends DataClass implements Insertable<ArtI18n> {
  final int artId;
  final String languageCode;
  final String name;
  final String biography;
  ArtI18n(
      {@required this.artId,
      @required this.languageCode,
      @required this.name,
      this.biography});
  factory ArtI18n.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ArtI18n(
      artId: intType.mapFromDatabaseResponse(data['${effectivePrefix}art_id']),
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
    if (!nullToAbsent || artId != null) {
      map['art_id'] = Variable<int>(artId);
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

  ArtI18nsCompanion toCompanion(bool nullToAbsent) {
    return ArtI18nsCompanion(
      artId:
          artId == null && nullToAbsent ? const Value.absent() : Value(artId),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
    );
  }

  factory ArtI18n.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArtI18n(
      artId: serializer.fromJson<int>(json['artId']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      biography: serializer.fromJson<String>(json['biography']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artId': serializer.toJson<int>(artId),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'biography': serializer.toJson<String>(biography),
    };
  }

  ArtI18n copyWith(
          {int artId, String languageCode, String name, String biography}) =>
      ArtI18n(
        artId: artId ?? this.artId,
        languageCode: languageCode ?? this.languageCode,
        name: name ?? this.name,
        biography: biography ?? this.biography,
      );
  @override
  String toString() {
    return (StringBuffer('ArtI18n(')
          ..write('artId: $artId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(artId.hashCode,
      $mrjc(languageCode.hashCode, $mrjc(name.hashCode, biography.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ArtI18n &&
          other.artId == this.artId &&
          other.languageCode == this.languageCode &&
          other.name == this.name &&
          other.biography == this.biography);
}

class ArtI18nsCompanion extends UpdateCompanion<ArtI18n> {
  final Value<int> artId;
  final Value<String> languageCode;
  final Value<String> name;
  final Value<String> biography;
  const ArtI18nsCompanion({
    this.artId = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  });
  ArtI18nsCompanion.insert({
    @required int artId,
    @required String languageCode,
    @required String name,
    this.biography = const Value.absent(),
  })  : artId = Value(artId),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtI18n> custom({
    Expression<int> artId,
    Expression<String> languageCode,
    Expression<String> name,
    Expression<String> biography,
  }) {
    return RawValuesInsertable({
      if (artId != null) 'art_id': artId,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (biography != null) 'biography': biography,
    });
  }

  ArtI18nsCompanion copyWith(
      {Value<int> artId,
      Value<String> languageCode,
      Value<String> name,
      Value<String> biography}) {
    return ArtI18nsCompanion(
      artId: artId ?? this.artId,
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      biography: biography ?? this.biography,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (artId.present) {
      map['art_id'] = Variable<int>(artId.value);
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
    return (StringBuffer('ArtI18nsCompanion(')
          ..write('artId: $artId, ')
          ..write('languageCode: $languageCode, ')
          ..write('name: $name, ')
          ..write('biography: $biography')
          ..write(')'))
        .toString();
  }
}

class $ArtI18nsTable extends ArtI18ns with TableInfo<$ArtI18nsTable, ArtI18n> {
  final GeneratedDatabase _db;
  final String _alias;
  $ArtI18nsTable(this._db, [this._alias]);
  final VerificationMeta _artIdMeta = const VerificationMeta('artId');
  GeneratedIntColumn _artId;
  @override
  GeneratedIntColumn get artId => _artId ??= _constructArtId();
  GeneratedIntColumn _constructArtId() {
    return GeneratedIntColumn('art_id', $tableName, false,
        $customConstraints: 'NULL REFERENCES arts(art_id)');
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
  List<GeneratedColumn> get $columns => [artId, languageCode, name, biography];
  @override
  $ArtI18nsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'art_i18ns';
  @override
  final String actualTableName = 'art_i18ns';
  @override
  VerificationContext validateIntegrity(Insertable<ArtI18n> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('art_id')) {
      context.handle(
          _artIdMeta, artId.isAcceptableOrUnknown(data['art_id'], _artIdMeta));
    } else if (isInserting) {
      context.missing(_artIdMeta);
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
  Set<GeneratedColumn> get $primaryKey => {artId, languageCode};
  @override
  ArtI18n map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ArtI18n.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ArtI18nsTable createAlias(String alias) {
    return $ArtI18nsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ArtworksTable _artworks;
  $ArtworksTable get artworks => _artworks ??= $ArtworksTable(this);
  $ArtistsTable _artists;
  $ArtistsTable get artists => _artists ??= $ArtistsTable(this);
  $ArtsTable _arts;
  $ArtsTable get arts => _arts ??= $ArtsTable(this);
  $ArtI18nsTable _artI18ns;
  $ArtI18nsTable get artI18ns => _artI18ns ??= $ArtI18nsTable(this);
  ArtworksDao _artworksDao;
  ArtworksDao get artworksDao =>
      _artworksDao ??= ArtworksDao(this as AppDatabase);
  ArtistsDao _artistsDao;
  ArtistsDao get artistsDao => _artistsDao ??= ArtistsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artworks, artists, arts, artI18ns];
}
