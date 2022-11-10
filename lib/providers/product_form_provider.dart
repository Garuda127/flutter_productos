import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

 /// La función toma un valor booleano y establece la disponibilidad del producto a ese valor
 /// * se utiliza para redibujar el widget del Switch
 /// Args:
 ///   value (bool): El valor de la casilla de verificación.
  updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formkey.currentState?.validate() ?? false;
  }
}
