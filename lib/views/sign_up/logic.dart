import 'package:charity_app/views/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SignupController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;

  void SignUp() async{
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "All fields are required!", backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true; //Start loading....

    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await userCredential.user!.updateDisplayName(name);

      await _firestore.collection('charity_users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'userId': userCredential.user!.uid,
      });

      Get.snackbar("Success", "Account Created Successfully!", backgroundColor: Colors.green);

      // Clear Fields
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      Get.offAll(HomeScreen());
    }catch (e) {
      // Error handling
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false; // Stop loading
    }

  }
}