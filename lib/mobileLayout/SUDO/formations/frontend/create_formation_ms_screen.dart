import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/univ_DB_operation.dart';
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreationFormationMSScreen extends StatefulWidget {
  const CreationFormationMSScreen({super.key});

  @override
  State<CreationFormationMSScreen> createState() =>
      _CreationFormationMSScreenState();
}

class _CreationFormationMSScreenState extends State<CreationFormationMSScreen> {
  TextEditingController specialityController = TextEditingController();
  List<String> universities = [];
  List<String> etabs = [];
  String selectedUniversity = '';
  String selectedEtab = '';
  String selectedFormation = '';
  String selectedDiplome = '';
  String selectedDomaineFormation = '';
  bool isloading = false;
  callbackUniversity(varSelectedDeleg) {
    setState(() {
      selectedUniversity = varSelectedDeleg;
    });
  }

  callbackEtab(varSelectedDeleg) {
    setState(() {
      selectedEtab = varSelectedDeleg;
    });
  }

  callbackDiplome(varSelectedDeleg) {
    setState(() {
      selectedDiplome = varSelectedDeleg;
    });
  }

  callbackFormation(varSelectedDeleg) {
    setState(() {
      selectedFormation = varSelectedDeleg;
    });
  }

  callbackDomaine(varSelectedDeleg) {
    setState(() {
      selectedDomaineFormation = varSelectedDeleg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    specialityController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    specialityController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
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
                      Gap(45),
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
                          controller: specialityController,
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
                            suffixIcon: specialityController.text.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: (() {
                                      specialityController.clear();
                                    }),
                                    icon: const Icon(Icons.close)),
                          ),
                        ),
                      ),
                      Gap(25),
                      StreamBuilder(
                        stream: univDBoperations()
                            .academiaStore
                            .doc('ms')
                            .collection('universities')
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

                            universities = [];
                            for (int i = 0; i < documents.length; i++) {
                              universities.add(documents[i]['nom']);
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
                                        const Text("Ajouter une université",
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
                                        items: universities,
                                        stringCallback: callbackUniversity));
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
                                      child: (selectedUniversity != '')
                                          ? Text(
                                              selectedUniversity,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87),
                                            )
                                          : const Text(
                                              'Université',
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
                                      const Text("Ajouter une université",
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
                      // const Gap(25),
                      if (selectedUniversity != '')
                        StreamBuilder(
                          stream: etabDBoperations()
                              .academiaStore
                              .doc('ms')
                              .collection('etablissements')
                              .where('université',
                                  isEqualTo: selectedUniversity)
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
                                            style: TextStyle(
                                                color: Colors.black))),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasData) {
                              final List<DocumentSnapshot> documents =
                                  snapshot.data!.docs;

                              etabs = [];
                              for (int i = 0; i < documents.length; i++) {
                                etabs.add(documents[i]['nom']);
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
                                          const Text("Ajouter un etablissement",
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
                                return Container(
                                  child: Column(
                                    children: [
                                      Gap(25),
                                      GestureDetector(
                                          onTap: () {
                                            Get.to(() => ListViewSearchScreen(
                                                items: etabs,
                                                stringCallback: callbackEtab));
                                          },
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.centerLeft,
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(10),
                                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors
                                                      .deepPurple.shade100,
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
                                              child: (selectedEtab != '')
                                                  ? Text(
                                                      selectedEtab,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black87),
                                                    )
                                                  : const Text(
                                                      'Etablissement',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              }
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 60, 10, 0),
                                child: Column(
                                  children: [
                                    Gap(150),
                                    Center(
                                        child: Column(
                                      children: [
                                        const Text("Ajouter un etablissement",
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
                            Get.to(() => ListViewSearchScreen(
                                items: formations,
                                stringCallback: callbackFormation));
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
                            child: (selectedFormation != '')
                                ? Text(
                                    selectedFormation,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  )
                                : const Text(
                                    'Formation',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(25),
                      if (selectedFormation == 'LMD')
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Get.to(() => ListViewSearchScreen(
                                        items: lMD,
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
                                                fontSize: 16,
                                                color: Colors.black87),
                                          )
                                        : const Text(
                                            'Diplôme',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                  ),
                                ),
                              ),
                              Gap(25)
                            ],
                          ),
                        ),
                      if (selectedFormation == 'etudes medicales')
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Get.to(() => ListViewSearchScreen(
                                        items: etdudesMedicales,
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
                                                fontSize: 16,
                                                color: Colors.black87),
                                          )
                                        : const Text(
                                            'Diplôme',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                  ),
                                ),
                              ),
                              Gap(25)
                            ],
                          ),
                        ),
                      if (selectedFormation == "etudes d'ingenieurs")
                        Container(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Get.to(() => ListViewSearchScreen(
                                        items: edudesIngenieurs,
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
                                                fontSize: 16,
                                                color: Colors.black87),
                                          )
                                        : const Text(
                                            'Diplôme',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                  ),
                                ),
                              ),
                              Gap(25)
                            ],
                          ),
                        ),
                      // Gap(25),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.to(() => ListViewSearchScreen(
                                items: domaineFormations,
                                stringCallback: callbackDomaine));
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
                            child: (selectedDomaineFormation != '')
                                ? Text(
                                    selectedDomaineFormation,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  )
                                : const Text(
                                    'Domaine de la formation',
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

  void _addSpeciality() {
    if (_formKey.currentState!.validate()) {
      print('yeeeeeeeeeeeeees');
      if (selectedUniversity == '' ||
          selectedDiplome == '' ||
          selectedEtab == '' ||
          selectedFormation == '' ||
          selectedDomaineFormation == '') {
        Get.snackbar('Specialité', 'All fields must be filled');
      } else {
        setState(() {
          isloading = true;
        });
        
        dbFormation().addFormationMS(specialityController.text, selectedUniversity, selectedEtab, selectedFormation, selectedDiplome, selectedDomaineFormation);
      }
      setState(() {
        isloading = false;
        specialityController.clear();
        selectedUniversity = '';
        selectedDiplome = '';
        selectedEtab = '';
        selectedFormation = '';
        selectedDomaineFormation = '';
      });
    }
  }
}
