import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');
  Future<void> addProduct(ProductModel model) {
    return product
        .add(model.fromJSon())
        .then((value) => print("Added"))
        .catchError((error) => print("Failed: $error"));
  }

  Future<void> deleteProduct({required String id}) {
    return product
        .doc(id)
        .delete()
        .then((value) => print(" Deleted"))
        .catchError((error) => print("Failed: $error"));
  }

  Future<void> updateProduct(
      {required ProductModel model, required String id}) {
    return product
        .doc(id)
        .update(model.fromJSon())
        .then((value) => print(" Updated"))
        .catchError((error) => print("Failed : $error"));
  }
}
