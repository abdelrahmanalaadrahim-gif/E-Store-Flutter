
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart_page.dart';
import 'settings_page.dart';
import 'product_details_page.dart';
import 'products_page.dart';
import 'categories_page.dart';

class HomePage extends StatefulWidget {
  final Map<String, String> currentUser;
  const HomePage({super.key, required this.currentUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> products = [];
  List<String> categories = [];
  bool isLoadingProducts = true;
  bool isLoadingCategories = true;
  final int previewCount = 3;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      final res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if (res.statusCode == 200) {
        setState(() {
          products = List<Map<String, dynamic>>.from(jsonDecode(res.body));
          isLoadingProducts = false;
        });
      }
    } catch (e) {
      setState(() => isLoadingProducts = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> fetchCategories() async {
    try {
      final res =
          await http.get(Uri.parse("https://fakestoreapi.com/products/categories"));
      if (res.statusCode == 200) {
        setState(() {
          categories = List<String>.from(jsonDecode(res.body));
          isLoadingCategories = false;
        });
      }
    } catch (e) {
      setState(() => isLoadingCategories = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildHome() {
    if (isLoadingProducts || isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final catProducts = products
            .where((p) => p['category'] == category)
            .take(previewCount)
            .toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Text(
                    category.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductsPage(category: category, cart: cart),
                        ),
                      );
                    },
                    child: const Text("Show All"),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catProducts.length,
                  itemBuilder: (context, i) {
                    final p = catProducts[i];
                    return SizedBox(
                      width: 160,
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Image.network(
                                  p['image'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                p['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              Text("\$${p['price']}",
                                  style: const TextStyle(color: Colors.red)),
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  setState(() {
                                    cart.add(p);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Added to cart")),
                                  );
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailsPage(
                                          product: p, cart: cart),
                                    ),
                                  );
                                },
                                child: const Text("Details"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      buildHome(),
      CartPage(cart: cart),
      SettingsPage(currentUser: widget.currentUser),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("M&A Store 🛒"),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearch(products, cart),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("M&A Store",
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  const SizedBox(height: 8),
                  Text("Hello, ${widget.currentUser['email']}",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Cart"),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Categories"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoriesPage(cart: cart),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

// ====== شاشة البحث ======
class ProductSearch extends SearchDelegate<Map<String, dynamic>> {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> cart;

  ProductSearch(this.products, this.cart);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            })
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, {}),
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = products
        .where((p) =>
            p['title'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final p = results[index];
        return ListTile(
          leading: Image.network(p['image'], width: 50, height: 50),
          title: Text(p['title']),
          subtitle: Text("\$${p['price']}"),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              cart.add(p);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to cart")));
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductDetailsPage(product: p, cart: cart)),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products
        .where((p) =>
            p['title'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final p = suggestions[index];
        return ListTile(
          leading: Image.network(p['image'], width: 50, height: 50),
          title: Text(p['title']),
          onTap: () {
            query = p['title'];
            showResults(context);
          },
        );
      },
    );
  }
}
