import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MFFormationAddModule extends StatefulWidget {
  final String centre;
  final String specialite;
  const MFFormationAddModule(
      {super.key, required this.centre, required this.specialite});

  @override
  State<MFFormationAddModule> createState() => _MFFormationAddModuleState();
}

class _MFFormationAddModuleState extends State<MFFormationAddModule> {
  String module = '';
  String unite = '';
  String semestre = '';
  List<String> semestres = [
    'Semestre 1',
    'Semestre 2',
    'Semestre 3',
    'Semestre 4'
  ];
  callbackSemestre(varSelectedGouver) {
    setState(() {
      semestre = varSelectedGouver;
    });
  }

  final int code = DateTime.now().millisecondsSinceEpoch;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController eE_lib = TextEditingController();
  final TextEditingController module_lib = TextEditingController();
  final TextEditingController eE_coef = TextEditingController();
  final TextEditingController eE_regime = TextEditingController();
  final TextEditingController eE_credit = TextEditingController();
  final TextEditingController eE_VH_cours = TextEditingController();
  final TextEditingController eE_VH_TD = TextEditingController();
  final TextEditingController eE_VH_TP = TextEditingController();
  final TextEditingController eE_VH_total = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //code= DateTime.now().millisecondsSinceEpoch;
    module_lib.addListener(() {
      setState(() {});
    });
    eE_credit.addListener(() {
      setState(() {});
    });
    eE_regime.addListener(() {
      setState(() {});
    });
    eE_coef.addListener(() {
      setState(() {});
    });
    eE_lib.addListener(() {
      setState(() {});
    });

    eE_VH_total.addListener(() {
      setState(() {});
    });
    eE_VH_TP.addListener(() {
      setState(() {});
    });
    eE_VH_TD.addListener(() {
      setState(() {});
    });
    eE_VH_cours.addListener(() {
      setState(() {});
    });
    eE_VH_cours.text = '0';
    eE_VH_TD.text = '0';
    eE_VH_TP.text = '0';
    eE_VH_total.text = (int.parse(eE_VH_cours.text) +
            int.parse(eE_VH_TD.text) +
            int.parse(eE_VH_TP.text))
        .toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    eE_credit.dispose();
    module_lib.dispose();
    eE_lib.dispose();
    eE_coef.dispose();
    eE_regime.dispose();
    eE_VH_cours.dispose();
    eE_VH_TD.dispose();
    eE_VH_TP.dispose();
    eE_VH_total.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Ajout d'un module"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  // _addModule();
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          GestureDetector(
                            onTap: () {
                              Get.to(() => ListViewSearchScreen(
                                  items: semestres,
                                  stringCallback: callbackSemestre));
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              // margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.deepPurple.shade100,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: SizedBox(
                                width: 350,
                                child: (semestre != '')
                                    ? Text(
                                        semestre,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87),
                                      )
                                    : const Text(
                                        'Semestre',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                              ),
                            ),
                          ),
                          
                          Gap(20),
                          Container(
                            padding: EdgeInsets.all(18),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18)),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 206, 205, 205))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //  if (planEtude != '')
                                Container(
                                  // padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Module :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(.4)),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: GestureDetector(
                                                  onTap: () => _addModule(),
                                                  child: Icon(Icons.add)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Gap(10),
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: module_lib,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Libellé est vide';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          //labelText: 'Libellé',
                                          labelText: 'Libellé',
                                          suffixIcon: eE_lib.text.isEmpty
                                              ? null
                                              : IconButton(
                                                  onPressed: (() {
                                                    eE_lib.clear();
                                                  }),
                                                  icon:
                                                      const Icon(Icons.close)),
                                        ),
                                      ),
                                      Gap(15),

                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 5,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .90,
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple[100]!
                                                .withOpacity(.4),
                                            borderRadius:
                                                BorderRadius.circular((10)),
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 238, 235, 235))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Epreuve/Unité :",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black
                                                              .withOpacity(.4)),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: GestureDetector(
                                                      onTap: () =>
                                                          _addUniteEpreuve(),
                                                      child: Icon(Icons.add)),
                                                )
                                              ],
                                            ),
                                            Gap(10),
                                            TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller: eE_lib,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Libellé est vide';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                //labelText: 'Libellé',
                                                labelText: 'Libellé',
                                                suffixIcon: eE_lib.text.isEmpty
                                                    ? null
                                                    : IconButton(
                                                        onPressed: (() {
                                                          eE_lib.clear();
                                                        }),
                                                        icon: const Icon(
                                                            Icons.close)),
                                              ),
                                            ),
                                            TextFormField(
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              controller: eE_coef,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Coef. est vide';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                //labelText: 'Libellé',
                                                labelText: 'Coefficient',
                                                suffixIcon: eE_coef.text.isEmpty
                                                    ? null
                                                    : IconButton(
                                                        onPressed: (() {
                                                          eE_coef.clear();
                                                        }),
                                                        icon: const Icon(
                                                            Icons.close)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                   
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ])))));
  }

  void _addUniteEpreuve() async {
    if (_formKey.currentState!.validate()) {
      dbFormation().registerModuleCentre(
          widget.centre,
          widget.specialite,
          semestre,
          code.toString(),
          module_lib.text.trim(),
          eE_lib.text.trim(),
          eE_coef.text.trim());
    }

    eE_lib.clear();
    eE_coef.clear();
  }

  void _addModule() async {
    if (_formKey.currentState!.validate()) {
      dbFormation().registerModuleCentre(
          widget.centre,
          widget.specialite,
          semestre,
          code.toString(),
          module_lib.text.trim(),
          eE_lib.text.trim(),
          eE_coef.text.trim());
    }

    Get.back();
  }
}
