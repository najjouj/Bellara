import 'package:bellaraa/commun/commun/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class welcomeDBInfo {
  final admCadres = firestore.collection('Cadre administrative accounts');
  final eleves = firestore.collection('Eleve accounts');
  final etudiants = firestore.collection('Etudiant accounts');
  final parents = firestore.collection('Parent accounts');
  final enseignants = firestore.collection('Enseignant accounts');
  final academia = FirebaseFirestore.instance.collection('academia');

  //***********************parent ************************************ */

  void parentWelcomeInfo(
      String uid,
      String nom,
      String avatarUrl,
      String bannerUrl,
      List eLeves,
      List eTudiants,
      String nivScolaire,
      String profession,
      String amicalEP,
      String amicalCollege,
      String amicalLycee,
      String amicalUnivEtab) async {
    List invitations = [];
    invitations.addAll(eLeves);
    invitations.addAll(eTudiants);
    String day = DateTime.now().day.toString();
    String month = DateTime.now().month.toString();
    String year = DateTime.now().year.toString();
    var parentInv = {
      'uid': uid,
      'nom': nom,
      'photoUrl': avatarUrl,
      'statut': 'Parent',
      'date': '$year/$month/$day'
    };
    try {
      await parents.doc(uid).update({
        if (bannerUrl != '') 'banner': bannerUrl,
        if (avatarUrl != '') 'photoUrl': avatarUrl,
        'poste': profession,
        'Invitations envoyées': FieldValue.arrayUnion(invitations),
        'niveau scolaire': nivScolaire,
        if (amicalEP != '')
          'amicales ecole primaire': FieldValue.arrayUnion([amicalEP]),
        if (amicalCollege != '')
          'amicales collèges': FieldValue.arrayUnion([amicalCollege]),
        if (amicalLycee != '')
          'amicales lycées': FieldValue.arrayUnion([amicalLycee]),
        if (amicalUnivEtab != '')
          'amicales etablissements universitaires':
              FieldValue.arrayUnion([amicalUnivEtab]),
      });
    } catch (e) {
      Get.snackbar('Welcome information', e.toString());
      print('parent profile erreurs' + e.toString());
    }
    try {
      //**********************************les eleves ******************************************** */
      for (int i = 0; i < eLeves.length; i++) {
        await eleves.doc(eLeves[i]['uid']).update({
          'Invitations reçues': FieldValue.arrayUnion([parentInv])
        });
      }
      //**********************************les etudiants ******************************************* */
      for (int i = 0; i < eTudiants.length; i++) {
        await etudiants.doc(eTudiants[i]['uid']).update({
          'Invitations reçues': FieldValue.arrayUnion([parentInv])
        });
      }
    } catch (e) {
      Get.snackbar(
          'Welcome information, gestion des invitations', e.toString());
      print('parent : gestion des invitations,erreurs.....' + e.toString());
    }
  }

  //****************************cadre administrative ****welcome info */

  void cadreWelcomeInfo(
      String uid,
      String avatarUrl,
      String bannerUrl,
      String ministere,
      String poste,
      String etabActuel,
      String amicalEP,
      String amicalCollege,
      String amicalLycee,
      String amicalUnivEtab) async {
    try {
      await admCadres.doc(uid).update({
        if (bannerUrl != '') 'banner': bannerUrl,
        if (avatarUrl != '') 'photoUrl': avatarUrl,
        'poste': poste,
        'etablissement actuel': etabActuel,
        if (amicalEP != '')
          'amicales ecole primaire': FieldValue.arrayUnion([amicalEP]),
        if (amicalCollege != '')
          'amicales collèges': FieldValue.arrayUnion([amicalCollege]),
        if (amicalLycee != '')
          'amicales lycées': FieldValue.arrayUnion([amicalLycee]),
        if (amicalUnivEtab != '')
          'amicales etablissements universitaires':
              FieldValue.arrayUnion([amicalUnivEtab]),
      });
    } catch (e) {
      Get.snackbar('Welcome information', e.toString());
    }
  }

