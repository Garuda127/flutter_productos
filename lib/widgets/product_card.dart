import 'package:flutter/material.dart';
import 'package:flutter_productos/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardDecoration(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product: product),
            _ProductDetails(product: product),
            _PriceTag(product: product),
            _NotAvalible(product: product),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 7))
        ]);
  }
}

class _NotAvalible extends StatelessWidget {
  final Product product;
  const _NotAvalible({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!product.available) {
      return Positioned(
          top: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.yellow[800],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
            width: 100,
            height: 70,
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'No Disponible',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ));
    }
    return Container();
  }
}

class _PriceTag extends StatelessWidget {
  final Product product;
  const _PriceTag({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 70,
        decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '\$${product.price}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

//* product details
class _ProductDetails extends StatelessWidget {
  final Product product;
  const _ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _productDetailsBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: _textStyle(),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            Text(
              product.id ?? 'id',
              style: _textStyle2(),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _productDetailsBoxDecoration() => const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );

  TextStyle _textStyle() {
    return const TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  }

  TextStyle _textStyle2() {
    return const TextStyle(
      fontSize: 15,
      color: Colors.white,
    );
  }
}

//* background
class _BackgroundImage extends StatelessWidget {
  final Product product;
  const _BackgroundImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FadeInImage(
          placeholder: const AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(product.picture ??
              'https://via.placeholder.com/400x300/f6f6f6.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
