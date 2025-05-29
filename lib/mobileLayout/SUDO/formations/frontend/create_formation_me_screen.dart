import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class CreationFormationMEScreen extends StatefulWidget {
  const CreationFormationMEScreen({super.key});

  @override
  State<CreationFormationMEScreen> createState() =>
      _CreationFormationMEScreenState();
}

class _CreationFormationMEScreenState extends State<CreationFormationMEScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  String slectedNiveau = '';
  List<String> selectedMatieres = [];
  String selectedCycle = '';
  String selectedSection2 = '';
  String selectedSection3 = '';
  List<String> cycles = ['Enseignement de base', 'Enseignement secondaire'];
  callbackCycle(varSelectedDeleg) {
    setState(() {
      selectedCycle = varSelectedDeleg;
    });
  }

  callbackSection2(varSelectedDeleg) {
    setState(() {
      selectedSection2 = varSelectedDeleg;
    });
  }

  callbackSection3(varSelectedDeleg) {
    setState(() {
      selectedSection3 = varSelectedDeleg;
    });
  }

  callbackNiveau(varSelectedDeleg) {
    setState(() {
      slectedNiveau = varSelectedDeleg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                            Text('Ajouter un niveau scolaire',
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
                                    _addNiveau();
                                  },
                                  child: Icon(
                                    Icons.save,
                                    color: Colors.deepPurple,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const Gap(25),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.to(() => ListViewSearchScreen(
                                items: cycles, stringCallback: callbackCycle));
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
                            child: (selectedCycle != '')
                                ? Text(
                                    selectedCycle,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  )
                                : const Text(
                                    'Cycle',
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
                            Get.to(() => ListViewSearchScreen(
                                items: nivScolaire,
                                stringCallback: callbackNiveau));
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
                            child: (slectedNiveau != '')
                                ? Text(
                                    slectedNiveau,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                  )
                                : const Text(
                                    'Niveau scolaire',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(25),
                      if (slectedNiveau == 'Deuxième année' &&
                          selectedCycle == 'Enseignement secondaire')
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Get.to(() => ListViewSearchScreen(
                                  items: sections2annee,
                                  stringCallback: callbackSection2));
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
                              child: (selectedSection2 != '')
                                  ? Text(
                                      selectedSection2,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    )
                                  : const Text(
                                      'Section',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                            ),
                          ),
                        ),
                      if ((slectedNiveau == 'Troisième année' ||
                              slectedNiveau == 'Quatrième année') &&
                          selectedCycle == 'Enseignement secondaire')
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Get.to(() => ListViewSearchScreen(
                                  items: sections3annee,
                                  stringCallback: callbackSection3));
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
                              child: (selectedSection3 != '')
                                  ? Text(
                                      selectedSection3,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    )
                                  : const Text(
                                      'Section',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                            ),
                          ),
                        ),
                      const Gap(15),
                      Container(
                        //margin: EdgeInsets.only(left: 35, ),
                        child: MultiSelectDialogField(
                          validator: (value) {
                            if (selectedMatieres.isEmpty) {
                              return 'matières est obligatoire';
                            }
                            return null;
                          },
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(color: Colors.black54))),
                          buttonIcon: const Icon(Icons.keyboard_arrow_down),
                          buttonText: const Text(
                            'Matières',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          title: const Text(
                            'Matières:',
                            style: TextStyle(color: Colors.black54),
                          ),
                          items: matieres
                              .map((e) => MultiSelectItem(e, e))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          onConfirm: (p0) {
                            setState(() {
                              selectedMatieres = p0;
                            });
                          },
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
      if (selectedCycle == '' || slectedNiveau == '') {
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
      });
    }
  }
}
