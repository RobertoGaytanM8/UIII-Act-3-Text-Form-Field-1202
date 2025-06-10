import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final List<Map<String, String>> products;

  const Details({Key? key, required this.products}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<Map<String, String>> _localProducts;

  final Color baseColor = const Color.fromARGB(255, 123, 255, 226);
  final Color darkTurquoise = const Color.fromARGB(255, 0, 172, 153);
  final Color lightTurquoise = const Color.fromARGB(255, 188, 255, 246);

  @override
  void initState() {
    super.initState();
    _localProducts = List<Map<String, String>>.from(widget.products);
  }

  void _removeProduct(int index) {
    final removedItem = _localProducts[index];
    _localProducts.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(removedItem, animation),
      duration: const Duration(milliseconds: 400),
    );
  }

  Widget _buildRemovedItem(Map<String, String> product, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(1.0, 0.0),
        ).animate(animation),
        child: ListTile(
          leading: Icon(Icons.pets, color: Colors.grey.shade400),
          title: Text(
            product["Codigo"] ?? "",
            style: TextStyle(color: darkTurquoise, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            _buildDescription(product),
            style: TextStyle(color: darkTurquoise.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }

  String _buildDescription(Map<String, String> product) {
    return "Raza: ${product["Raza"] ?? "-"}\n"
        "Edad: ${product["Edad"] ?? "-"}\n"
        "Comportamiento: ${product["Comportamiento"] ?? "-"}\n"
        "Vacunas: ${product["Vacunas"] ?? "-"}\n"
        "Sexo: ${product["Sexo"] ?? "-"}";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _localProducts);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: baseColor,
          centerTitle: true,
          title: Text(
            "Tabla Perros",
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context, _localProducts),
            icon: Icon(Icons.arrow_back, color: darkTurquoise),
          ),
        ),
        body: AnimatedList(
          key: _listKey,
          initialItemCount: _localProducts.length,
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, index, animation) {
            final product = _localProducts[index];
            return SizeTransition(
              sizeFactor: animation,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.0, color: lightTurquoise),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: ListTile(
                  leading: Icon(Icons.pets, color: darkTurquoise),
                  title: Text(
                    product["Codigo"] ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, color: darkTurquoise, fontSize: 18),
                  ),
                  subtitle: Text(
                    _buildDescription(product),
                    style: TextStyle(color: darkTurquoise.withOpacity(0.8)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_forever, color: Colors.redAccent.shade400),
                    onPressed: () => _removeProduct(index),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
