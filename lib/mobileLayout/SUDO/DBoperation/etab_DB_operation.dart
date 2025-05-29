import 'package:bellaraa/commun/commun/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class etabDBoperations {
  final academiaStore = firestore.collection('academia');
  //****************************************add me etab********************************** */

  void addEtabME(String nature, String delegationReg, String type, String nom,
      String description, String logoUrl, List galerie) async {
    try {
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('me')
          .collection('etablissements')
          .doc(nom.toLowerCase())
          .get();

      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(nom.toLowerCase())
            .set({
          'nom': nom,
          'nature': nature,
          'type': type,
          'delegation regionale': delegationReg,
          'description': description,
          'logoUrl': logoUrl,
          'galerieUrls': galerie
        }).then((value) => Get.snackbar('Etablissements', 'etab added'));
      } else {
        Get.snackbar('Erreur', 'Already exist!!');
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
    // You can add data to Firebase Firestore here
  }

//************************ */
//*************************update me etab info ************************************************ */

  void etabAddPersonnel(String uid, String name, String poste, String ministere,
      String etab) async {
    String amicale = 'Amicale $etab';
    String news = 'News $etab';
    try {
      if (ministere == 'mf') {
        if (poste == 'Enseignant') {
          await academiaStore
              .doc(ministere)
              .collection('centres de formations')
              .doc(etab.toLowerCase())
              .update({
            'Enseignants': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ]),
          });
        } else {
          await academiaStore
              .doc(ministere)
              .collection('centres de formations')
              .doc(etab.toLowerCase())
              .update({
            'cadres adiministrative': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ]),
          });
        }
        //********************************** */
        var a = await academiaStore
            .doc(ministere)
            .collection('centres de formations')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(amicale)
            .get();
        if (a.exists) {
          await academiaStore
              .doc(ministere)
              .collection('centres de formations')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(amicale)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        } else {
          await academiaStore
              .doc(ministere)
              .collection('centres de formations')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(amicale)
              .set({
            'name': amicale,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        }
        //*************************************************************************** */
        var b = await academiaStore
            .doc(ministere)
            .collection('centres de formations')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(news)
            .get();
        if (b.exists) {
          await academiaStore
              .doc(ministere)
              .collection('centres de formations')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        } else {
          await academiaStore
              .doc(ministere)
              .collection('centres de formations')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .set({
            'name': news,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        }
//*****************************************************************end mf**************************************** */
      } else {
        if (poste == 'Enseignant') {
          await academiaStore
              .doc(ministere)
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .update({
            'Enseignants': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ]),
          });
        } else {
          await academiaStore
              .doc(ministere)
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .update({
            'cadres adiministrative': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ]),
          });
        }
        print('grouuuuuuuuuuuuuuuuups ');
        var a = await academiaStore
            .doc(ministere)
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(amicale)
            .get();
        if (a.exists) {
          await academiaStore
              .doc(ministere)
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(amicale)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        } else {
          await academiaStore
              .doc(ministere)
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(amicale)
              .set({
            'name': amicale,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        }
        //*********************************************************************** */
        var b = await academiaStore
            .doc(ministere)
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(news)
            .get();
        if (b.exists) {
          await academiaStore
              .doc(ministere)
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        } else {
          await academiaStore
              .doc(ministere)
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .set({
            'name': news,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'poste': poste,
                'année': DateTime.now().year
              }
            ])
          });
        }
      }
    } catch (e) {
      Get.snackbar('Ajouter un personnel', e.toString());
    }
  }

