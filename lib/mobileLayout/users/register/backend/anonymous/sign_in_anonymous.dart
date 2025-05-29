import 'package:bellaraa/commun/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AnonymousAuth {
  void signInAnonymous() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      
      if (userCredential.additionalUserInfo!.isNewUser) {
     
       
        await FirebaseFirestore.instance
            .collection('AnanymousUsers')
            .doc(userCredential.user!.uid)
            .set({
              'name':'Ghost',
              'photoUrl':Constants.avatarDefault,
              'banner': Constants.bannerDefault,
            'uid': userCredential.user!.uid,
            'isAuthenticated': false,
            'karma': 0,
            'awards': []
            })
            .then((value) {
        
          // EasyLoading.showSuccess('success registration');
          //Get.to(() => const RegisterScreen());
        });
      }
     else{
       print('aready registred');
     }

      //Get.to(() => const RegisterScreen());
    } catch (e) {
      print('some issues here');
      print(e.toString());
    }
  }
}
