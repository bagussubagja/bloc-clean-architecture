// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:bloc_clean_architecture/domain/entities/products/products.dart';

List<ProductsModel> productsModelFromJson(String str) =>
    List<ProductsModel>.from(
        json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel extends Products {
  ProductsModel({
    required int? id,
    required String? title,
    required int? price,
    required String? description,
    required List<String>? images,
    required DateTime? creationAt,
    required DateTime? updatedAt,
    required CategoryEntity? category,
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

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
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
            : Category.fromJson(json["category"]),
      );

  @override
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

class Category extends CategoryEntity {
  Category({
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
          updatedAt: updatedAt,
        );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
