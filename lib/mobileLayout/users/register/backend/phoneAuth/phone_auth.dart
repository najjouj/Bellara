import 'package:bellaraa/commun/constants/constants.dart';
import 'package:bellaraa/mobileLayout/users/register/frontent/phoneAuth/OTPS_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class PhoneAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //sign in with a phone number

  void signInWithPhone(String phoneNumber) async {
    try {
      //******************************registration****************************** */
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: ((error) {
            Get.snackbar('Phone verification', error.message.toString());

            throw Exception(error.message);
          }),
          codeSent: (String verificationId, int? resendToken) async {
            Get.to(() => OTPSScreen(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
      // var recaptcha =  auth.RecaptchaVerifier('recaptcha-container');
      await auth.signInWithPhoneNumber(phoneNumber).then((value) {
        Get.snackbar('phone registration', 'already registred');
        /*  Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => MobileScreenLayout(
                currentuser: FirebaseAuth.instance.currentUser!.uid)))); */
      });
    } on FirebaseAuthException catch (e) {
      print('problem somwhere!!');
      print(e.toString());
    }
  }

  void verifyOtTP(
      String verificationId, String userOTP, String phonenumber) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      Get.snackbar('Phone verification', 'done');
      addUserToDataBase();
      //Get.to(() => const RegisterScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Phone verification', e.toString());
    }
  }
//*****************************************add user to firebase database */

  void addUserToDataBase() async {
    try {
      // add the new user information to firebase firestore

      // verifyUserEmail();
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('PhoneAuthUsers')
          .doc(uid)
          .set({
        'name': 'no name',
        'photoUrl': Constants.avatarDefault,
        'banner': Constants.bannerDefault,
        'uid': FirebaseAuth.instance.currentUser!.uid,
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
      }).then((value) =>
              Get.snackbar('database Registration', 'registration done!!'));
    } catch (e) {
      Get.snackbar('Registration', e.toString());
    }
  }

  void SignOut() {
    auth.signOut();
    // Get.to(() => const RegisterScreen());
  }
}
