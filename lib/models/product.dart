class Product {
  final String ProductId;
  final String ProductName;
  final int Quantity;
  final bool IsActive;

  Product({
    required this.ProductId,
    required this.ProductName,
    required this.Quantity,
    required this.IsActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      ProductId: json['ProductId'] ?? '',
      ProductName: json['ProductName'] ?? '',
      Quantity: json['Quantity'],
      IsActive: json['IsActive'],
    );
  }
}
