import 'dart:convert';

Topic topicFromJson(String str) => Topic.fromJson(json.decode(str));

class Topic {
  Topic({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        icon: json["icon"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
