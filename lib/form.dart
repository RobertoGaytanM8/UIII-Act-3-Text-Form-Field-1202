import 'package:flutter/material.dart';
import 'package:myapp/details.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _productController = TextEditingController();
  final _productDesController = TextEditingController();

  final List<Map<String, String>> _products = [];

  @override
  void dispose() {
    _productController.dispose();
    _productDesController.dispose();
    super.dispose();
  }

  void _saveAndNavigate(BuildContext context) {
    if (_productController.text.isNotEmpty &&
        _productDesController.text.isNotEmpty) {
      setState(() {
        _products.add({
          "name": _productController.text,
          "description": _productDesController.text,
        });
        _productController.clear();
        _productDesController.clear();
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Details(products: _products),
      ),
    ).then((updatedProducts) {
      if (updatedProducts != null && updatedProducts is List<Map<String, String>>) {
        setState(() {
          _products
            ..clear()
            ..addAll(updatedProducts);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 123, 255, 226),
          title: const Text("UIII Act 3 Text Form Field Roberto Gaytan", style: TextStyle(fontSize: 17),),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              MyTextField(
                myController: _productController,
                fieldName: "Nombre del campo",
                myIcon: Icons.pets,
                prefixIconColor: const Color.fromARGB(255, 0, 62, 218),
              ),
              const SizedBox(height: 10.0),
              MyTextField(
                myController: _productDesController,
                fieldName: "Informacion",
                myIcon: Icons.description,
                prefixIconColor: const Color.fromARGB(255, 0, 62, 218),
              ),
              const SizedBox(height: 20.0),
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
                onPressed: () => _saveAndNavigate(context),
                child: Text(
                  "Guardar".toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 9, 108),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
  });

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(myIcon, color: prefixIconColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 93, 0, 255)),
        ),
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 53, 106)),
      ),
    );
  }
}
