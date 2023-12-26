import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/auth/model/user_model.dart';
import 'package:flutter_firebase/home/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/login_screen.dart';

class UserController extends GetxController {
  RxBool check = true.obs;
  Future<void> createUser(UserModel model) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      if (credential.user != null) {
        Get.offAll(HomeScreen());
        Get.snackbar('Success', 'Create account success');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else {
        Get.snackbar('Error', 'Something wrong');
      }
    } catch (e) {
      print(e);
    }
    update();
  }

  Future<void> loginUser(UserModel model) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      check.value = false;
      Future.delayed(const Duration(seconds: 4));
      if (credential.user != null) {
        Get.offAll(HomeScreen());
        Get.snackbar('Success', 'Account login success');
      }
      check(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      }
    }

    update();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    update();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future onCheckUser() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offAll(LoginScreen());
        } else {
          Get.offAll(HomeScreen());
        }
      });
    });
    update();
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}
