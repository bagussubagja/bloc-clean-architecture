// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

import 'package:bloc_clean_architecture/domain/entities/category/categories.dart';

List<CategoriesModel> categoriesModelFromJson(String str) =>
    List<CategoriesModel>.from(
        json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel extends Categories {
  CategoriesModel({
    required int? id,
    required String? name,
    required String? image,
    required DateTime? creationAt,
    required DateTime? updatedAt,
  }) : super(
            creationAt: creationAt,
            id: id,
            image: image,
            name: name,
            updatedAt: updatedAt);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
