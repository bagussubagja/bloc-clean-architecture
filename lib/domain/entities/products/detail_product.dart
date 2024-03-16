// To parse this JSON data, do
//
//     final detailProduct = detailProductFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

DetailProduct detailProductFromJson(String str) => DetailProduct.fromJson(json.decode(str));

String detailProductToJson(DetailProduct data) => json.encode(data.toJson());

class DetailProduct extends Equatable{
    int? id;
    String? title;
    int? price;
    String? description;
    List<String>? images;
    DateTime? creationAt;
    DateTime? updatedAt;
    CategoryDetailProduct? category;

    DetailProduct({
        this.id,
        this.title,
        this.price,
        this.description,
        this.images,
        this.creationAt,
        this.updatedAt,
        this.category,
    });

    factory DetailProduct.fromJson(Map<String, dynamic> json) => DetailProduct(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        category: json["category"] == null ? null : CategoryDetailProduct.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
    };
    
      @override
      List<Object?> get props => [id, title, price, description, images, creationAt, updatedAt, category];
}

class CategoryDetailProduct extends Equatable{
    int? id;
    String? name;
    String? image;
    DateTime? creationAt;
    DateTime? updatedAt;

    CategoryDetailProduct({
        this.id,
        this.name,
        this.image,
        this.creationAt,
        this.updatedAt,
    });

    factory CategoryDetailProduct.fromJson(Map<String, dynamic> json) => CategoryDetailProduct(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: json["creationAt"] == null ? null : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
    
      @override
      List<Object?> get props => [id, name, image, creationAt, updatedAt];
}
