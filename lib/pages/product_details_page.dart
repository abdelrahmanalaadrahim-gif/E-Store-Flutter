
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> cart; // قائمة العربة

  const ProductDetailsPage({super.key, required this.product, required this.cart});

  void addToCart(BuildContext context) {
    cart.add(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product['title']} added to cart 🛒")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title']),
      backgroundColor: const Color.fromARGB(255, 130, 236, 133),
      ),
      body: 
      SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product['image'], height: 200),
            const SizedBox(height: 20),
            Text(product['title'],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("\$${product['price']}",
                style: const TextStyle(fontSize: 18, color: Colors.red)),
            const SizedBox(height: 20),
            Text(product['description']),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => addToCart(context),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
