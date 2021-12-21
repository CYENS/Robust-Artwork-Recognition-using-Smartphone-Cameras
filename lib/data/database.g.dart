// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Artwork extends DataClass implements Insertable<Artwork> {
  final String id;
  final String artistId;
  final String? year;
  final String? name;
  final String? description;
  final String? artist;
  Artwork(
      {required this.id,
      required this.artistId,
      this.year,
      this.name,
      this.description,
      this.artist});
  factory Artwork.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Artwork(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      artistId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist_id'])!,
      year: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      artist: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artist']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['artist_id'] = Variable<String>(artistId);
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<String?>(year);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String?>(artist);
    }
    return map;
  }

  ArtworksCompanion toCompanion(bool nullToAbsent) {
    return ArtworksCompanion(
      id: Value(id),
      artistId: Value(artistId),
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
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Artwork(
      id: serializer.fromJson<String>(json['id']),
      artistId: serializer.fromJson<String>(json['artistid']),
      year: serializer.fromJson<String?>(json['year']),
      name: serializer.fromJson<String?>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      artist: serializer.fromJson<String?>(json['artist']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'artistid': serializer.toJson<String>(artistId),
      'year': serializer.toJson<String?>(year),
      'name': serializer.toJson<String?>(name),
      'description': serializer.toJson<String?>(description),
      'artist': serializer.toJson<String?>(artist),
    };
  }

  Artwork copyWith(
          {String? id,
          String? artistId,
          String? year,
          String? name,
          String? description,
          String? artist}) =>
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
  int get hashCode =>
      Object.hash(id, artistId, year, name, description, artist);
  @override
  bool operator ==(Object other) =>
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
  final Value<String?> year;
  final Value<String?> name;
  final Value<String?> description;
  final Value<String?> artist;
  const ArtworksCompanion({
    this.id = const Value.absent(),
    this.artistId = const Value.absent(),
    this.year = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.artist = const Value.absent(),
  });
  ArtworksCompanion.insert({
    required String id,
    required String artistId,
    this.year = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.artist = const Value.absent(),
  })  : id = Value(id),
        artistId = Value(artistId);
  static Insertable<Artwork> custom({
    Expression<String>? id,
    Expression<String>? artistId,
    Expression<String?>? year,
    Expression<String?>? name,
    Expression<String?>? description,
    Expression<String?>? artist,
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
      {Value<String>? id,
      Value<String>? artistId,
      Value<String?>? year,
      Value<String?>? name,
      Value<String?>? description,
      Value<String?>? artist}) {
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
      map['year'] = Variable<String?>(year.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String?>(artist.value);
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
  final String? _alias;
  $ArtworksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _artistIdMeta = const VerificationMeta('artistId');
  late final GeneratedColumn<String?> artistId = GeneratedColumn<String?>(
      'artist_id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES artists(id)');
  final VerificationMeta _yearMeta = const VerificationMeta('year');
  late final GeneratedColumn<String?> year = GeneratedColumn<String?>(
      'year', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _artistMeta = const VerificationMeta('artist');
  late final GeneratedColumn<String?> artist = GeneratedColumn<String?>(
      'artist', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, artistId, year, name, description, artist];
  @override
  String get aliasedName => _alias ?? 'artworks';
  @override
  String get actualTableName => 'artworks';
  @override
  VerificationContext validateIntegrity(Insertable<Artwork> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Artwork map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Artwork.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
  final String? description;
  ArtworkTranslation(
      {required this.id,
      required this.languageCode,
      required this.name,
      this.description});
  factory ArtworkTranslation.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ArtworkTranslation(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      languageCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language_code'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['language_code'] = Variable<String>(languageCode);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    return map;
  }

  ArtworkTranslationsCompanion toCompanion(bool nullToAbsent) {
    return ArtworkTranslationsCompanion(
      id: Value(id),
      languageCode: Value(languageCode),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory ArtworkTranslation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArtworkTranslation(
      id: serializer.fromJson<String>(json['id']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  ArtworkTranslation copyWith(
          {String? id,
          String? languageCode,
          String? name,
          String? description}) =>
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
  int get hashCode => Object.hash(id, languageCode, name, description);
  @override
  bool operator ==(Object other) =>
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
  final Value<String?> description;
  const ArtworkTranslationsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
  });
  ArtworkTranslationsCompanion.insert({
    required String id,
    required String languageCode,
    required String name,
    this.description = const Value.absent(),
  })  : id = Value(id),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtworkTranslation> custom({
    Expression<String>? id,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String?>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
    });
  }

  ArtworkTranslationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? languageCode,
      Value<String>? name,
      Value<String?>? description}) {
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
      map['description'] = Variable<String?>(description.value);
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
  final String? _alias;
  $ArtworkTranslationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES artworks(id)');
  final VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  late final GeneratedColumn<String?> languageCode = GeneratedColumn<String?>(
      'language_code', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, languageCode, name, description];
  @override
  String get aliasedName => _alias ?? 'artwork_translations';
  @override
  String get actualTableName => 'artwork_translations';
  @override
  VerificationContext validateIntegrity(Insertable<ArtworkTranslation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, languageCode};
  @override
  ArtworkTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ArtworkTranslation.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ArtworkTranslationsTable createAlias(String alias) {
    return $ArtworkTranslationsTable(_db, alias);
  }
}

class Artist extends DataClass implements Insertable<Artist> {
  final String id;
  final String? yearBirth;
  final String? yearDeath;
  final String? name;
  final String? biography;
  Artist(
      {required this.id,
      this.yearBirth,
      this.yearDeath,
      this.name,
      this.biography});
  factory Artist.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Artist(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      yearBirth: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year_birth']),
      yearDeath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}year_death']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      biography: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}biography']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || yearBirth != null) {
      map['year_birth'] = Variable<String?>(yearBirth);
    }
    if (!nullToAbsent || yearDeath != null) {
      map['year_death'] = Variable<String?>(yearDeath);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String?>(biography);
    }
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      id: Value(id),
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
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Artist(
      id: serializer.fromJson<String>(json['id']),
      yearBirth: serializer.fromJson<String?>(json['yearbirth']),
      yearDeath: serializer.fromJson<String?>(json['yeardeath']),
      name: serializer.fromJson<String?>(json['name']),
      biography: serializer.fromJson<String?>(json['biography']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'yearbirth': serializer.toJson<String?>(yearBirth),
      'yeardeath': serializer.toJson<String?>(yearDeath),
      'name': serializer.toJson<String?>(name),
      'biography': serializer.toJson<String?>(biography),
    };
  }

  Artist copyWith(
          {String? id,
          String? yearBirth,
          String? yearDeath,
          String? name,
          String? biography}) =>
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
  int get hashCode => Object.hash(id, yearBirth, yearDeath, name, biography);
  @override
  bool operator ==(Object other) =>
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
  final Value<String?> yearBirth;
  final Value<String?> yearDeath;
  final Value<String?> name;
  final Value<String?> biography;
  const ArtistsCompanion({
    this.id = const Value.absent(),
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  });
  ArtistsCompanion.insert({
    required String id,
    this.yearBirth = const Value.absent(),
    this.yearDeath = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Artist> custom({
    Expression<String>? id,
    Expression<String?>? yearBirth,
    Expression<String?>? yearDeath,
    Expression<String?>? name,
    Expression<String?>? biography,
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
      {Value<String>? id,
      Value<String?>? yearBirth,
      Value<String?>? yearDeath,
      Value<String?>? name,
      Value<String?>? biography}) {
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
      map['year_birth'] = Variable<String?>(yearBirth.value);
    }
    if (yearDeath.present) {
      map['year_death'] = Variable<String?>(yearDeath.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (biography.present) {
      map['biography'] = Variable<String?>(biography.value);
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
  final String? _alias;
  $ArtistsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _yearBirthMeta = const VerificationMeta('yearBirth');
  late final GeneratedColumn<String?> yearBirth = GeneratedColumn<String?>(
      'year_birth', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _yearDeathMeta = const VerificationMeta('yearDeath');
  late final GeneratedColumn<String?> yearDeath = GeneratedColumn<String?>(
      'year_death', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _biographyMeta = const VerificationMeta('biography');
  late final GeneratedColumn<String?> biography = GeneratedColumn<String?>(
      'biography', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, yearBirth, yearDeath, name, biography];
  @override
  String get aliasedName => _alias ?? 'artists';
  @override
  String get actualTableName => 'artists';
  @override
  VerificationContext validateIntegrity(Insertable<Artist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('year_birth')) {
      context.handle(_yearBirthMeta,
          yearBirth.isAcceptableOrUnknown(data['year_birth']!, _yearBirthMeta));
    }
    if (data.containsKey('year_death')) {
      context.handle(_yearDeathMeta,
          yearDeath.isAcceptableOrUnknown(data['year_death']!, _yearDeathMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography']!, _biographyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Artist map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Artist.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
  final String? biography;
  ArtistTranslation(
      {required this.id,
      required this.languageCode,
      required this.name,
      this.biography});
  factory ArtistTranslation.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ArtistTranslation(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      languageCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}language_code'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      biography: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}biography']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['language_code'] = Variable<String>(languageCode);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || biography != null) {
      map['biography'] = Variable<String?>(biography);
    }
    return map;
  }

  ArtistTranslationsCompanion toCompanion(bool nullToAbsent) {
    return ArtistTranslationsCompanion(
      id: Value(id),
      languageCode: Value(languageCode),
      name: Value(name),
      biography: biography == null && nullToAbsent
          ? const Value.absent()
          : Value(biography),
    );
  }

  factory ArtistTranslation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ArtistTranslation(
      id: serializer.fromJson<String>(json['id']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      name: serializer.fromJson<String>(json['name']),
      biography: serializer.fromJson<String?>(json['biography']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'languageCode': serializer.toJson<String>(languageCode),
      'name': serializer.toJson<String>(name),
      'biography': serializer.toJson<String?>(biography),
    };
  }

  ArtistTranslation copyWith(
          {String? id,
          String? languageCode,
          String? name,
          String? biography}) =>
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
  int get hashCode => Object.hash(id, languageCode, name, biography);
  @override
  bool operator ==(Object other) =>
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
  final Value<String?> biography;
  const ArtistTranslationsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.name = const Value.absent(),
    this.biography = const Value.absent(),
  });
  ArtistTranslationsCompanion.insert({
    required String id,
    required String languageCode,
    required String name,
    this.biography = const Value.absent(),
  })  : id = Value(id),
        languageCode = Value(languageCode),
        name = Value(name);
  static Insertable<ArtistTranslation> custom({
    Expression<String>? id,
    Expression<String>? languageCode,
    Expression<String>? name,
    Expression<String?>? biography,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
      if (name != null) 'name': name,
      if (biography != null) 'biography': biography,
    });
  }

  ArtistTranslationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? languageCode,
      Value<String>? name,
      Value<String?>? biography}) {
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
      map['biography'] = Variable<String?>(biography.value);
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
  final String? _alias;
  $ArtistTranslationsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES artists(id)');
  final VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  late final GeneratedColumn<String?> languageCode = GeneratedColumn<String?>(
      'language_code', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _biographyMeta = const VerificationMeta('biography');
  late final GeneratedColumn<String?> biography = GeneratedColumn<String?>(
      'biography', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, languageCode, name, biography];
  @override
  String get aliasedName => _alias ?? 'artist_translations';
  @override
  String get actualTableName => 'artist_translations';
  @override
  VerificationContext validateIntegrity(Insertable<ArtistTranslation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('biography')) {
      context.handle(_biographyMeta,
          biography.isAcceptableOrUnknown(data['biography']!, _biographyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, languageCode};
  @override
  ArtistTranslation map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ArtistTranslation.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ArtistTranslationsTable createAlias(String alias) {
    return $ArtistTranslationsTable(_db, alias);
  }
}

class Viewing extends DataClass implements Insertable<Viewing> {
  final int id;
  final String artworkId;
  final String? cnnModelUsed;
  final String algorithmUsed;
  final DateTime startTime;
  final DateTime endTime;
  final int totalTime;
  final String additionalInfo;
  Viewing(
      {required this.id,
      required this.artworkId,
      this.cnnModelUsed,
      required this.algorithmUsed,
      required this.startTime,
      required this.endTime,
      required this.totalTime,
      required this.additionalInfo});
  factory Viewing.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Viewing(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      artworkId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}artwork_id'])!,
      cnnModelUsed: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cnn_model_used']),
      algorithmUsed: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}algorithm_used'])!,
      startTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start_time'])!,
      endTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}end_time'])!,
      totalTime: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_time'])!,
      additionalInfo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}additional_info'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['artwork_id'] = Variable<String>(artworkId);
    if (!nullToAbsent || cnnModelUsed != null) {
      map['cnn_model_used'] = Variable<String?>(cnnModelUsed);
    }
    map['algorithm_used'] = Variable<String>(algorithmUsed);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['total_time'] = Variable<int>(totalTime);
    map['additional_info'] = Variable<String>(additionalInfo);
    return map;
  }

  ViewingsCompanion toCompanion(bool nullToAbsent) {
    return ViewingsCompanion(
      id: Value(id),
      artworkId: Value(artworkId),
      cnnModelUsed: cnnModelUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(cnnModelUsed),
      algorithmUsed: Value(algorithmUsed),
      startTime: Value(startTime),
      endTime: Value(endTime),
      totalTime: Value(totalTime),
      additionalInfo: Value(additionalInfo),
    );
  }

  factory Viewing.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Viewing(
      id: serializer.fromJson<int>(json['id']),
      artworkId: serializer.fromJson<String>(json['artworkId']),
      cnnModelUsed: serializer.fromJson<String?>(json['cnnModelUsed']),
      algorithmUsed: serializer.fromJson<String>(json['algorithmUsed']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      totalTime: serializer.fromJson<int>(json['totalTime']),
      additionalInfo: serializer.fromJson<String>(json['additionalInfo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'artworkId': serializer.toJson<String>(artworkId),
      'cnnModelUsed': serializer.toJson<String?>(cnnModelUsed),
      'algorithmUsed': serializer.toJson<String>(algorithmUsed),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'totalTime': serializer.toJson<int>(totalTime),
      'additionalInfo': serializer.toJson<String>(additionalInfo),
    };
  }

  Viewing copyWith(
          {int? id,
          String? artworkId,
          String? cnnModelUsed,
          String? algorithmUsed,
          DateTime? startTime,
          DateTime? endTime,
          int? totalTime,
          String? additionalInfo}) =>
      Viewing(
        id: id ?? this.id,
        artworkId: artworkId ?? this.artworkId,
        cnnModelUsed: cnnModelUsed ?? this.cnnModelUsed,
        algorithmUsed: algorithmUsed ?? this.algorithmUsed,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        totalTime: totalTime ?? this.totalTime,
        additionalInfo: additionalInfo ?? this.additionalInfo,
      );
  @override
  String toString() {
    return (StringBuffer('Viewing(')
          ..write('id: $id, ')
          ..write('artworkId: $artworkId, ')
          ..write('cnnModelUsed: $cnnModelUsed, ')
          ..write('algorithmUsed: $algorithmUsed, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('totalTime: $totalTime, ')
          ..write('additionalInfo: $additionalInfo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, artworkId, cnnModelUsed, algorithmUsed,
      startTime, endTime, totalTime, additionalInfo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Viewing &&
          other.id == this.id &&
          other.artworkId == this.artworkId &&
          other.cnnModelUsed == this.cnnModelUsed &&
          other.algorithmUsed == this.algorithmUsed &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.totalTime == this.totalTime &&
          other.additionalInfo == this.additionalInfo);
}

class ViewingsCompanion extends UpdateCompanion<Viewing> {
  final Value<int> id;
  final Value<String> artworkId;
  final Value<String?> cnnModelUsed;
  final Value<String> algorithmUsed;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> totalTime;
  final Value<String> additionalInfo;
  const ViewingsCompanion({
    this.id = const Value.absent(),
    this.artworkId = const Value.absent(),
    this.cnnModelUsed = const Value.absent(),
    this.algorithmUsed = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.totalTime = const Value.absent(),
    this.additionalInfo = const Value.absent(),
  });
  ViewingsCompanion.insert({
    this.id = const Value.absent(),
    required String artworkId,
    this.cnnModelUsed = const Value.absent(),
    required String algorithmUsed,
    required DateTime startTime,
    required DateTime endTime,
    required int totalTime,
    required String additionalInfo,
  })  : artworkId = Value(artworkId),
        algorithmUsed = Value(algorithmUsed),
        startTime = Value(startTime),
        endTime = Value(endTime),
        totalTime = Value(totalTime),
        additionalInfo = Value(additionalInfo);
  static Insertable<Viewing> custom({
    Expression<int>? id,
    Expression<String>? artworkId,
    Expression<String?>? cnnModelUsed,
    Expression<String>? algorithmUsed,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? totalTime,
    Expression<String>? additionalInfo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (artworkId != null) 'artwork_id': artworkId,
      if (cnnModelUsed != null) 'cnn_model_used': cnnModelUsed,
      if (algorithmUsed != null) 'algorithm_used': algorithmUsed,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (totalTime != null) 'total_time': totalTime,
      if (additionalInfo != null) 'additional_info': additionalInfo,
    });
  }

  ViewingsCompanion copyWith(
      {Value<int>? id,
      Value<String>? artworkId,
      Value<String?>? cnnModelUsed,
      Value<String>? algorithmUsed,
      Value<DateTime>? startTime,
      Value<DateTime>? endTime,
      Value<int>? totalTime,
      Value<String>? additionalInfo}) {
    return ViewingsCompanion(
      id: id ?? this.id,
      artworkId: artworkId ?? this.artworkId,
      cnnModelUsed: cnnModelUsed ?? this.cnnModelUsed,
      algorithmUsed: algorithmUsed ?? this.algorithmUsed,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      totalTime: totalTime ?? this.totalTime,
      additionalInfo: additionalInfo ?? this.additionalInfo,
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
    if (cnnModelUsed.present) {
      map['cnn_model_used'] = Variable<String?>(cnnModelUsed.value);
    }
    if (algorithmUsed.present) {
      map['algorithm_used'] = Variable<String>(algorithmUsed.value);
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
    if (additionalInfo.present) {
      map['additional_info'] = Variable<String>(additionalInfo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewingsCompanion(')
          ..write('id: $id, ')
          ..write('artworkId: $artworkId, ')
          ..write('cnnModelUsed: $cnnModelUsed, ')
          ..write('algorithmUsed: $algorithmUsed, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('totalTime: $totalTime, ')
          ..write('additionalInfo: $additionalInfo')
          ..write(')'))
        .toString();
  }
}

class $ViewingsTable extends Viewings with TableInfo<$ViewingsTable, Viewing> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ViewingsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _artworkIdMeta = const VerificationMeta('artworkId');
  late final GeneratedColumn<String?> artworkId = GeneratedColumn<String?>(
      'artwork_id', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'NULL REFERENCES artworks(id)');
  final VerificationMeta _cnnModelUsedMeta =
      const VerificationMeta('cnnModelUsed');
  late final GeneratedColumn<String?> cnnModelUsed = GeneratedColumn<String?>(
      'cnn_model_used', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _algorithmUsedMeta =
      const VerificationMeta('algorithmUsed');
  late final GeneratedColumn<String?> algorithmUsed = GeneratedColumn<String?>(
      'algorithm_used', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  late final GeneratedColumn<DateTime?> startTime = GeneratedColumn<DateTime?>(
      'start_time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _endTimeMeta = const VerificationMeta('endTime');
  late final GeneratedColumn<DateTime?> endTime = GeneratedColumn<DateTime?>(
      'end_time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _totalTimeMeta = const VerificationMeta('totalTime');
  late final GeneratedColumn<int?> totalTime = GeneratedColumn<int?>(
      'total_time', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _additionalInfoMeta =
      const VerificationMeta('additionalInfo');
  late final GeneratedColumn<String?> additionalInfo = GeneratedColumn<String?>(
      'additional_info', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        artworkId,
        cnnModelUsed,
        algorithmUsed,
        startTime,
        endTime,
        totalTime,
        additionalInfo
      ];
  @override
  String get aliasedName => _alias ?? 'viewings';
  @override
  String get actualTableName => 'viewings';
  @override
  VerificationContext validateIntegrity(Insertable<Viewing> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('artwork_id')) {
      context.handle(_artworkIdMeta,
          artworkId.isAcceptableOrUnknown(data['artwork_id']!, _artworkIdMeta));
    } else if (isInserting) {
      context.missing(_artworkIdMeta);
    }
    if (data.containsKey('cnn_model_used')) {
      context.handle(
          _cnnModelUsedMeta,
          cnnModelUsed.isAcceptableOrUnknown(
              data['cnn_model_used']!, _cnnModelUsedMeta));
    }
    if (data.containsKey('algorithm_used')) {
      context.handle(
          _algorithmUsedMeta,
          algorithmUsed.isAcceptableOrUnknown(
              data['algorithm_used']!, _algorithmUsedMeta));
    } else if (isInserting) {
      context.missing(_algorithmUsedMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('total_time')) {
      context.handle(_totalTimeMeta,
          totalTime.isAcceptableOrUnknown(data['total_time']!, _totalTimeMeta));
    } else if (isInserting) {
      context.missing(_totalTimeMeta);
    }
    if (data.containsKey('additional_info')) {
      context.handle(
          _additionalInfoMeta,
          additionalInfo.isAcceptableOrUnknown(
              data['additional_info']!, _additionalInfoMeta));
    } else if (isInserting) {
      context.missing(_additionalInfoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Viewing map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Viewing.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ViewingsTable createAlias(String alias) {
    return $ViewingsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ArtworksTable artworks = $ArtworksTable(this);
  late final $ArtworkTranslationsTable artworkTranslations =
      $ArtworkTranslationsTable(this);
  late final $ArtistsTable artists = $ArtistsTable(this);
  late final $ArtistTranslationsTable artistTranslations =
      $ArtistTranslationsTable(this);
  late final $ViewingsTable viewings = $ViewingsTable(this);
  late final ArtworksDao artworksDao = ArtworksDao(this as AppDatabase);
  late final ArtistsDao artistsDao = ArtistsDao(this as AppDatabase);
  late final ViewingsDao viewingsDao = ViewingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artworks, artworkTranslations, artists, artistTranslations, viewings];
}
