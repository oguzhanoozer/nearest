enum FirestorageItems { SHOPS, PRODUCTS, USERS, CATEGORY }

extension FirestorageItemsExtension on FirestorageItems {
  String get rawValue {
    switch (this) {
      case FirestorageItems.SHOPS:
        return "shops";
      case FirestorageItems.PRODUCTS:
        return "products";
      case FirestorageItems.USERS:
        return "users";
      case FirestorageItems.CATEGORY:
        return "category";
      default:
        throw ("Items was not found");
    }
  }
}

enum UserRole { USER, BUSINESS }

extension UserRoleExtension on UserRole {
  int get roleRawValue {
    switch (this) {
      case UserRole.USER:
        return 0;
      case UserRole.BUSINESS:
        return 1;

      default:
        throw ("Items was not found");
    }
  }
}

enum ContentString { LOGOURL, GOOGLE, USER, SHOPID, PRODUCTID, ID, FAVOURITELIST, CONTENT, PROFILE_IMAGE, LOCATION, ROLE }

extension ContentTitleExtension on ContentString {
  String get rawValue {
    switch (this) {
      case ContentString.GOOGLE:
        return "Google";
      case ContentString.USER:
        return "user";
      case ContentString.SHOPID:
        return "shopId";
      case ContentString.PRODUCTID:
        return "productId";
      case ContentString.ID:
        return "id";
      case ContentString.FAVOURITELIST:
        return "favouriteList";
      case ContentString.CONTENT:
        return "content";
      case ContentString.PROFILE_IMAGE:
        return "Profile Image";
      case ContentString.LOCATION:
        return "location";
      case ContentString.ROLE:
        return "role";
      case ContentString.LOGOURL:
        return "logoUrl";
      default:
        throw ("Items was not found");
    }
  }
}

enum AuthErrorString {
  INVALID_EMAIL, //
  USER_DISABLED, //
  USER_NOT_FOUND, //
  WRONG_PASSWORD, //
  EXPIRED_ACTION_CODE, //
  INVALID_ACTION_CODE, //
  INVALID_CREDENTIAL, //
  OPERATION_NOT_ALLOWED, //
  INVALID_VERIFICATION_CODE,
  INVALID_VERIFICATION_ID,
  ACCOUNT_EXIST_WITH_DIFFERENT_CREDENTIAL, //
  EMAIL_ALREADY_IN_USE, //
  WEAK_PASSWORD, //

}

extension AuthErrorStringExtension on AuthErrorString {
  String get rawValue {
    switch (this) {
      case AuthErrorString.INVALID_EMAIL:
        return "invalid-email";
      case AuthErrorString.USER_DISABLED:
        return "user-disabled";
      case AuthErrorString.USER_NOT_FOUND:
        return "user-not-found";
      case AuthErrorString.WRONG_PASSWORD:
        return "wrong-password";
      case AuthErrorString.EXPIRED_ACTION_CODE:
        return "expired-action-code";
      case AuthErrorString.INVALID_ACTION_CODE:
        return "invalid-action-code";
      case AuthErrorString.INVALID_CREDENTIAL:
        return "invalid-credential";
      case AuthErrorString.OPERATION_NOT_ALLOWED:
        return "operation-not-allowed";
      case AuthErrorString.INVALID_VERIFICATION_CODE:
        return "invalid-verification-code";
      case AuthErrorString.INVALID_VERIFICATION_ID:
        return "invalid-verification-id";
      case AuthErrorString.ACCOUNT_EXIST_WITH_DIFFERENT_CREDENTIAL:
        return "account-exists-with-different-credential";
      case AuthErrorString.EMAIL_ALREADY_IN_USE:
        return "email-already-in-use";
      case AuthErrorString.WEAK_PASSWORD:
        return "weak-password";

      default:
        throw ("Items was not found");
    }
  }
}
