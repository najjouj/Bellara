import 'package:bellaraa/commun/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      // Specify the scopes you need
      );
  void googleSignIn() async {
    try {
      //await _googleSignIn
      print('lets staaaaaaaaaaart');
      await _googleSignIn.signIn(); // Initiates the Google Sign-In flow
      print('we are here!!');
      // Handle successful sign-in here
      _handleSignIn();
    } catch (error) {
      // Handle sign-in error here
      print('sign in$error');
    }
  }

//******************************************************************************************** */
  void _handleSignIn() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      // Handle user sign-in here
      if (account != null) {
        // Successful sign-in
        print('successsssssssssss');
      } else {
        // Sign-out or error
        print('erreeeeeeeeeeeeur');
      }
    });
  }

//******************************************************************************************************* */
  void handleSignOut() async {
    await _googleSignIn.signOut();
    // Perform any other necessary operations after sign-out
  }

//************************************************************************************************ */
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //***********************************second try********************* */
  registerInWithGoogle() async {
    //begin interactive sign in process
    print('google account');
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details from request
    print('google auth');
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);
    print('google credential${gUser.displayName}');
    //gUser.
    //finally, let's sign in
    //register user********************************
    registerUser(
        gUser.displayName.toString(), gUser.email, gUser.photoUrl.toString());
    print('user added');
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //***************************register user***********************************
  void registerUser(
    String name,
    String email,
    String photoUrl,
  ) async {
    String uid;

    //auth step

    uid = FirebaseAuth.instance.currentUser!.uid;
    //store profile photo

    // add the new user information to firebase firestore

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'photoUrl': photoUrl,
        'email': email,
      }).then((value) {
        // Get.to(() => EcolePrimaireHomeScreen());
      });
    } catch (e) {
      print('adding new user failed');
      print(e.toString());
    }
  }

  //********************************advanced method************************************ */
  void signInWithGoogleAccount() async {
    try {
      final UserCredential userCredential;

      if (kIsWeb) {
        GoogleAuthProvider googleprovider = GoogleAuthProvider();
        googleprovider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        userCredential =
            await FirebaseAuth.instance.signInWithPopup(googleprovider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final googleAuth = (await googleUser?.authentication);
        final cred = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        userCredential = await FirebaseAuth.instance.signInWithCredential(cred);
        print(userCredential.user!.displayName);
        if (userCredential.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance
              .collection('Googleusers')
              .doc(userCredential.user!.uid)
              .set({
            'name': userCredential.user!.displayName ?? 'no name',
            'photoUrl':
                userCredential.user!.photoURL ?? Constants.avatarDefault,
            'banner': Constants.bannerDefault,
            'uid': userCredential.user!.uid,
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
          });
        } else {
          print('aready registred');
        }
      }

      // Get.to(() => const RegisterScreen());
      /* DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('Googleusers')
          .doc(userCredential.user!.uid)
          .get();
      GUserModel usr = GUserModel.fromSnap(snap);*/
    } catch (e) {
      print(e.toString());
      // EasyLoading.showError('registration failed!');
    }
  }
}
