const String tableCart = 'cart';

class CartItem {
  static final List<String> values = [
    id,
    productId,
    productName,
    productImage,
    productPrice
  ];

  static const String id = 'id';
  static const String productId = 'productId';
  static const String productName = 'productName';
  static const String productImage = 'productImage';
  static const String productPrice = 'productPrice';
}

class CartItemModel {
  final int? id;
  final String? productId;
  final String? productName;
  final String? productImage;
  final String? productPrice;

  CartItemModel(
      {this.id,
      required this.productId,
      required this.productName,
      required this.productImage,
      required this.productPrice});

  CartItemModel copy({
    int? id,
    String? productId,
    String? productName,
    String? productImage,
    String? productPrice,
  }) =>
      CartItemModel(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productImage: productImage ?? this.productImage,
        productPrice: productPrice ?? this.productPrice,
      );

  static CartItemModel fromJson(Map<String, Object?> json) => CartItemModel(
      id: json[CartItem.id] as int,
      productId: json[CartItem.productId] as String,
      productName: json[CartItem.productName] as String,
      productImage: json[CartItem.productImage] as String,
      productPrice: json[CartItem.productPrice] as String);

  Map<String, Object?> toJson() => {
        CartItem.id: id,
        CartItem.productPrice: productPrice,
        CartItem.productImage: productImage,
        CartItem.productName: productName,
        CartItem.productId: productId,
      };
}
