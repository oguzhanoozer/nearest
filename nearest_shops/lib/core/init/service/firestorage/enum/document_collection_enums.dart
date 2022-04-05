enum FirestorageItems { SHOPS, PRODUCTS, USERS }

extension FirestorageItemsExtension on FirestorageItems {
  String get rawValue {
    switch (this) {
      case FirestorageItems.SHOPS:
        return "shops";
      case FirestorageItems.PRODUCTS:
        return "products";
      case FirestorageItems.USERS:
        return "users";
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
