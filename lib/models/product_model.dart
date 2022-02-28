class ProductModel {
  String title;
  String price;
  String quantity;
  String ean;

  ProductModel({
    required this.title,
    required this.price,
    required this.quantity,
    required this.ean,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      title: jsonData['productDescription'],
      price: jsonData['unitPrice'],
      quantity: jsonData['quantity'],
      ean: jsonData['ean'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': double.parse(
          (double.parse(price) * double.parse(quantity)).toStringAsFixed(2)),
      'ean': ean,
      'price': price,
      'qty': quantity,
    };
  }
}
