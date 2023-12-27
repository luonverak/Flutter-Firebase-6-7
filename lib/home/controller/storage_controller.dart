import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageController extends GetxController {
  File? file;
  final storageRef = FirebaseStorage.instance.ref();

  Future openGallery() async {
    try {
      final fileChoose =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      file = File(fileChoose!.path);
    } catch (e) {
      print(e);
    }
    update();
  }

  // Future uploadFile(XFile files) async {
  //   var time = DateTime.now();
  //   final rootImagesRef = storageRef.child("Image/$time-${files.name}");
  //   try {
  //     await storageRef.putFile(File(files.name));
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
