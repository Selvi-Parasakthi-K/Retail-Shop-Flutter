//import 'package:api/screens/api1screen.dart';
import 'package:e_com/screens/productList.dart';
import 'package:e_com/utils/addProduct.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Retail Shop',
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        
      ),
      routes: {
        "/": (context) => ProductListScreen(),
        "/Addproduct": (context) => AddProduct(),
      }
    );
  }
}