//****************ajouter eleve me etab *****************************/

  void etabAddEleve(String uid, String name, String niveau, String speciality,
      String natureEtabActuel, String etab, String centre) async {
    if (natureEtabActuel == 'Centre de formation') {
      String news = 'News $centre';
      //String nivGroup = 'Groupe $niveau';
      try {
        await academiaStore
            .doc('mf')
            .collection('centres de formations')
            .doc(centre.toLowerCase())
            .update({
          'élèves': FieldValue.arrayUnion([
            {
              'uid': uid,
              'nom': name,
              'specialité': speciality,
              'année': DateTime.now().year
            }
          ]),
        });
        //********************************************************** */
        var a = await academiaStore
            .doc('mf')
            .collection('centres de formations')
            .doc(centre.toLowerCase())
            .collection('Groupes')
            .doc(news)
            .get();
        if (a.exists) {
          await academiaStore
              .doc('mf')
              .collection('centres de formations')
              .doc(centre.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'statut': 'élève',
                'année': DateTime.now().year
              }
            ])
          });
        } else {
          await academiaStore
              .doc('mf')
              .collection('centres de formations')
              .doc(centre.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .set({
            'name': news,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'statut': 'élève',
                'année': DateTime.now().year
              }
            ])
          });
        }
      } catch (e) {
        print(e.toString() + 'ppppppppppppppb');
      }
    } else {
      String news = 'News $etab';
      String nivGroup = 'Groupe $niveau';
      try {
        await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .update({
          'élèves': FieldValue.arrayUnion([
            {
              'uid': uid,
              'nom': name,
              'niveau': niveau,
              'année': DateTime.now().year
            }
          ]),
        });
        var a = await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(nivGroup)
            .get();
        if (a.exists) {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(nivGroup)
              .update({
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'statut': 'élève'}
            ])
          });
        } else {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(nivGroup)
              .set({
            'name': nivGroup,
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'statut': 'élève'}
            ])
          });
        }
        //******************************************************************* */
        var b = await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(news)
            .get();
        if (b.exists) {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .update({
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'poste': 'élève'}
            ])
          });
        } else {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(etab.toLowerCase())
              .collection('Groupes')
              .doc(news)
              .set({
            'name': news,
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'poste': 'élève'}
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Ajouter un personnel', e.toString());
      }
    }
  }

//*******************ajouter etudiant ************************************** */

  void etabAddEtudiant(
      String uid,
      String name,
      String niveau,
      String speciality,
      String natureEtabActuel,
      String etab,
      String centre) async {
    String news = 'News $etab';

    try {
      await academiaStore
          .doc('ms')
          .collection('etablissements')
          .doc(etab.toLowerCase())
          .update({
        'etudiants': FieldValue.arrayUnion([
          {
            'uid': uid,
            'nom': name,
            'specialité': speciality,
            'année': DateTime.now().year
          }
        ]),
      });

      //******************************************************************* */
      var b = await academiaStore
          .doc('ms')
          .collection('etablissements')
          .doc(etab.toLowerCase())
          .collection('Groupes')
          .doc(news)
          .get();
      if (b.exists) {
        await academiaStore
            .doc('ms')
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(news)
            .update({
          'membres': FieldValue.arrayUnion([
            {
              'uid': uid,
              'nom': name,
              'statut': 'etudiant',
              'specialité': speciality,
              'année': DateTime.now().year
            }
          ])
        });
      } else {
        await academiaStore
            .doc('ms')
            .collection('etablissements')
            .doc(etab.toLowerCase())
            .collection('Groupes')
            .doc(news)
            .set({
          'name': news,
          'membres': FieldValue.arrayUnion([
            {
              'uid': uid,
              'nom': name,
              'statut': 'etudiant',
              'specialité': speciality,
              'année': DateTime.now().year
            }
          ])
        });
      }
    } catch (e) {
      Get.snackbar('Ajouter un etudiant', e.toString());
    }
  }

