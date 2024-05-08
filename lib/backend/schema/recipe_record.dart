import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/base_structure/base_util.dart';

class RecipeRecord extends FirestoreRecord {
  RecipeRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "recipeName" field.
  String? _recipeName;
  String get recipeName => _recipeName ?? '';
  bool hasRecipeName() => _recipeName != null;

  // "photos" field.
  List<String>? _photos;
  List<String> get photos => _photos ?? const [];
  bool hasPhotos() => _photos != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "instructions" field.
  List<String>? _instructions;
  List<String> get instructions => _instructions ?? const [];
  bool hasInstructions() => _instructions != null;

  // "creation_date" field.
  String? _creationDate;
  String get creationDate => _creationDate ?? '';
  bool hasCreationDate() => _creationDate != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "cuisineType" field.
  String? _cuisineType;
  String get cuisineType => _cuisineType ?? '';
  bool hasCuisineType() => _cuisineType != null;

  // "Trending" field.
  bool? _trending;
  bool get trending => _trending ?? false;
  bool hasTrending() => _trending != null;

  // "ingredients" field.
  List<String>? _ingredients;
  List<String> get ingredients => _ingredients ?? const [];
  bool hasIngredients() => _ingredients != null;

  void _initializeFields() {
    _recipeName = snapshotData['recipeName'] as String?;
    _photos = getDataList(snapshotData['photos']);
    _description = snapshotData['description'] as String?;
    _instructions = getDataList(snapshotData['instructions']);
    _creationDate = snapshotData['creation_date'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _cuisineType = snapshotData['cuisineType'] as String?;
    _trending = snapshotData['Trending'] as bool?;
    _ingredients = getDataList(snapshotData['ingredients']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('recipe');

  static Stream<RecipeRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RecipeRecord.fromSnapshot(s));

  static Future<RecipeRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RecipeRecord.fromSnapshot(s));

  static RecipeRecord fromSnapshot(DocumentSnapshot snapshot) => RecipeRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RecipeRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RecipeRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RecipeRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RecipeRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRecipeRecordData({
  String? recipeName,
  String? description,
  String? creationDate,
  DocumentReference? userId,
  String? cuisineType,
  bool? trending,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'recipeName': recipeName,
      'description': description,
      'creation_date': creationDate,
      'user_id': userId,
      'cuisineType': cuisineType,
      'Trending': trending,
    }.withoutNulls,
  );

  return firestoreData;
}

class RecipeRecordDocumentEquality implements Equality<RecipeRecord> {
  const RecipeRecordDocumentEquality();

  @override
  bool equals(RecipeRecord? e1, RecipeRecord? e2) {
    const listEquality = ListEquality();
    return e1?.recipeName == e2?.recipeName &&
        listEquality.equals(e1?.photos, e2?.photos) &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.instructions, e2?.instructions) &&
        e1?.creationDate == e2?.creationDate &&
        e1?.userId == e2?.userId &&
        e1?.cuisineType == e2?.cuisineType &&
        e1?.trending == e2?.trending &&
        listEquality.equals(e1?.ingredients, e2?.ingredients);
  }

  @override
  int hash(RecipeRecord? e) => const ListEquality().hash([
        e?.recipeName,
        e?.photos,
        e?.description,
        e?.instructions,
        e?.creationDate,
        e?.userId,
        e?.cuisineType,
        e?.trending,
        e?.ingredients
      ]);

  @override
  bool isValidKey(Object? o) => o is RecipeRecord;
}
