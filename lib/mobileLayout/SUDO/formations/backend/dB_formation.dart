import 'package:bellaraa/commun/commun/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class dbFormation {
  final academiaStore = firestore.collection('academia');
  //****************************************add me nioveau scolaire********************************** */

  void addNiveauScolaire(
      String cycle, String niveau, String section, List<String> mats) async {
    String niv = '';
    List<String> matts = [];
    matts.assignAll(mats);

    try {
      if (section == '') {
        niv = " $niveau  de l'$cycle";
        print(niv);
      } else {
        niv = niveau + ' ' + section;
        print(niv);
      }
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('me')
          .collection('niveaux scolaire')
          .doc(niv.toLowerCase())
          .get();
      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('me')
            .collection('niveaux scolaire')
            .doc(niv.toLowerCase())
            .set({
          'nom': niv,
          'cycle': cycle,
          'niveau': niveau,
          'section': section
        });

        for (int i = 0; i < matts.length; i++) {
          try {
            await academiaStore
                .doc('me')
                .collection('niveaux scolaire')
                .doc(niv.toLowerCase())
                .collection('matieres')
                .doc(matts[i].toLowerCase())
                .set({
              'matière': matts[i],
              'domaine': '',
              'coef': '',
              'supports': [],
            });
          } catch (e) {
            Get.snackbar('Matières', e.toString());
          }
        }
      }
    } catch (e) {
      Get.snackbar('Niveau scolaire', e.toString());
      print(e.toString() + 'errrrrrrrrrrrrrrrrrrrrrrreur1');
    }
  }

//********************** add  speciality ***centre de formation ************************************* */

  void addSpeciality(
      String speciality, String centre, String diplome, String secteur) async {
    try {
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('mf')
          .collection('specialités')
          .doc(speciality.toLowerCase())
          .get();
      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('mf')
            .collection('specialités')
            .doc(speciality.toLowerCase())
            .set({
          'specialité': speciality,
          'centre': centre,
          'diplome': diplome,
          'secteur': secteur
        });
      }
    } catch (e) {
      Get.snackbar('Specialité', e.toString());
      print(e.toString() + 'errrrrrrrrrrrrrrrrrrrrrrreur1');
    }
  }
  //****************************************Ajout module / centre de formation************************ */
  registerModuleCentre(String centre, String specialite, String semestre,
      String code, String module_lib, String lib, String coef) async {
    try {
      await academiaStore
            .doc('mf')
            .collection('specialités')
            .doc(specialite.toLowerCase())
          .collection('modules')
          .doc(module_lib)
          .set({'libellé': module_lib, 'semestre': semestre}).then(
              (value) async {
        await academiaStore
            .doc('mf')
            .collection('specialités')
            .doc(specialite.toLowerCase())
            .collection('modules')
            .doc(module_lib)
            .collection('unités')
            .doc(lib)
            .set({'libellé': lib, 'coefficient': coef});
      });
    } catch (e) {
      print('pb somewhre');
      print(e.toString());
    }
  }

  //****************************************Ajout module / centre de formation************************ */
  registerEpreuveUniteCentre(String centre, String specialite, String semestre,
      String code, String module_lib, String lib, String coef) async {
    try {
      await academiaStore
            .doc('mf')
            .collection('specialités')
            .doc(specialite.toLowerCase())
          .collection('modules')
          .doc(module_lib)
          .collection('unités')
          .doc(lib)
          .set({'libellé': lib, 'coefficient': coef}).then(
              (value) => Get.snackbar(module_lib, lib+' added'));
    } catch (e) {
      (value) => Get.snackbar(module_lib,e.toString());
      print('pb somewhre');
      print(e.toString());
    }
  }

  //*****************************add formation ******************ms************************* */
  void addFormationMS(String speciality, String university, String etab,
      String formation, String diplome, String domaine) async {
    try {
      //*****************************test if it exist before adding it************** */
      var snapshot = await academiaStore
          .doc('ms')
          .collection('specialités')
          .doc(speciality.toLowerCase())
          .get();
      if (!snapshot.exists) {
        // Document with id == varuId doesn't exist.
        await academiaStore
            .doc('ms')
            .collection('specialités')
            .doc(speciality.toLowerCase())
            .set({
          'specialité': speciality,
          'université': university,
          'etablissements': etab,
          'formation': formation,
          'diplome': diplome,
          'domaine de la formation': domaine
        }).then((value) => Get.snackbar('Spécialité', 'speciality added'));
      }
    } catch (e) {
      Get.snackbar('Specialité', e.toString());
      print(e.toString() + 'errrrrrrrrrrrrrrrrrrrrrrreur1');
    }
  }

  //**********************************************ajouter un plan d'etudes ************************************ */
  registerPlanEtude(
   
    String specialite,
    String uE_lib,
    String uE_coef,
    String uE_credit,
    String uE_regime,
    String eE_lib,
    String eE_coef,
    String eE_credit,
    String eE_regime,
    String eE_VH_cours,
    String eE_VH_TD,
    String eE_VH_TP,
    String eE_VH_total,
  ) async {
    try {
      await academiaStore
          .doc('ms')
          .collection('specialités')
          .doc(specialite.toLowerCase())
          .collection("plan d'etude")
          .doc(uE_lib.toLowerCase())
          .set({
        'libellé': uE_lib,
        'coef': uE_coef,
        'credit': uE_credit,
        'regime': uE_regime,
      }).then((value) async {
        Get.snackbar("Plan d'etude", 'added');
        await academiaStore
            .doc('ms')
            .collection('specialités')
            .doc(specialite.toLowerCase())
            .collection("plan d'etude")
            .doc(uE_lib.toLowerCase())
            .collection("element d'enseignment")
            .doc(eE_lib.toLowerCase())
            .set({
          'libellé': eE_lib,
          'coef': eE_coef,
          'credit': eE_credit,
          'regime': eE_regime,
          'volume horaire cours': eE_VH_cours,
          'volume horaire TD': eE_VH_TD,
          'volume horaire TP': eE_VH_TP,
          'volume horaire total': eE_VH_total
        });
      });
    } catch (e) {
      print('pb somewhre');
      print(e.toString());
    }
  }

