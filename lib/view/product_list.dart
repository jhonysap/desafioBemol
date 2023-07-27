import 'package:desafio/view/product_details.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../controller/service.dart';
import '../model/product.dart';
import 'home.dart';

bool isFavorite = false;
List<Product> listFavorite = [];

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

Future<List<Product>> getFavorite() async {
  listFavorite = await Service().getFavorite();

  return listFavorite;
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

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Service().getProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.length != 0) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var product = snapshot.data![index];
              NumberFormat formatter = NumberFormat("0.00");

              var price;

              price = formatter.format(product.price);

              return Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 200,
                    child: Row(children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetails(product)));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Image.network(product.image),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetails(product)));
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.only(left: 30, top: 40),
                                child: Text(
                                  product.title.length > 60
                                      ? product.title.substring(0, 60)
                                      : product.title,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Stack(children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(product)));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: const Icon(
                                        Icons.star,
                                        size: 30,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetails(product)));
                                    },
                                    child: Container(
                                      alignment: const Alignment(-0.4, 0.0),
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        '${product.rate} (${product.rating_count} reviews)',
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(1.0, 0.0),
                                    child: Container(
                                        margin: const EdgeInsets.only(top: 2),
                                        child: GestureDetector(
                                          onTap: () {
                                            Service().checkFavorite(
                                                listFavorite, product);
                                            setState(() {
                                              checkFavorite(product);
                                            });
                                          },
                                          child: checkFavorite(product)
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: Colors.black,
                                                ),
                                        )),
                                  )
                                ]),
                              ),
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: const Alignment(-0.65, 0.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      '\$ $price',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 27,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.2)))),
                  )
                ],
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/imagem/disconnected.png',
                    width: 400,
                    height: 250,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            child: const Text(
                              "Go Home",
                              style: TextStyle(fontSize: 19),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (snapshot.data?.length == 0) {
          return Center(
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/imagem/empty.png',
                    width: 400,
                    height: 250,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
