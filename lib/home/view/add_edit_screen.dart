import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';

import '../../widget/input_field.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key});
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
            onPressed: () {},
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
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 50, 50),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 2,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 15,
                  child: GestureDetector(
                    onTap: () {
                      showAdaptiveActionSheet(
                        context: context,
                        actions: <BottomSheetAction>[
                          BottomSheetAction(
                            title: const Text('Choose Gallery'),
                            onPressed: (context) {},
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