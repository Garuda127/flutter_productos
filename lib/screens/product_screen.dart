import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_productos/providers/product_form_provider.dart';
import 'package:flutter_productos/services/services.dart';
import 'package:flutter_productos/ui/input_decorations.dart';
import 'package:flutter_productos/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  static String routerScreen = '/productScreen';
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductsScreenBody(productService: productService),
    );
    // return ;
  }
}

class _ProductsScreenBody extends StatelessWidget {
  const _ProductsScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImg(url: productService.selectedProduct!.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? pickedfile = await picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 100,
                        );
                        if (pickedfile == null) {
                          return;
                        }
                        productService
                            .updateSelectedProductImage(pickedfile.path);
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            //* form
            const _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: productService.isSaving
              ? null
              : () async {
                  if (!productForm.isValidForm()) return;
                  final String? imageUrl = await productService.uploadImage();
                  if (imageUrl != null) productForm.product.picture = imageUrl;
                  await productService.saveOrCreateProduct(productForm.product);
                },
          child: productService.isSaving
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.save_outlined)),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _formBoxDecoration(),
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: productForm.formkey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                    return null;
                  },
                  autocorrect: true,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre de Producto', label: 'Nombre:'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: '${product.price}',
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}')),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$150', label: 'Precio:'),
                ),
                const SizedBox(height: 30),
                SwitchListTile.adaptive(
                  title: const Text('Disponible'),
                  activeColor: Colors.indigo,
                  value: product.available,
                  onChanged: productForm.updateAvailability,
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }

  BoxDecoration _formBoxDecoration() => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
        ],
      );
}
