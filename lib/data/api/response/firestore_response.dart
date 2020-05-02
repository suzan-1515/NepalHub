import 'package:firebase_auth/firebase_auth.dart';
import 'package:samachar_hub/data/api/api.dart';

class FeedFirestoreResponse extends FeedApiResponse {
  final bool bookmarked;
  final bool liked;
  FeedFirestoreResponse(
      String id,
      FeedSourceApiResponse source,
      FeedCategoryApiResponse category,
      String author,
      String title,
      String description,
      String link,
      String image,
      String publishedAt,
      String content,
      List<FeedApiResponse> related,
      String uuid,
      this.bookmarked,
      this.liked)
      : super(id, source, category, author, title, description, link, image,
            publishedAt, content, related, uuid);

  factory FeedFirestoreResponse.fromJson(Map<String, dynamic> json) {
    var data = FeedApiResponse.fromJson(json);
    return FeedFirestoreResponse(
      data.id,
      data.source,
      data.category,
      data.author,
      data.title,
      data.description,
      data.link,
      data.image,
      data.publishedAt,
      data.content,
      data.related,
      data.uuid,
      json['bookmarked'] as bool,
      json['liked'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json['bookmarked'] = this.bookmarked;
    json['liked'] = this.liked;
    return json;
  }
}

class User {
  final String uId;
  final String fullName;
  final String email;
  final String avatar;

  User({this.uId, this.fullName, this.email, this.avatar});

  factory User.fromFirebaseUser(FirebaseUser user) => User(
      uId: user.uid,
      fullName: user.displayName,
      email: user.email,
      avatar: user.photoUrl);

  Map<String, dynamic> toJson() => {
        'id': this.uId,
        'full_name': this.fullName,
        'email': this.email,
        'avatar': this.avatar,
      };
}
