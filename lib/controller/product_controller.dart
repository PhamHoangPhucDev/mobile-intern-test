import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductController {
  TextEditingController textController = TextEditingController();
  String kind = 'ASC';
  String option = 'Price';
  List<ProductModel> list = [
    ProductModel(name: 'Laptop', price: 999.99, qty: 5),
    ProductModel(name: 'Smartphone', price: 499.99, qty: 10),
    ProductModel(name: 'Tablet', price: 299.99, qty: 0),
    ProductModel(name: 'Smartwatch', price: 199.99, qty: 3)
  ];

  double sumProduct() {
    double sum = 0;
    for (ProductModel item in list) {
      sum += (item.price*item.qty);
    }
    return sum;
  }

  String mostExpensiveProduct(){
    ProductModel ex = list.reduce((current, next) => current.price > next.price ? current : next);
    return ex.name;
  }

  bool checkStock(String prd) {
    var item = list.where((item) => (item.name.toLowerCase()).compareTo(prd.toLowerCase()) == 0 && item.qty > 0);
    if(item.isNotEmpty) return true;
    return false;
  }
  
  List<ProductModel> sortList(kind,option) {
    List<ProductModel> listPrd = [];
    if(kind == 'ASC') {
      if(option == 'Price') {
        listPrd = List.from(list)..sort((a, b) => a.price.compareTo(b.price));
      } else {
        listPrd = List.from(list)..sort((a, b) => a.qty.compareTo(b.qty));
      }
    } else {
      if(option == 'Price') {
        listPrd = List.from(list)..sort((a, b) => b.price.compareTo(a.price));
      } else {
        listPrd = List.from(list)..sort((a, b) => b.qty.compareTo(a.qty));
      }
    }
    return listPrd;
  }
}