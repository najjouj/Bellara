import 'package:bellaraa/commun/commun/utils.dart';

import 'package:get/get.dart';

class univDBoperations {
  final academiaStore = firestore.collection('academia');
  //****************************************add university********************************** */

  void addUniversity(String gouvernorat, String type, String nom,
      String description, String logoUrl, List galerie) async {
    try {
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('ms')
          .collection('universities')
          .doc(nom.toLowerCase())
          .get();

      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('ms')
            .collection('universities')
            .doc(nom.toLowerCase())
            .set({
          'nom': nom,
          'type': type,
          'description': description,
          'logoUrl': logoUrl,
          'gouvernorat':gouvernorat,
          'galerieUrls': galerie
        }).then((value) => Get.snackbar('University', 'university added'));
      } else {
        Get.snackbar('Erreur', 'Already exist!!');
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
    // You can add data to Firebase Firestore here
  }
}
