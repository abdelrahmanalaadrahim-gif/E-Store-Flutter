
import 'package:flutter/material.dart';
import 'product_details_page.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void purchaseItems() {
    if (widget.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your cart is empty 🛒")),
      );
      return;
    }

    // هنا ممكن تضيف منطق الدفع الفعلي
    setState(() {
      widget.cart.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Purchase successful ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.cart.isEmpty
                ? const Center(child: Text("Your cart is empty 🛒"))
                : ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      return ListTile(
                        leading:
                            Image.network(item['image'], width: 50, height: 50),
                        title: Text(item['title']),
                        subtitle: Text("\$${item['price']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              widget.cart.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "${item['title']} removed from cart ❌"),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsPage(product: item , cart: widget.cart),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
          if (widget.cart.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  
                  onPressed: purchaseItems,
                  child: const Text("Purchase Items"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
