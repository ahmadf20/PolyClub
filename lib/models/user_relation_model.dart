import 'dart:convert';

import 'user_model.dart';

UserRelation userRelationFromJson(String str) =>
    UserRelation.fromJson(json.decode(str));

class UserRelation {
  UserRelation({
    this.id,
    this.followingId,
    this.followerId,
    this.createdAt,
    this.updatedAt,
    this.follower,
    this.following,
  });

  String? id;
  String? followingId;
  String? followerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? follower;
  User? following;

  factory UserRelation.fromJson(Map<String, dynamic> json) => UserRelation(
        id: json["id"]?.toString(),
        followingId: json["following_id"]?.toString(),
        followerId: json["follower_id"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        follower:
            json["follower"] == null ? null : User.fromJson(json["follower"]),
        following:
            json["following"] == null ? null : User.fromJson(json["following"]),
      );
}
