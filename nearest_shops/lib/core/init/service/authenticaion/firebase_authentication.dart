import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nearest_shops/core/init/service/firestorage/enum/document_collection_enums.dart';

import '../firestorage/firestorage_initialize.dart';

class FirebaseAuthentication {
  static FirebaseAuthentication _instance = FirebaseAuthentication._init();
  FirebaseAuthentication._init();
  static FirebaseAuthentication get instance => _instance;

  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authUser() {
    return _firebaseAuth.authStateChanges();
  }

  FirebaseAuth getInstance() {
    return _firebaseAuth;
  }

  User? authCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User?> createUserWithEmailandPassword({required String email, required String password}) async {
    try {
      final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<User?> signWithEmailandPassword({required String email, required String password}) async {
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredentials.user;
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future<void> setUserRole(int roleValue, String userId) async {
    try {
      Map<String, dynamic> roleMap = {ContentString.ROLE.rawValue: roleValue, ContentString.ID.rawValue: userId, ContentString.FAVOURITELIST.rawValue: []};

      await FirebaseCollectionRefInitialize.instance.usersCollectionReference.doc(userId).set(roleMap);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getUserRole(String userId) async {
    try {
      DocumentSnapshot userRoleSnapshot = await FirebaseCollectionRefInitialize.instance.usersCollectionReference.doc(userId).get();

      final roleValue = userRoleSnapshot.get(ContentString.ROLE.rawValue);
      return roleValue;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      rethrow;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      rethrow;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    } on FirebaseAuthException catch (e) {
      rethrow;
    } on FirebaseException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
