import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utils/productCard.dart';  

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://uiexercise.theproindia.com/api/Product/GetAllProduct'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        products = jsonData.map((data) => Product.fromJson(data)).toList();
        filteredProducts = List.from(products); // Initialize filteredProducts with all products
      });
    }
  }

  void filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(products); // Show all products if search query is empty
      } else {
        filteredProducts = products.where((product) =>
            product.ProductName.toLowerCase().contains(query.toLowerCase())).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Product List'),
        titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Addproduct');
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                alignment: Alignment.center,
                textStyle: const TextStyle(fontSize: 15, color: Colors.white),
                backgroundColor: Colors.pink,
              ),
              child: const Text('Add Product'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProductCard(products: filteredProducts, onSearch: filterProducts),
      ),
    );
  }
}