import 'package:desafio/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import '../controller/service.dart';
import '../model/product.dart';
import 'product_details.dart';

class FavoritesList extends StatefulWidget {
  const FavoritesList({super.key});

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: Service().getFavorite(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.length != 0) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var product = snapshot.data![index];

              NumberFormat formatter = NumberFormat("0.00");

              var price = formatter.format(product.price);
              return Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 200,
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Image.network(product.image),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(left: 30, top: 40),
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
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Stack(children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: const Icon(
                                      Icons.star,
                                      size: 30,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  Container(
                                    alignment: const Alignment(-0.4, 0.0),
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      '${product.rate} (${product.rating_count} reviews)',
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 15),
                                    ),
                                  ),
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
                                      builder: (context) => const Home()));
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
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
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
