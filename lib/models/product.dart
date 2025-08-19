class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final String? specs;
  final String? imageUrl;
  final int ownerId;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.specs,
    this.imageUrl,
    required this.ownerId,
  });

  factory Product.fromMap(Map<String, dynamic> m) => Product(
    id: m['id'],
    name: m['name'],
    category: m['category'],
    price: (m['price'] as num).toDouble(),
    specs: m['specs'],
    imageUrl: m['image_url'],
    ownerId: m['owner_id'],
  );
}
