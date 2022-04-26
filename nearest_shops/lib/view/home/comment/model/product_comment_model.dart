class ProductCommentModel {
  String? userName;
  String? userId;
  String? comment;
  String? userPhotoUrl;

  ProductCommentModel({
    this.userName,
    this.userId,
    this.comment,
    this.userPhotoUrl
  });

  Map<String, dynamic> toMap() =>
      {"userName": userName, "userId": userId, "comment": comment,"userPhotoUrl":userPhotoUrl};

  factory ProductCommentModel.fromJson(Map map) => ProductCommentModel(
        userName: map["userName"],
        userId: map["userId"],
        comment: map["comment"],
        userPhotoUrl: map["userPhotoUrl"]
      );
}
