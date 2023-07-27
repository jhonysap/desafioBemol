import 'package:desafio/controller/service.dart';
import 'package:desafio/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test service is not null", () {
    test("Service.getProduct is not null", () {
      expect(Service().getProduct(), isNotNull);
    });

    test("Service.getProduct is not empyte", () async {
      List<Product> products = await Service().getProduct();

      expect("product list contains 20 items", isNotEmpty);
      expect(products.length, 20);
    });
  });
}
