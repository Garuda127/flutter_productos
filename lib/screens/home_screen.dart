import 'package:flutter/material.dart';
import 'package:flutter_productos/screens/screens.dart';
import 'package:flutter_productos/services/authservice.dart';
import 'package:flutter_productos/services/product_service.dart';
import 'package:flutter_productos/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  static String routerScreen = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(
                    context, LoginScreen.routerScreen);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ProductCard(product: productsService.products[index]),
            onTap: () {
              productsService.selectedProduct =
                  productsService.products[index].copy();
              Navigator.pushNamed(context, ProductScreen.routerScreen);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productsService.selectedProduct =
              Product(available: true, name: '', price: 0.0);
          Navigator.pushNamed(context, ProductScreen.routerScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
