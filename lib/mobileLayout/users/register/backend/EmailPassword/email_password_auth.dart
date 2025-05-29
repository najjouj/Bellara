import 'package:bellaraa/commun/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../frontent/emailPassword/sign_in_screen.dart';

class emailPasswordAuthentification {
  //**********************registration************************************* */

  void emailPasswordSignIN(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(email);
        if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
          //verifyUserEmail();
        }

        // Get.to(() => const RegisterScreen());
      });
    } catch (e) {
      Get.snackbar('Sign in ', e.toString(),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      print(e.toString());
    }
  }

//***********************************register user in firebasefirestore************************** */

  void registerUser(
      String email, String password, String name, String occupation) async {
    String collectionName = occupation + ' accounts';
    try {
      // add the new user information to firebase firestore

      List<String> checkEmail =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      //print(userCredential.user!.displayName);
      if (checkEmail.isEmpty) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // verifyUserEmail();
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(uid)
            .set({
          'name': name,
          'occupation': occupation,
          'photoUrl': Constants.avatarDefault,
          'banner': Constants.bannerDefault,
          'uid': FirebaseAuth.instance.currentUser!.uid,
          'email': email,
          'Invitations envoyées': [],
          'Invitations reçues': [],
          'Invitations supprimées':[],
          'Famille': [],
          'Collègues': [],
          'Administration': [],
          'Enseignants': [],
          'isAuthenticated': true,
          'karma': 0,
          'awards': [
            'awesomeAns',
            'gold',
            'platinum',
            'helpful',
            'plusone',
            'rocket',
            'thankyou',
            'til',
          ]
        }).then((value) => Get.snackbar('Registration', 'registration done!!'));
      } else {
        Get.snackbar('Registration', 'Already registred, sign in!!');
      }
    } catch (e) {
      Get.snackbar('Registration', e.toString());
    }
  }

  //**************************************sign out************************************* */
  void signOutUser() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.snackbar('Sign out', 'done');
    });
  }

  //*********************forgot password********************************************* */
  void forgotpassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then(
            (value) => Get.snackbar('Forgot password',
                'A reset password email was sent to your email adress',
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.deepPurple),
          )
          .then((value) => Get.to(() => const SignInScreen()));
    } catch (e) {
      Get.snackbar('Forgot password', e.toString(),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }
  }
}
