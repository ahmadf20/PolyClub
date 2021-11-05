import 'dart:convert';

Help notificationFromJson(String str) => Help.fromJson(json.decode(str));

class Help {
  Help({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? content;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isExpanded = false;

  factory Help.fromJson(Map<String, dynamic> json) => Help(
        id: json["id"]?.toString(),
        content: json["jawaban"]?.toString(),
        title: json["pertanyaan"]?.toString(),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
