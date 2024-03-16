// To parse this JSON data, do
//
//     final detailProductModel = detailProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:bloc_clean_architecture/domain/entities/products/detail_product.dart';

DetailProductModel detailProductModelFromJson(String str) =>
    DetailProductModel.fromJson(json.decode(str));

String detailProductModelToJson(DetailProductModel data) =>
    json.encode(data.toJson());

class DetailProductModel extends DetailProduct {
  DetailProductModel({
    required int id,
    required String title,
    required int price,
    required String description,
    required List<String> images,
    required DateTime? creationAt,
    required DateTime? updatedAt,
    required CategoryDetailProduct? category,
  }) : super(
          category: category,
          creationAt: creationAt,
          description: description,
          id: id,
          images: images,
          price: price,
          title: title,
          updatedAt: updatedAt,
        );

  factory DetailProductModel.fromJson(Map<String, dynamic> json) =>
      DetailProductModel(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        category: json["category"] == null
            ? null
            : CategoryDetailProduct.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
      };
}

class CategoryDetailProductModel {
  int? id;
  String? name;
  String? image;
  DateTime? creationAt;
  DateTime? updatedAt;

  CategoryDetailProductModel({
    this.id,
    this.name,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory CategoryDetailProductModel.fromJson(Map<String, dynamic> json) => CategoryDetailProductModel(
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