//*********************************************************** */

  //*******************add amicale membre cadre adiminstrative ******************** */
  void amicaleAddmembreCadre(
      String uid,
      String name,
      String ep,
      String epAnnee,
      String college,
      String collegeAnnee,
      String lycee,
      String lyceeAnnee,
      String univEtab,
      String univEtabAnnee) async {
    //***************ecole ************************* */

    if (ep != '') {
      String amicaleEp = 'Amicale $ep';

      try {
        var a = await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(ep.toLowerCase())
            .collection('Groupes')
            .doc(amicaleEp)
            .get();
        if (a.exists) {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(ep.toLowerCase())
              .collection('Groupes')
              .doc(amicaleEp)
              .update({
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': epAnnee}
            ])
          });
        } else {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(ep.toLowerCase())
              .collection('Groupes')
              .doc(amicaleEp)
              .set({
            'name': amicaleEp,
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': epAnnee}
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Amicale', e.toString());
        print('Amicale');
        print(e.toString());
      }
    }
    //***************lycee ********************************* */
    if (college != '') {
      String amicalecollege = 'Amicale $college';
      print(amicalecollege);
      try {
        var a = await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(college.toLowerCase())
            .collection('Groupes')
            .doc(amicalecollege)
            .get();
        if (a.exists) {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(college.toLowerCase())
              .collection('Groupes')
              .doc(amicalecollege)
              .update({
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': collegeAnnee}
            ])
          });
        } else {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(college.toLowerCase())
              .collection('Groupes')
              .doc(amicalecollege)
              .set({
            'name': amicalecollege,
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': collegeAnnee}
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Amicale', e.toString());
      }
    }
    //************************* lycee ************************* */
    if (lycee != '') {
      String amicaleLycee = 'Amicale $lycee';
      print(amicaleLycee);
      try {
        var a = await academiaStore
            .doc('me')
            .collection('etablissements')
            .doc(lycee.toLowerCase())
            .collection('Groupes')
            .doc(amicaleLycee)
            .get();
        if (a.exists) {
          await academiaStore
              .doc('me')
              .collection('etablissements')
              .doc(lycee.toLowerCase())
              .collection('Groupes')
              .doc(amicaleLycee)
              .update({
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': lyceeAnnee}
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Amicale', e.toString());
      }
    }
    //************************* univ etab ************************* */
    if (univEtab != '') {
      String amicaleUniv = 'Amicale $univEtab';
      print(amicaleUniv);
      try {
        var a = await academiaStore
            .doc('ms')
            .collection('etablissements')
            .doc(univEtab.toLowerCase())
            .collection('Groupes')
            .doc(amicaleUniv)
            .get();
        if (a.exists) {
          await academiaStore
              .doc('ms')
              .collection('etablissements')
              .doc(univEtab.toLowerCase())
              .collection('Groupes')
              .doc(amicaleUniv)
              .update({
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': univEtabAnnee}
            ])
          });
        } else {
          await academiaStore
              .doc('ms')
              .collection('etablissements')
              .doc(univEtab.toLowerCase())
              .collection('Groupes')
              .doc(amicaleUniv)
              .set({
            'name': amicaleUniv,
            'membres': FieldValue.arrayUnion([
              {'uid': uid, 'nom': name, 'année': univEtabAnnee}
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Amicale', e.toString());
      }
    }
  }

//************************add mf etab******************************************* */

  void addEtabMF(String nature, String gouv, String type, String nom,
      String description, String logoUrl, List galerie) async {
    try {
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('mf')
          .collection('centres de formations')
          .doc(nom.toLowerCase())
          .get();

      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('mf')
            .collection('centres de formations')
            .doc(nom.toLowerCase())
            .set({
          'nom': nom,
          'nature': nature,
          'type': type,
          'gouvernorat': gouv,
          'description': description,
          'logoUrl': logoUrl,
          'galerieUrls': galerie
        }).then((value) => Get.snackbar("Centres de formations", 'etab added'));
      } else {
        Get.snackbar('Erreur', 'Already exist!!');
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
    // You can add data to Firebase Firestore here
  }

  List<String> verifCentreGouv(
    String gouvernorat,
  ) {
    List<String> centres = [];
    try {
      if (gouvernorat != '') {
        academiaStore
            .doc('mf')
            .collection('centres de formations')
            .where('gouvernorat', isEqualTo: gouvernorat)
            .get()
            .then(((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print(doc['nom'] + 'kkkkkkkk');
            centres.add(doc['nom']);
          });
        }));
      } else {
        academiaStore
            .doc('mf')
            .collection('centres de formations')
            .get()
            .then(((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            print(doc['nom'] + 'kkkkkkkk');
            centres.add(doc['nom']);
          });
        }));
      }
      return centres;
    } catch (e) {
      print(e.toString());
    }
    return centres;
  }
  //**************************************add ms etab ***************************** */

  void addEtabMS(String nature, String univ, String type, String nom,
      String description, String logoUrl, List galerie) async {
    try {
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('ms')
          .collection('etablissements')
          .doc(nom.toLowerCase())
          .get();

      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('ms')
            .collection('etablissements')
            .doc(nom.toLowerCase())
            .set({
          'nom': nom,
          'nature': nature,
          'type': type,
          'université': univ,
          'description': description,
          'logoUrl': logoUrl,
          'galerieUrls': galerie
        }).then((value) => Get.snackbar('Etablissements', 'etab added'));
      } else {
        Get.snackbar('Erreur', 'Already exist!!');
      }
    } catch (e) {
      Get.snackbar('Erreur', e.toString());
    }
    // You can add data to Firebase Firestore here
  }
}
