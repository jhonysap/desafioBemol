import 'dart:convert';
import 'package:desafio/model/product.dart';
import 'package:desafio/view/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service extends Product {
  final dio = Dio();
  List<Product> listFavorite = [];

  Future<List<Product>> getProduct() async {
    if (Home.listProductsFinal.length > 0 && init == 1) {
      return Home.listProductsFinal;
    }

    var url = Uri.parse('https://fakestoreapi.com/products');

    final response = await dio.getUri(url);

    try {
      if (response.statusCode == 200) {
        Home.listProductsFinal = (response.data as List).map((item) {
          return Product.fromJson(item);
        }).toList();
      } else {
        Home.listProductsFinal = [];
      }
    } catch (e) {
      DioException(
          requestOptions: RequestOptions(connectTimeout: Duration(seconds: 3)));
      print('Error ${e}');
    }
    Home.filteredList = Home.listProductsFinal;
    init = 1;

    return Home.listProductsFinal;
  }

  Future<bool> checkFavorite(
      List<Product> listFavorite, Product product) async {
    bool response = false;

    if (listFavorite.isEmpty) {
      response = await addFavorite(listFavorite, product);
    } else {
      if (listFavorite.map((e) => e.id).contains(product.id)) {
        response = await removeFavorite(listFavorite, product);
      } else {
        response = await addFavorite(listFavorite, product);
      }
    }

    return response;
  }

  Future<List<Product>> getFavorite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // sharedPreferences.clear();
    //recupero os favoritos que estão no Shared Preferences.
    String recover = sharedPreferences.getString('listFavorite').toString();

    //Decodifico e adiciono em uma lista de Objetos
    List listFavorite = json.decode(recover) ?? [];

    //Converto a lista de objetos em lista de Produtos
    List<Product> listProduct = (listFavorite as List).map((json) {
      return Product.fromJson(json);
    }).toList();

    return listProduct;
  }

  Future<bool> removeFavorite(
      List<Product> listProduct, Product product) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List newListFavorite = [];

    listProduct.remove(product);
    //Esse for serve para percorrer a lista de favoritos e remover o Produto que tem o mesmo ID.
    for (var i = 0; i < listProduct.length; i++) {
      newListFavorite.add(Product().toJson(listProduct[i]));
    }

    bool result = await sharedPreferences.setString(
        'listFavorite', jsonEncode(newListFavorite));

    print(
        'QTD de Produtos Favoritos após a REMOÇÃO: ${newListFavorite.length}');

    return result;
  }

  Future<bool> addFavorite(List<Product> listProduct, Product product) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List newListFavorite = [];

    listProduct.add(product);

    //Esse for serve para popular a lista que sera salva no Shared Preference.
    for (var i = 0; i < listProduct.length; i++) {
      newListFavorite.add(Product().toJson(listProduct[i]));
    }

    bool result = await sharedPreferences.setString(
        'listFavorite', jsonEncode(newListFavorite));

    print('QTD de Produtos Favoritos após a ADIÇÃO: ${newListFavorite.length}');

    return result;
    // String recover2 = sharedPreferences.getString('listFavorite').toString();

    // List listFavorite2 = json.decode(recover2) ?? [];

    // print(listFavorite2.length);
  }
}
