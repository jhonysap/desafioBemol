import 'package:desafio/controller/service.dart';
import 'package:desafio/model/product.dart';
import 'package:desafio/view/product_favorite.dart';
import 'package:flutter/material.dart';
import '../controller/sechBox.dart';
import 'product_list.dart';

var init;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static List<Product> listProductsFinal = [];
  static List<Product> filteredList = [];
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    init = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
            child: Text(
          "Products",
          style: TextStyle(color: Colors.black.withOpacity(0.7)),
        )),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteProduct()));
              },
              child: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          //Box de Pesquisa
          SearchBox(
            onChange: (valorBusca) {
              setState(() {
                var regex = RegExp("$valorBusca", caseSensitive: false);
                Home.listProductsFinal = Home.filteredList
                    .where((element) => regex.hasMatch(element.title))
                    .toList();
              });
            },
          ),
          Expanded(
            child: ProductList(),
          )
        ]),
      ),
    );
  }
}
