import 'firestorage_initialize.dart';

class FirestoreService {
  static FirestoreService _instance = FirestoreService._init();
  FirestoreService._init();
  static FirestoreService get instance => _instance;

  Future<void> registerOwner(Map<String, dynamic> ownerMapData) async {
    
    await FirebaseCollectionRefInitialize.instance.shopsCollectionReference
        .doc(ownerMapData["id"])
        .set(ownerMapData);
  }
}
