import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = "http://127.0.0.1:8000"; // change to 10.0.2.2 on Android emulator

  Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse("$baseUrl/products/"));
    if (res.statusCode != 200) {
      throw Exception("Failed to load products");
    }
    final data = jsonDecode(res.body) as List;
    return data.map((e) => Product.fromMap(e)).toList();
  }

  Future<Product> addProduct(Map<String, dynamic> payload) async {
    final res = await http.post(
      Uri.parse("$baseUrl/products/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payload),
    );
    if (res.statusCode != 200) {
      throw Exception("Failed to create product");
    }
    final data = jsonDecode(res.body);
    return Product.fromMap(data);
  }
}
