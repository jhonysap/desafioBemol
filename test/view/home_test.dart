import 'package:desafio/controller/service.dart';
import 'package:desafio/model/product.dart';
import 'package:desafio/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Home", () {
    testWidgets("Home - Products", (widgetTester) async {
      await widgetTester.runAsync(() async {
        await widgetTester.pumpWidget(const MaterialApp(
          home: Home(),
        ));

        expect(find.text('Products'), findsOneWidget);
        expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      });
    });
  });
}
