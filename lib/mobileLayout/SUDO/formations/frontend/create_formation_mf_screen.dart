import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../backend/dB_formation.dart';

class CreateFormationMFScreen extends StatefulWidget {
  const CreateFormationMFScreen({super.key});

  @override
  State<CreateFormationMFScreen> createState() =>
      _CreateFormationMFScreenState();
}

class _CreateFormationMFScreenState extends State<CreateFormationMFScreen> {
  String selectedCentre = '';
  String selectedDiplome = '';
  String selectedSecteur = '';
  List<String> centres = [];
  List<String> diplomes = [];
  List<String> secteurs = [];
  final TextEditingController nameController = TextEditingController();
  bool isloading = false;
  callbackCentre(varSelectedDeleg) {
    setState(() {
      selectedCentre = varSelectedDeleg;
    });
  }

  callbackDiplome(varSelectedDeleg) {
    setState(() {
      selectedDiplome = varSelectedDeleg;
    });
  }

  callbackSecteur(varSelectedDeleg) {
    setState(() {
      selectedSecteur = varSelectedDeleg;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: (isloading)
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ajouter une spécialité',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.7,
                                    decorationThickness: .2,
                                    fontSize: 20,
                                    color: Colors.black)),
                            Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepPurple.shade100,
                                    ),
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle),
                                child: GestureDetector(
                                  onTap: () {
                                    _addSpeciality();
                                  },
                                  child: Icon(
                                    Icons.save,
                                    color: Colors.deepPurple,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Gap(25),
                      Container(
                        height: 70,
                        width: double.maxFinite,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple.shade100,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),

                        //padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          //maxLines: 10,
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'specialité. est vide';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            filled: true,
                            fillColor: Colors.white,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: "Specialité ",
                            labelStyle: const TextStyle(
                                letterSpacing: 1.2,
                                fontSize: 24,
                                color: Colors.grey),
                            /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                            hintText: "saisir le nom de la specialité",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                                fontSize: 16),
                            // contentPadding: const EdgeInsets.all(8),
                            suffixIcon: nameController.text.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: (() {
                                      nameController.clear();
                                    }),
                                    icon: const Icon(Icons.close)),
                          ),
                        ),
                      ),
                      Gap(25),
                      StreamBuilder(
                        stream: etabDBoperations()
                            .academiaStore
                            .doc('mf')
                            .collection('centres de formations')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepPurple,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
                              child: Column(
                                children: [
                                  Gap(10),
                                  Center(
                                      child: Text('no data',
                                          style:
                                              TextStyle(color: Colors.black))),
                                ],
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;

                            centres = [];
                            for (int i = 0; i < documents.length; i++) {
                              centres.add(documents[i]['nom']);
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return Container(
                                height: 250,
                                child: Column(
                                  children: [
                                    Gap(150),
                                    Center(
                                        child: Column(
                                      children: [
                                        const Text(
                                            "Ajouter un centre de formation",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w300)),
                                        Image.asset(
                                          'assets/icons/school.png',
                                          height: 30,
                                          width: 30,
                                          color: Colors.deepPurple,
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ListViewSearchScreen(
                                        items: centres,
                                        stringCallback: callbackCentre));
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.deepPurple.shade100,
                                        ),
                                        /*   boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        offset: const Offset(0, 10),
                                        color: Colors.grey.withOpacity(.2))
                                  ],*/
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: SizedBox(
                                      width: 350,
                                      child: (selectedCentre != '')
                                          ? Text(
                                              selectedCentre,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87),
                                            )
                                          : const Text(
                                              'Centre de formation',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                    ),
                                  ));
                            }
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
                              child: Column(
                                children: [
                                  Gap(150),
                                  Center(
                                      child: Column(
                                    children: [
                                      const Text(
                                          "Ajouter un centre de formation",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w300)),
                                      Image.asset(
                                        'assets/icons/school.png',
                                        height: 30,
                                        width: 30,
                                        color: Colors.deepPurple,
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      const Gap(25),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            diplomes = [];
                            for (int i = 0; i < diplomesMF.length; i++) {
                              diplomes.add(diplomesMF[i]['diplome']);
                            }
                            Get.to(() => ListViewSearchScreen(
                                items: diplomes,
                                stringCallback: callbackDiplome));
                          });
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.deepPurple.shade100,
                              ),
                              /*   boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        offset: const Offset(0, 10),
                                        color: Colors.grey.withOpacity(.2))
                                  ],*/
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: SizedBox(
                            width: 350,
                            child: (selectedDiplome != '')
                                ? Text(
                                    selectedDiplome,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  )
                                : const Text(
                                    'Diplôme',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(25),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            secteurs = [];
                            for (int i = 0; i < secteursMF.length; i++) {
                              secteurs.add(secteursMF[i]['Secteur']);
                            }
                            Get.to(() => ListViewSearchScreen(
                                items: secteurs,
                                stringCallback: callbackSecteur));
                          });
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.deepPurple.shade100,
                              ),
                              /*   boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        offset: const Offset(0, 10),
                                        color: Colors.grey.withOpacity(.2))
                                  ],*/
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: SizedBox(
                            width: 350,
                            child: (selectedSecteur != '')
                                ? Text(
                                    selectedSecteur,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  )
                                : const Text(
                                    'Secteur',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
    );
  
  }

  void _addNiveau() async {
    if (_formKey.currentState!.validate()) {
      print('yeeeeeeeeeeeeees');
      /* if (selectedCycle == '' || slectedNiveau == '') {
        Get.snackbar('Niveau scolaire', 'All fields must be filled');
      } else {
        setState(() {
          isloading = true;
        });
        dbFormation().addNiveauScolaire(
            selectedCycle,
            slectedNiveau,
            (selectedSection2 != '') ? selectedSection2 : selectedSection3,
            selectedMatieres);
      }
      setState(() {
        isloading = false;
        selectedCycle = '';
        selectedSection2 = '';
        slectedNiveau = '';
        selectedSection3 = '';
        selectedMatieres.clear();
      });*/
    }
  }

  void _addSpeciality() {
    if (_formKey.currentState!.validate()) {
      print('yeeeeeeeeeeeeees');
      if (selectedCentre == '' ||
          selectedDiplome == '' ||
          selectedSecteur == '') {
        Get.snackbar('Specialité', 'All fields must be filled');
      } else {
        setState(() {
          isloading = true;
        });
        dbFormation().addSpeciality(nameController.text, selectedCentre,
            selectedDiplome, selectedSecteur);
      }
      setState(() {
        isloading = false;
        nameController.clear();
        selectedCentre = '';
        selectedDiplome = '';
        selectedSecteur = '';
      });
    }
  }
}
