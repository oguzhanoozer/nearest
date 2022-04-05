import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/init/service/firestorage/firestorage_initialize.dart';

class ShopOwnerHomeService {
  
  static ShopOwnerHomeService _instance = ShopOwnerHomeService._init();
  ShopOwnerHomeService._init();
  static ShopOwnerHomeService get instance => _instance;
  
  Future<void> updateShopLocation(Map<String, dynamic> updateData) async {
    try {
      await FirebaseCollectionRefInitialize.instance.shopsCollectionReference
          .doc("234567")
          .update(updateData);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
