import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'enum/document_collection_enums.dart';

class FirebaseFirestoreInitalize {
  static FirebaseFirestoreInitalize _instance =
      FirebaseFirestoreInitalize._init();
  FirebaseFirestoreInitalize._init();

  static FirebaseFirestoreInitalize get instance => _instance;

  final FirebaseFirestore _firebaseFiresore = FirebaseFirestore.instance;
  FirebaseFirestore get firabaseFirestore => _firebaseFiresore;
}

class FirebaseStorageInitalize {
  static FirebaseStorageInitalize _instance = FirebaseStorageInitalize._init();
  FirebaseStorageInitalize._init();

  static FirebaseStorageInitalize get instance => _instance;

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseStorage get firabaseStorage => _firebaseStorage;
}

class FirebaseCollectionRefInitialize {
  static FirebaseCollectionRefInitialize _instance =
      FirebaseCollectionRefInitialize._init();
  FirebaseCollectionRefInitialize._init();

  static FirebaseCollectionRefInitialize get instance => _instance;

  CollectionReference productsCollectionReference = FirebaseFirestoreInitalize
      .instance._firebaseFiresore
      .collection(FirestorageItems.PRODUCTS.rawValue);

  CollectionReference shopsCollectionReference = FirebaseFirestoreInitalize
      .instance._firebaseFiresore
      .collection(FirestorageItems.SHOPS.rawValue);

  CollectionReference usersCollectionReference = FirebaseFirestoreInitalize
      .instance._firebaseFiresore
      .collection(FirestorageItems.USERS.rawValue);
      CollectionReference categoryCollectionReference = FirebaseFirestoreInitalize
      .instance._firebaseFiresore
      .collection(FirestorageItems.CATEGORY.rawValue);
}
