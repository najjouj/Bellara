import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/etablissements/ministere%20ens%20sup/universities/etablissement/univ_etabs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../DBoperation/univ_DB_operation.dart';
import 'formations/ms_formations_screen.dart';

class MSHomePage extends StatefulWidget {
  const MSHomePage({super.key});

  @override
  State<MSHomePage> createState() => _MSHomePageState();
}

class _MSHomePageState extends State<MSHomePage> {
  List<String> universities = [];
  String activeSelection = 'Etablissments';
  List<String> listOfValue = ['Etablissments', 'Spécialités'];

  String university = '';

  String rechercheChoice = '';
  univcallback(varSelectedNatEtab) {
    setState(() {
      university = varSelectedNatEtab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      // color: Colors.green,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: univDBoperations()
                  .academiaStore
                  .doc('ms')
                  .collection('universities')
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
                            child: Text('no data',
                                style: TextStyle(color: Colors.black))),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  universities = [];
                  for (int i = 0; i < documents.length; i++) {
                    universities.add(documents[i]['nom']);
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Text("Ajouter une université",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w300));
                  } else {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Get.to(() => ListViewSearchScreen(
                              items: universities,
                              stringCallback: univcallback));
                        });
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // width: double.infinity,
                              child: (university != '')
                                  ? Text(
                                      university,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    )
                                  : const Text(
                                      'université',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                            ),
                            Icon(
                              Icons.search,
                              color: Colors.deepPurple,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Text("Ajouter une université",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w300));
                }
              },
            ),
            Gap(10),
            Container(
              //height: 100,
              padding: const EdgeInsets.only(left: 10, top: 5, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Ministere de l'enseignement superieur",
                    style: const TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),

                  Container(
                    width: 150,
                    //height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down_circle_rounded,
                          size: 20,
                          color: Colors.deepPurple,
                        ),
                        value: activeSelection,
                        items: listOfValue.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val,
                                style: TextStyle(
                                    fontSize: 16,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.grey[800])),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            activeSelection = val as String;
                          });
                        }),
                  )

                  //Gap(25),
                ],
              ),
            ),
            const Gap(20),
            if (activeSelection == 'Etablissments')
              UnivEtabsScreen(
                university: university,
              ),
            if (activeSelection == 'Spécialités')
              MSFormationsScreen(
                university: university,
              )
          ]),
    );
  }
}