//*******************welcome eleve info *********************************** */

  void eleveWelcomeInfo(
      String uid,
      String name,
      String avatarUrl,
      String bannerUrl,
      String niveau,
      String speciality,
      String natureEtab,
      String etabActuel,
      String centre,
      String amicalEP,
      String amicalCollege,
      String amicalLycee,
      String amicalUnivEtab) async {
    if (natureEtab == 'Centre de formation') {
      String nivgroup = 'Groupe $speciality';
      try {
        await eleves.doc(uid).update({
          if (bannerUrl != '') 'banner': bannerUrl,
          if (avatarUrl != '') 'photoUrl': avatarUrl,
          'etablissement actuel': centre,
          'niveau scolaire': niveau,
          'specialité': speciality,
          if (amicalEP != '')
            'amicales ecole primaire': FieldValue.arrayUnion([amicalEP]),
          if (amicalCollege != '')
            'amicales collèges': FieldValue.arrayUnion([amicalCollege]),
          if (amicalLycee != '')
            'amicales lycées': FieldValue.arrayUnion([amicalLycee]),
          if (amicalUnivEtab != '')
            'amicales etablissements universitaires':
                FieldValue.arrayUnion([amicalUnivEtab]),
        });
      } catch (e) {
        Get.snackbar('Welcome information', e.toString());
        print('Welcome information');
        print(e.toString());
      }

      try {
        var a = await FirebaseFirestore.instance
            .collection('academia')
            .doc('mf')
            .collection('specialités')
            .doc(speciality.toLowerCase())
            .collection('Groupes')
            .doc(nivgroup)
            .get();
        if (a.exists) {
          await FirebaseFirestore.instance
              .collection('academia')
              .doc('mf')
              .collection('specialités')
              .doc(speciality.toLowerCase())
              .collection('Groupes')
              .doc(nivgroup)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'statut': 'élève',
                'année': DateTime.now().year,
              }
            ])
          });
        } else {
          await FirebaseFirestore.instance
              .collection('academia')
              .doc('mf')
              .collection('specialités')
              .doc(speciality.toLowerCase())
              .collection('Groupes')
              .doc(nivgroup)
              .set({
            'nom de goupe': nivgroup,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'statut': 'élève',
                'année': DateTime.now().year,
              }
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Groupe $niveau', 'Add membre ' + e.toString());
      }
    } else {
      String nivgroup = 'Groupe $niveau';
      try {
        await eleves.doc(uid).update({
          if (bannerUrl != '') 'banner': bannerUrl,
          if (avatarUrl != '') 'photoUrl': avatarUrl,
          'etablissement actuel': etabActuel,
          'niveau scolaire': niveau,
          'specialité': speciality,
          if (amicalEP != '')
            'amicales ecole primaire': FieldValue.arrayUnion([amicalEP]),
          if (amicalCollege != '')
            'amicales collèges': FieldValue.arrayUnion([amicalCollege]),
          if (amicalLycee != '')
            'amicales lycées': FieldValue.arrayUnion([amicalLycee]),
          if (amicalUnivEtab != '')
            'amicales etablissements universitaires':
                FieldValue.arrayUnion([amicalUnivEtab]),
        });
      } catch (e) {
        Get.snackbar('Welcome information', e.toString());
        print('Welcome information');
        print(e.toString());
      }
      try {
        var a = await FirebaseFirestore.instance
            .collection('academia')
            .doc('me')
            .collection('niveaux scolaire')
            .doc(niveau.toLowerCase())
            .collection('Groupes')
            .doc(nivgroup)
            .get();
        if (a.exists) {
          await FirebaseFirestore.instance
              .collection('academia')
              .doc('me')
              .collection('niveaux scolaire')
              .doc(niveau.toLowerCase())
              .collection('Groupes')
              .doc(nivgroup)
              .update({
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'statut': 'élève',
                'année': DateTime.now().year,
              }
            ])
          });
        } else {
          await FirebaseFirestore.instance
              .collection('academia')
              .doc('me')
              .collection('niveaux scolaire')
              .doc(niveau.toLowerCase())
              .collection('Groupes')
              .doc(nivgroup)
              .set({
            'nom de goupe': nivgroup,
            'membres': FieldValue.arrayUnion([
              {
                'uid': uid,
                'nom': name,
                'statut': 'élève',
                'année': DateTime.now().year,
              }
            ])
          });
        }
      } catch (e) {
        Get.snackbar('Groupe $niveau', 'Add membre ' + e.toString());
      }

      try {
        var matieres = await FirebaseFirestore.instance
            .collection('academia')
            .doc('me')
            .collection('niveaux scolaire')
            .doc(niveau.toLowerCase())
            .collection('matieres')
            .get();
        //print(matieres.docs.length.toString() + 'matieres groups');
        for (int i = 0; i < matieres.docs.length; i++) {
          String subject = matieres.docs[i]['matière'];
          String matGroup = 'Groupe $subject';
          var a = await FirebaseFirestore.instance
              .collection('academia')
              .doc('me')
              .collection('niveaux scolaire')
              .doc(niveau.toLowerCase())
              .collection('matieres')
              .doc(subject.toLowerCase())
              .collection('Groupes')
              .doc(matGroup)
              .get();
          if (a.exists) {
            await FirebaseFirestore.instance
                .collection('academia')
                .doc('me')
                .collection('niveaux scolaire')
                .doc(niveau.toLowerCase())
                .collection('matieres')
                .doc(subject.toLowerCase())
                .collection('Groupes')
                .doc(matGroup)
                .update({
              'membres': FieldValue.arrayUnion([
                {
                  'uid': uid,
                  'nom': name,
                  'statut': 'élève',
                  'niveau': niveau,
                  'année': DateTime.now().year,
                }
              ])
            });
          } else {
            await FirebaseFirestore.instance
                .collection('academia')
                .doc('me')
                .collection('niveaux scolaire')
                .doc(niveau.toLowerCase())
                .collection('matieres')
                .doc(subject.toLowerCase())
                .collection('Groupes')
                .doc(matGroup)
                .set({
              'nom groupe': matGroup,
              'membres': FieldValue.arrayUnion([
                {
                  'uid': uid,
                  'nom': name,
                  'statut': 'élève',
                  'niveau': niveau,
                  'année': DateTime.now().year,
                }
              ])
            });
          }
        }
      } catch (e) {
        print('problem somewhere: ' + e.toString());
      }
    }
  }

