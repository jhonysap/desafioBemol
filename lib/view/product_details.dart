import 'package:desafio/controller/service.dart';
import 'package:intl/intl.dart';
import 'package:desafio/model/product.dart';
import 'package:desafio/view/home.dart';
import 'package:desafio/view/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

Product product = Product();
var price;

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails(this.product, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

bool checkFavorite(Product product) {
  bool response;

  if (listFavorite.map((e) => e.id).contains(product.id)) {
    response = true;
  } else {
    response = false;
  }
  return response;
}

void formatterValue() {
  NumberFormat formatter = NumberFormat("0.00");

  price = formatter.format(product.price);
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = widget.product;
    formatterValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Container(
            child: Text(
          "Products Details",
          style: TextStyle(color: Colors.black.withOpacity(0.7)),
        )),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Service().checkFavorite(listFavorite, product);
                setState(() {
                  checkFavorite(product);
                });
              },
              icon: checkFavorite(product)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Image.network(product.image),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    const Align(
                      alignment: Alignment(-0.9, 0.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(-0.7, 0.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                            '${product.rate} (${product.rating_count} reviews)'),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.85, 0.0),
                      child: Container(
                        child: Text(
                          '\$$price',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Stack(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Icons.sort,
                          color: Colors.black54,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-0.7, 0.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${product.category}',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Stack(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Icons.menu,
                          color: Colors.black54,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.6, 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${product.description}',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
