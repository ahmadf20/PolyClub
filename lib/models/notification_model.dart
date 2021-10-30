import 'dart:convert';

import 'user_model.dart';

Notif notificationFromJson(String str) => Notif.fromJson(json.decode(str));

class Notif {
  Notif({
    this.id,
    this.content,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.followingId,
    this.following,
  });

  String? id;
  String? content;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? userId;
  String? followingId;
  User? following;

  factory Notif.fromJson(Map<String, dynamic> json) => Notif(
        id: json["id"]?.toString(),
        content: json["content"]?.toString(),
        icon: json["icon"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["user_id"]?.toString(),
        followingId: json["following_id"]?.toString(),
        following:
            json["following"] == null ? null : User.fromJson(json["following"]),
      );
}
