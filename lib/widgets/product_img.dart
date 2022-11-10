import 'dart:io';

import 'package:flutter/material.dart';

class ProductImg extends StatelessWidget {
  const ProductImg({super.key, this.url});
  final String? url;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _boxDecoration(),
        child: Opacity(
          opacity: 0.9,
          child:
              ClipRRect(borderRadius: _borderRadius45(), child: getImage(url)),
        ),
      ),
    );
  }

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage(
          'assets/no-image.png',
        ),
        fit: BoxFit.cover,
      );
    } //* en caso de que la imagen sea null

    if (picture.startsWith('http')) {
      return FadeInImage(
        fit: BoxFit.cover,
        placeholder: const AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(url!),
      );
    } //? en caso de que la imagen sea por url

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    ); //! en caso que no entre en los 2 anteriores y sea una imagen del dispositivo
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: _borderRadius45(),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0, 0.05))
          ]);

  BorderRadius _borderRadius45() {
    return const BorderRadius.only(
      topLeft: Radius.circular(45),
      topRight: Radius.circular(45),
    );
  }
}
