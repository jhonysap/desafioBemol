import 'package:desafio/model/product.dart';
import 'package:desafio/view/product_favorite_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../controller/service.dart';

class FavoriteProduct extends StatefulWidget {
  const FavoriteProduct({super.key});

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Container(
            child: Text(
          "Favorites",
          style: TextStyle(color: Colors.black.withOpacity(0.7)),
        )),
      ),
      body: Container(color: Colors.white, child: FavoritesList()),
    );
  }
}