//*******************welcome etudiant info *********************************** */
  void getSubjects(Function callbackSubjects) async {
    List<String> specialities = [];
    List<String> pe = [];
    List<String> ee = [];

    var a = await FirebaseFirestore.instance
        .collection('academia')
        .doc('ms')
        .collection('specialités')
        .get();
    for (int i = 0; i < a.docs.length; i++) {
      specialities.add(a.docs[i]['specialité']);
      //************specilities***** */
      var b = await FirebaseFirestore.instance
          .collection('academia')
          .doc('ms')
          .collection('specialités')
          .doc(a.docs[i]['specialité'])
          .collection("plan d'etude")
          .get();
      for (int i = 0; i < b.docs.length; i++) {
        pe.add(b.docs[i]['libellé']);
        //***********plan d'etude ************* */
        var c = await FirebaseFirestore.instance
            .collection('academia')
            .doc('ms')
            .collection('specialités')
            .doc(a.docs[i]['specialité'])
            .collection("plan d'etude")
            .doc(b.docs[i]['libellé'])
            .collection("elements d'enseignment")
            .get();
        for (int i = 0; i < c.docs.length; i++) {
          ee.add(c.docs[i]['libellé']);
        }
      }
    }
    callbackSubjects(ee);
  }

//****************************************************************************************** */

  void etudiantWelcomeInfo(
      String uid,
      String name,
      String avatarUrl,
      String bannerUrl,
      String niveau,
      String speciality,
      String natureEtab,
      String etabActuel,
      String semestre,
      String amicalEP,
      String amicalCollege,
      String amicalLycee,
      String amicalUnivEtab) async {
    String specialityGroup = 'Groupe $speciality';
    try {
      await etudiants.doc(uid).update({
        if (bannerUrl != '') 'banner': bannerUrl,
        if (avatarUrl != '') 'photoUrl': avatarUrl,
        'etablissement actuel': etabActuel,
        'specialité': speciality,
        'niveau scolaire': niveau,
        if (amicalEP != '')
          'amicales ecole primaire': FieldValue.arrayUnion([amicalEP]),
        if (amicalCollege != '')
          'amicales collèges': FieldValue.arrayUnion([amicalCollege]),
        if (amicalLycee != '')
          'amicales lycées': FieldValue.arrayUnion([amicalLycee]),
        if (amicalUnivEtab != '')
          'amicales etablissements universitaires':
              FieldValue.arrayUnion([amicalUnivEtab]),
      });
    } catch (e) {
      Get.snackbar('Welcome information etudiant', e.toString());
      print('Welcome information');
      print(e.toString());
    }
    try {
      var a = await FirebaseFirestore.instance
          .collection('academia')
          .doc('ms')
          .collection('specialités')
          .doc(speciality.toLowerCase())
          .collection('Groupes')
          .doc(specialityGroup)
          .get();
      if (a.exists) {
        await FirebaseFirestore.instance
            .collection('academia')
            .doc('ms')
            .collection('specialités')
            .doc(speciality.toLowerCase())
            .collection('Groupes')
            .doc(specialityGroup)
            .update({
          'membres': FieldValue.arrayUnion([
            {
              'uid': uid,
              'nom': name,
              'statut': 'etudiant',
              'semestre': semestre,
              'année': DateTime.now().year,
            }
          ])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('academia')
            .doc('ms')
            .collection('specialités')
            .doc(speciality.toLowerCase())
            .collection('Groupes')
            .doc(specialityGroup)
            .set({
          'nom de goupe': specialityGroup,
          'membres': FieldValue.arrayUnion([
            {
              'uid': uid,
              'nom': name,
              'statut': 'etudiant',
              'semestre': semestre,
              'année': DateTime.now().year,
            }
          ])
        });
      }
    } catch (e) {
      Get.snackbar('Groupe $niveau', 'Add membre ' + e.toString());
    }

    try {
      //********************accées au plan d'etude *************************************** */
      var planEtudes = await FirebaseFirestore.instance
          .collection('academia')
          .doc('ms')
          .collection('specialités')
          .doc(speciality.toLowerCase())
          .collection("plan d'etude")
          .where('semestre', isEqualTo: semestre)
          .get();
      //print(matieres.docs.length.toString() + 'matieres groups');
      List<String> libs = [];
      //****************recuperation des libs of plan d'etude******** */
      for (int i = 0; i < planEtudes.docs.length; i++) {
        libs.add(planEtudes.docs[i]['libellé']);
      }
      //String matGroup = 'Groupe $subject';
      //*********************ends of libs************************** */
      for (int i = 0; i < libs.length; i++) {
        var elts = await FirebaseFirestore.instance
            .collection('academia')
            .doc('ms')
            .collection('specialités')
            .doc(speciality.toLowerCase())
            .collection("plan d'etude")
            .doc(libs[i])
            .collection("element d'enseignment")
            .get();
        print('hellooooooooooooooooooooo2' + elts.docs.length.toString());
        for (int j = 0; j < elts.docs.length; j++) {
          String lib = elts.docs[j]['libellé'];

          String eltGroup = 'Groupe $lib';

          var snap = await FirebaseFirestore.instance
              .collection('academia')
              .doc('ms')
              .collection('specialités')
              .doc(speciality.toLowerCase())
              .collection("plan d'etude")
              .doc(libs[i])
              .collection("element d'enseignment")
              .doc(elts.docs[j]['libellé'])
              .collection('Groupes')
              .doc(eltGroup)
              .get();

          if (snap.exists) {
            await FirebaseFirestore.instance
                .collection('academia')
                .doc('ms')
                .collection('specialités')
                .doc(speciality.toLowerCase())
                .collection("plan d'etude")
                .doc(libs[i])
                .collection("element d'enseignment")
                .doc(elts.docs[j]['libellé'])
                .collection('Groupes')
                .doc(eltGroup)
                .update({
              'membres': FieldValue.arrayUnion([
                {
                  'uid': uid,
                  'nom': name,
                  'statut': 'etudiant',
                  'niveau': semestre,
                  'année': DateTime.now().year,
                }
              ])
            });
          } else {
            await FirebaseFirestore.instance
                .collection('academia')
                .doc('ms')
                .collection('specialités')
                .doc(speciality.toLowerCase())
                .collection("plan d'etude")
                .doc(libs[i])
                .collection("element d'enseignment")
                .doc(elts.docs[j]['libellé'])
                .collection('Groupes')
                .doc(eltGroup)
                .set({
              'nom groupe': eltGroup,
              'membres': FieldValue.arrayUnion([
                {
                  'uid': uid,
                  'nom': name,
                  'statut': 'etudiant',
                  'niveau': semestre,
                  'année': DateTime.now().year,
                }
              ])
            });
          }
        }
      }
      //**********************ends of elements groups ***************************************** */
    } catch (e) {
      print('problem somewhere: ' + e.toString());
    }
  }

//************************************************** ajouter ***********************enseignant ********************/

  void enseignantWelcomeInfo(
      String uid,
      String name,
      String avatarUrl,
      String bannerUrl,
      String minsitere,
      List<String> mEsubjects,
      List<String> mFsubjects,
      List<String> mSsubjects,
      String natureEtab,
      String etabActuel,
      String amicalEP,
      String amicalCollege,
      String amicalLycee,
      String amicalUnivEtab) async {
    try {
      await enseignants.doc(uid).update({
        if (bannerUrl != '') 'banner': bannerUrl,
        if (avatarUrl != '') 'photoUrl': avatarUrl,
        'etablissement actuel': etabActuel,
        'ministère': minsitere,
        'nom': name,
        if (amicalEP != '')
          'amicales ecole primaire': FieldValue.arrayUnion([amicalEP]),
        if (amicalCollege != '')
          'amicales collèges': FieldValue.arrayUnion([amicalCollege]),
        if (amicalLycee != '')
          'amicales lycées': FieldValue.arrayUnion([amicalLycee]),
        if (amicalUnivEtab != '')
          'amicales etablissements universitaires':
              FieldValue.arrayUnion([amicalUnivEtab]),
      });
    } catch (e) {
      Get.snackbar('Welcome information teacher', e.toString());
      print('Welcome information');
      print(e.toString());
    }
    //**************************************************ms************************************************************************* */
    if (minsitere == 'ms') {
      print('first step ms');
      try {
        var a = await FirebaseFirestore.instance
            .collection('academia')
            .doc('ms')
            .collection('specialités')
            .get();
        if (a.docs.isNotEmpty) {
          print('spppppppppppppppppppppppppppppppppp is not empty' +
              a.docs.length.toString());
          for (int i = 0; i < a.docs.length; i++) {
            String sp = a.docs[i]['specialité'];
            print(sp);
            var b = await FirebaseFirestore.instance
                .collection('academia')
                .doc('ms')
                .collection('specialités')
                .doc(sp.toLowerCase())
                .collection("plan d'etude")
                .get();
            print('jjjjjjjjjjjjj' + b.docs.length.toString());
            if (b.docs.isNotEmpty) {
              print("plan d'etudeeeeeeeeeeeeeeeeee");
              for (int j = 0; j < b.docs.length; j++) {
                if (mSsubjects.isNotEmpty) {
                  for (int k = 0; k < mSsubjects.length; k++) {
                    String lib = mSsubjects[k];
                    print('element courant');
                    print(lib);
                    String eltGroup = 'Groupe $lib';
                    var d = await FirebaseFirestore.instance
                        .collection('academia')
                        .doc('ms')
                        .collection('specialités')
                        .doc(sp.toLowerCase())
                        .collection("plan d'etude")
                        .doc(b.docs[j]['libellé'])
                        .collection("element d'enseignment")
                        .doc(lib)
                        .collection('Groupes')
                        .doc(eltGroup)
                        .get();
                    if (d.exists) {
                      print('we are heeeeeeeeeeeeeeeeeeeere elts exist');
                      print(lib);
                      print(eltGroup);
                      await FirebaseFirestore.instance
                          .collection('academia')
                          .doc('ms')
                          .collection('specialités')
                          .doc(sp.toLowerCase())
                          .collection("plan d'etude")
                          .doc(b.docs[j]['libellé'])
                          .collection("element d'enseignment")
                          .doc(lib)
                          .collection('Groupes')
                          .doc(eltGroup)
                          .update({
                        'membres': FieldValue.arrayUnion([
                          {
                            'uid': uid,
                            'nom': name,
                            'statut': 'Enseignant',
                            'année': DateTime.now().year,
                          }
                        ])
                      });
                    } else {
                      print('we are here new elt group');
                      print(lib);
                      print(eltGroup);
                      await FirebaseFirestore.instance
                          .collection('academia')
                          .doc('ms')
                          .collection('specialités')
                          .doc(sp.toLowerCase())
                          .collection("plan d'etude")
                          .doc(b.docs[j]['libellé'])
                          .collection("element d'enseignment")
                          .doc(lib)
                          .collection('Groupes')
                          .doc(eltGroup)
                          .set({
                        'nom groupe': eltGroup,
                        'membres': FieldValue.arrayUnion([
                          {
                            'uid': uid,
                            'nom': name,
                            'statut': 'Enseignant',
                            'année': DateTime.now().year,
                          }
                        ])
                      });
                    }
                  }
                }
              }
            }
          }
        }
        //**********************ends of elements groups ***************************************** */
      } catch (e) {
        print('problem somewhere: ' + e.toString());
      }
    } else if (minsitere == 'mf') {
      print('first step mf');
      try {
        var a = await FirebaseFirestore.instance
            .collection('academia')
            .doc('mf')
            .collection('specialités')
            .get();
        if (a.docs.isNotEmpty) {
          print('spppppppppppppppppppppppppppppppppp is not empty' +
              a.docs.length.toString());
          for (int i = 0; i < a.docs.length; i++) {
            String sp = a.docs[i]['specialité'];
            print(sp);
            var b = await FirebaseFirestore.instance
                .collection('academia')
                .doc('mf')
                .collection('specialités')
                .doc(sp.toLowerCase())
                .collection('modules')
                .get();
            print('jjjjjjjjjjjjj' + b.docs.length.toString());
            if (b.docs.isNotEmpty) {
              print('moduleeeeeeeeeeeeeeeeeeeeees');
              for (int j = 0; j < b.docs.length; j++) {
                if (mFsubjects.isNotEmpty) {
                  for (int k = 0; k < mFsubjects.length; k++) {
                    String lib = mFsubjects[k];
                    print('unitteeeeeeeeeeeeeeeeee');
                    print(lib);
                    String eltGroup = 'Groupe $lib';
                    var d = await FirebaseFirestore.instance
                        .collection('academia')
                        .doc('mf')
                        .collection('specialités')
                        .doc(sp.toLowerCase())
                        .collection('modules')
                        .doc(b.docs[j]['libellé'])
                        .collection('unités')
                        .doc(lib)
                        .collection('Groupes')
                        .doc(eltGroup)
                        .get();
                    if (d.exists) {
                      print(
                          'we are heeeeeeeeeeeeeeeeeeeere unité groupe exist');
                      print(lib);
                      print(eltGroup);
                      await FirebaseFirestore.instance
                          .collection('academia')
                          .doc('mf')
                          .collection('specialités')
                          .doc(sp.toLowerCase())
                          .collection('modules')
                          .doc(b.docs[j]['libellé'])
                          .collection('unités')
                          .doc(lib)
                          .collection('Groupes')
                          .doc(eltGroup)
                          .update({
                        'membres': FieldValue.arrayUnion([
                          {
                            'uid': uid,
                            'nom': name,
                            'statut': 'Enseignant',
                            'année': DateTime.now().year,
                          }
                        ])
                      });
                    } else {
                      print('we are here new unité group');
                      print(lib);
                      print(eltGroup);
                      await FirebaseFirestore.instance
                          .collection('academia')
                          .doc('mf')
                          .collection('specialités')
                          .doc(sp.toLowerCase())
                          .collection('modules')
                          .doc(b.docs[j]['libellé'])
                          .collection('unités')
                          .doc(lib)
                          .collection('Groupes')
                          .doc(eltGroup)
                          .set({
                        'nom groupe': eltGroup,
                        'membres': FieldValue.arrayUnion([
                          {
                            'uid': uid,
                            'nom': name,
                            'statut': 'Enseignant',
                            'année': DateTime.now().year,
                          }
                        ])
                      });
                    }
                  }
                }
              }
            }
          }
        }
        //**********************ends of elements groups ***************************************** */
      } catch (e) {
        print('problem somewhere: ' + e.toString());
      }
    } else {
      print('first step me');
      try {
        var a = await FirebaseFirestore.instance
            .collection('academia')
            .doc('me')
            .collection('niveaux scolaire')
            .get();
        if (a.docs.isNotEmpty) {
          print('nvvvvvvvvvvvvvvvvvvvvvvvvvvvvv is not empty' +
              a.docs.length.toString());
          for (int i = 0; i < a.docs.length; i++) {
            String sp = a.docs[i]['nom'];
            print(sp);
            var b = await FirebaseFirestore.instance
                .collection('academia')
                .doc('me')
                .collection('niveaux scolaire')
                .doc(sp.toLowerCase())
                .get();
            print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
            if (b.exists) {
              print('matieeeeres');
              if (mEsubjects.isNotEmpty) {
                for (int k = 0; k < mEsubjects.length; k++) {
                  String lib = mEsubjects[k];
                  print('ccccccccccccccc');
                  print(lib);
                  String eltGroup = 'Groupe $lib';
                  var d = await FirebaseFirestore.instance
                      .collection('academia')
                      .doc('me')
                      .collection('niveaux scolaire')
                      .doc(sp.toLowerCase())
                      .collection('matieres')
                      .doc(lib.toLowerCase())
                      .collection('Groupes')
                      .doc(eltGroup)
                      .get();
                  if (d.exists) {
                    print('we are heeeeeeeeeeeeeeeeeeeere mat groupe exist');
                    print(lib);
                    print(eltGroup);
                    await FirebaseFirestore.instance
                        .collection('academia')
                        .doc('me')
                        .collection('niveaux scolaire')
                        .doc(sp.toLowerCase())
                        .collection('matieres')
                        .doc(lib.toLowerCase())
                        .collection('Groupes')
                        .doc(eltGroup)
                        .update({
                      'membres': FieldValue.arrayUnion([
                        {
                          'uid': uid,
                          'nom': name,
                          'statut': 'Enseignant',
                          'année': DateTime.now().year,
                        }
                      ])
                    });
                  } else {
                    print('we are here new unité group');
                    print(lib);
                    print(eltGroup);
                    await FirebaseFirestore.instance
                        .collection('academia')
                        .doc('me')
                        .collection('niveaux scolaire')
                        .doc(sp.toLowerCase())
                        .collection('matieres')
                        .doc(lib.toLowerCase())
                        .collection('Groupes')
                        .doc(eltGroup)
                        .set({
                      'nom groupe': eltGroup,
                      'membres': FieldValue.arrayUnion([
                        {
                          'uid': uid,
                          'nom': name,
                          'statut': 'Enseignant',
                          'année': DateTime.now().year,
                        }
                      ])
                    });
                  }
                }
              }
            }
          }
        }
        //**********************ends of elements groups ***************************************** */
      } catch (e) {
        print('problem somewhere: ' + e.toString());
      }
    }
  }
}
