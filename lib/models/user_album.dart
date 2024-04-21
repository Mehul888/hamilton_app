import 'dart:convert';

class AlbumModel {
  int userId;
  int id;
  String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumModel.fromRawJson(String str) => AlbumModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
  };
}
