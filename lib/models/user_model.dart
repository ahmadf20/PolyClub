import 'dart:convert';

import 'topic_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    this.id,
    this.username,
    this.name,
    this.bio,
    this.avatar,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.topic1Id,
    this.topic2Id,
    this.topic3Id,
    this.topic1,
    this.topic2,
    this.topic3,
    this.totalFollower,
    this.totalFollowing,
    this.isFollowing,
  });

  String? id;
  String? username;
  String? name;
  String? bio;
  String? avatar;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? totalFollowing;
  String? totalFollower;

  String? topic1Id;
  String? topic2Id;
  String? topic3Id;
  Topic? topic1;
  Topic? topic2;
  Topic? topic3;

  bool? isFollowing;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"]?.toString(),
        username: json["username"]?.toString(),
        name: json["name"]?.toString(),
        bio: json["bio"]?.toString(),
        avatar: json["avatar"]?.toString(),
        email: json["email"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        topic1Id: json["topic1_id"]?.toString(),
        topic2Id: json["topic2_id"]?.toString(),
        totalFollowing: json["total_following"]?.toString(),
        totalFollower: json["total_follower"]?.toString(),
        topic1: json["topic1"] == null ? null : Topic.fromJson(json["topic1"]),
        topic2: json["topic2"] == null ? null : Topic.fromJson(json["topic2"]),
        topic3: json["topic3"] == null ? null : Topic.fromJson(json["topic3"]),
        isFollowing: json["is_follow"] ?? false,
      );
}
