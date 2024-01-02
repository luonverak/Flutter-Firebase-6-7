import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('product');
  Future<void> addProduct(ProductModel model) {
    return users
        .add(model.fromJSon())
        .then((value) => print("Added"))
        .catchError((error) => print("Failed: $error"));
  }
}
