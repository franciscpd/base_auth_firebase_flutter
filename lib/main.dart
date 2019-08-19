import 'package:flutter/material.dart';
import 'package:single_product_sale_app/services/authentication.dart';
import 'package:single_product_sale_app/pages/root_page.dart';

void main() {
  runApp(new SingleProductSaleApp());
}

class SingleProductSaleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Single product sale app',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootPage(auth: new Auth()),
    );
  }
}
