import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class OrderPage extends StatefulWidget {
  final Product product;
  final String apiUrl = 'https://uiexercise.theproindia.com/api/Order/AddOrder';

  OrderPage({Key? key, required this.product}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late TextEditingController quantity;

  @override
  void initState() {
    super.initState();
    quantity = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    quantity.dispose();
    super.dispose();
  }

  Future<void> _postProduct(BuildContext context) async {
    final response = await http.post(
      Uri.parse(widget.apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "customerId": "f9e86959-d568-44b9-2087-08dc44a8c8ef",
        "productId": widget.product.ProductId,
        "quantity": int.parse(quantity.text)
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully ordered"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Server error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _checkQuantity(BuildContext context, String quantity) {
    int quan = int.tryParse(quantity) ?? 0;
    if (quan <= 0 || quan > widget.product.Quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Quantity should be between 1 and ${widget.product.Quantity}"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
        backgroundColor: Colors.green,
        
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(0,50,0,100),
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(10),
            
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: Text(
                  widget.product.ProductName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'images/bangle.jpg',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                "Available Quantity: ${widget.product.Quantity}",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      int currentValue = int.parse(quantity.text);
                      if (currentValue > 0) {
                        setState(() {
                          currentValue--;
                          quantity.text = currentValue.toString();
                        });
                      }
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Container(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: quantity,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      int currentValue = int.parse(quantity.text);
                      if (currentValue < widget.product.Quantity) {
                        setState(() {
                          currentValue++;
                          quantity.text = currentValue.toString();
                        });
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                // width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_checkQuantity(context, quantity.text)) {
                      _postProduct(context);
                    }
                  },
                  child: Text('Order Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}