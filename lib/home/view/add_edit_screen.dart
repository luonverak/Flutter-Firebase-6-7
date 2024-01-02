import 'dart:io';
import 'dart:math';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/home/controller/product_controller.dart';
import 'package:flutter_firebase/home/controller/storage_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../widget/input_field.dart';
import '../model/product_model.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key});
  late ProductModel? productModel;
  final productController = Get.put(ProductController());
  final storageController = Get.put(StorageController());
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
        actions: [
          IconButton(
            onPressed: () async {
              await storageController
                  .uploadFile(XFile(storageController.file!.path));
              await productController.addProduct(
                ProductModel(
                  id: Random().nextInt(10000),
                  name: productName.text,
                  price: double.parse(productPrice.text),
                  image: storageController.imageURL,
                ),
              );
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                GetBuilder<StorageController>(
                  init: StorageController(),
                  builder: (controller) => Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 50, 50),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 2,
                        color: Colors.blue,
                      ),
                      image: storageController.file == null
                          ? const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'asset/image/grocery-shopping.jpg'))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(storageController.file!.path),
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 15,
                  child: GestureDetector(
                    onTap: () async {
                      showAdaptiveActionSheet(
                        context: context,
                        actions: <BottomSheetAction>[
                          BottomSheetAction(
                            title: const Text('Choose Gallery'),
                            onPressed: (context) async {
                              await storageController
                                  .openGallery()
                                  .whenComplete(() => Get.back());
                            },
                          ),
                          BottomSheetAction(
                            title: const Text('Open Camera'),
                            onPressed: (context) {},
                          ),
                        ],
                        cancelAction: CancelAction(
                          title: const Text('Cancel'),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 94, 94, 94),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: productName,
              hintText: 'Product name',
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: productPrice,
              hintText: 'Product price',
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
