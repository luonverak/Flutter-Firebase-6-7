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
import '../widget/loading.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key, this.productModel, this.docsId});
  late ProductModel? productModel;
  late String? docsId;
  final productController = Get.put(ProductController());
  final storageController = Get.put(StorageController());
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  late String imageURL = "";
  RxBool loading = false.obs;
  update() {
    productName.text = productModel!.name;
    productPrice.text = productModel!.price.toString();
    imageURL = productModel!.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel == null ? 'Add product' : 'Edit product'),
        actions: [
          IconButton(
            onPressed: () async {
              openLoading();
              await storageController
                  .uploadFile(XFile(storageController.file!.path));

              productModel == null
                  ? await productController.addProduct(
                      ProductModel(
                        id: Random().nextInt(10000),
                        name: productName.text,
                        price: double.parse(productPrice.text),
                        image: storageController.imageURL,
                      ),
                    )
                  : await productController.updateProduct(
                      model: ProductModel(
                        id: productModel!.id,
                        name: productName.text,
                        price: double.parse(productPrice.text),
                        image: storageController.file == null
                            ? productModel!.image
                            : storageController.imageURL,
                      ),
                      id: docsId.toString(),
                    );
              closeLoading();
              Get.back();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Obx(
        () => Visibility(
          visible: loading.value,
          replacement: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  GetBuilder<StorageController>(
                    init: productModel == null ? StorageController() : update(),
                    builder: (controller) => productModel == null
                        ? Container(
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
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: Colors.blue,
                              ),
                              image: storageController.file != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                        File(storageController.file!.path),
                                      ),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageURL),
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
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
