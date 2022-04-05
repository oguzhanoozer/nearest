import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_authentication.dart';

class UserIdInitalize {
  static UserIdInitalize _instance = UserIdInitalize._init();
  UserIdInitalize._init();
  static UserIdInitalize get instance => _instance;

  String? userId;

  Future<String?> returnUserId() async {
    if (userId == null) {
      return await _fetchUserId();
    } else {
      return userId;
    }
  }

  void setUserId(String userId) {
    this.userId = userId;
  }

  Future<String?> _fetchUserId() async {
    try {
      User? user = FirebaseAuthentication.instance.authCurrentUser();

      if (user != null) {
        userId = user.uid;
        return userId;
      } else {}
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
}