//********************** ajout d'un element d'enseignement *********************************** */
  registerElementEnseignment(
    
    String specialite,
    String uE_lib,
    String eE_lib,
    String eE_coef,
    String eE_credit,
    String eE_regime,
    String eE_VH_cours,
    String eE_VH_TD,
    String eE_VH_TP,
    String eE_VH_total,
  ) async {
    try {
      await academiaStore
          .doc('ms')
          .collection('specialités')
          .doc(specialite.toLowerCase())
          .collection("plan d'etude")
          .doc(uE_lib.toLowerCase())
          .collection("element d'enseignment")
          .doc(eE_lib.toLowerCase())
          .set({
        'libellé': eE_lib,
        'coef': eE_coef,
        'credit': eE_credit,
        'regime': eE_regime,
        'volume horaire cours': eE_VH_cours,
        'volume horaire TD': eE_VH_TD,
        'volume horaire TP': eE_VH_TP,
        'volume horaire total': eE_VH_total
      });
    } catch (e) {
      print('pb somewhre');
      print(e.toString());
    }
  }
  //***************************** me matiere ************************************************ */
  void updateMatiereDomaine(String niv, String mat, String domaine) async {
    try {
      await academiaStore
                .doc('me')
                .collection('niveaux scolaire')
                .doc(niv.toLowerCase())
                
          .collection('matieres')
          .doc(mat.toLowerCase())
          .update({
        'matière': mat,
        'domaine': domaine,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateMatiereCoef(String niv, String mat, String coef) async {
    try {
      await academiaStore
                .doc('me')
                .collection('niveaux scolaire')
                .doc(niv.toLowerCase())
                
          .collection('matieres')
          .doc(mat.toLowerCase())
          .update({
        'coef': coef,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void addMatiereSupport(
      String niv, String mat, String filename, String supportUrl) async {
    try {
      await academiaStore
                .doc('me')
                .collection('niveaux scolaire')
                .doc(niv.toLowerCase())
                
          .collection('matieres')
          .doc(mat.toLowerCase())
          .update({
        'supports': FieldValue.arrayUnion([
          {'title': filename, 'pdfUrl': supportUrl}
        ])
      });
    } catch (e) {
      print(e.toString());
    }
  }
 

}
