import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'mf_formation_add_module.dart';
import 'mf_formation_unite_card.dart';

class MFFormationShowModules extends StatefulWidget {
  final String centre;
  final String specialite;
  const MFFormationShowModules({
    super.key,
    required this.centre,
    required this.specialite,
  });

  @override
  State<MFFormationShowModules> createState() => _MFFormationShowModulesState();
}

class _MFFormationShowModulesState extends State<MFFormationShowModules> {
  final _formKey = GlobalKey<FormState>();

  final int code = DateTime.now().millisecondsSinceEpoch;
  List<String> listOfValue = [
    'Semestre 1',
    'Semestre 2',
    'Semestre 3',
    'Semestre 4'
  ];
  final TextEditingController eE_lib = TextEditingController();

  final TextEditingController eE_coef = TextEditingController();
  callbackSemestre(varSelectedGouver) {
    setState(() {
      semestre = varSelectedGouver;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eE_lib.dispose();
    eE_coef.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eE_coef.addListener(() {
      setState(() {});
    });
    eE_lib.addListener(() {
      setState(() {});
    });
  }

  String semestre = 'Semestre 1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                Get.to(() => MFFormationAddModule(
                      centre: widget.centre,
                      specialite: widget.specialite,
                    ));
              },
              icon: Icon(Icons.add),
              label: Text('Module'))
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.specialite,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 1.2),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 30, right: 20),
            width: double.infinity,
            height: 50,
            child: GestureDetector(
              onTap: () {
                Get.to(() => ListViewSearchScreen(
                    items: listOfValue, stringCallback: callbackSemestre));
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
                              fontSize: 16, color: Colors.black87),
                        )
                      : const Text(
                          'Semestre',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                ),
              ),
            ),
          ),
          Gap(25),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: Text(
              'Modules : ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          StreamBuilder(
            stream: dbFormation()
                .academiaStore
                .doc('mf')
                .collection('specialités')
                .doc(widget.specialite.toLowerCase())
                .collection('modules')
                .where('semestre', isEqualTo: semestre)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
                  child: Column(
                    children: [
                      Gap(10),
                      Center(
                          child: Text('no data error',
                              style: TextStyle(color: Colors.black))),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    children: [
                      const Gap(150),
                      Center(
                          child: Text('no data is empty',
                              style: TextStyle(color: Colors.black)))
                    ],
                  );
                } else {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return Expanded(
                    //width: double.infinity,
                    //height: 900,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => addUnite(
                                widget.specialite, documents[index]['libellé']),
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 25),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(18),
                                  color:
                                      Colors.deepPurple[200]!.withOpacity(.1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(15),
                                  Center(
                                    child: Text(
                                      documents[index]['libellé'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Gap(10),
                                  MFFormationUniteCard(
                                      specialite: widget.specialite,
                                      module: documents[index]['libellé'])
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              } else {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
                  child: Column(
                    children: [
                      const Gap(10),
                      const Center(
                          child: Text('no data oups',
                              style: TextStyle(color: Colors.black))),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future addUnite(String specialite, String document) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Ajouter une unité'),
          actions: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(.4)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                  onTap: () {
                    _addUniteEpreuve(document);
                  },
                  child: Icon(Icons.add)),
            )
          ],
          content: Container(
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Module : ' + document,
                          style: TextStyle(fontSize: 18),
                        ),
                        Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Epreuve/Unité :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Gap(10),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: eE_lib,
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
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                controller: eE_coef,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
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
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])))),
    );
  }

  _addUniteEpreuve(
    String module,
  ) {
    if (_formKey.currentState!.validate()) {
      dbFormation().registerModuleCentre(
          widget.centre,
          widget.specialite,
          semestre,
          code.toString(),
          module,
          eE_lib.text.trim(),
          eE_coef.text.trim());
    }

    eE_lib.clear();
    eE_coef.clear();
  }
}
