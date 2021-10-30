import 'dart:convert';

import 'package:poly_club/models/topic_model.dart';
import 'package:poly_club/models/user_model.dart';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

class Room {
  Room({
    this.id,
    this.name,
    this.description,
    this.isScheduled,
    this.startTime,
    this.createdAt,
    this.updatedAt,
    this.topicId,
    this.hostId,
    this.topic,
    this.host,
    this.isReminded = false,
  });

  String? id;
  String? name;
  String? description;
  DateTime? startTime;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? topicId;
  String? hostId;
  bool? isScheduled;
  bool isReminded;
  Topic? topic;
  User? host;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        description: json["description"]?.toString(),
        isScheduled: json["is_scheduled"],
        isReminded: json["is_reminded"] ?? false,
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        topicId: json["topic_id"]?.toString(),
        hostId: json["host_id"]?.toString(),
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        host: json["host"] == null ? null : User.fromJson(json["host"]),
      );
}
