import "package:bellaraa/commun/widgets/list_view_search_screen.dart";
import "package:bellaraa/mobileLayout/SUDO/DBoperation/univ_DB_operation.dart";

import "package:cloud_firestore/cloud_firestore.dart";

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import "package:get/get.dart";

class MinistereSuperieurHomePage extends StatefulWidget {
  const MinistereSuperieurHomePage({super.key});

  @override
  State<MinistereSuperieurHomePage> createState() =>
      _MinistereSuperieurHomePageState();
}

class _MinistereSuperieurHomePageState
    extends State<MinistereSuperieurHomePage> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
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
                            items: universities, stringCallback: univcallback));
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
          Container(
            height: 200,
            color: Colors.blue,
          ),
          Text('hiiii'),
          Text('hellooooooooooooo')
          /*  (activeSelection == 'Etablissments')
              ? EtabListScreen(
                  university: university,
                )
              : Text('specialities'),*/
          //EtabListScreen(   university: university,   )
        ],
      ),
    );
  }

  void _bottomSheetSpecialties() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: 400,
              child: Wrap(children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ListTile(
                  //onTap: () => Get.to(() => AddPlanEtudeScreen()),
                  leading: Container(
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text(
                    "Un plan d'etude",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  leading: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text("Une unité d'enseignement",
                      style: TextStyle(fontSize: 20)),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  // onTap: () => Get.to(() => AddPlanEtudeScreen()),
                ),
                ListTile(
                  //onTap: () => Get.to(() => (AddElementEnsScreen())),
                  leading: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text("un element d'enseignment",
                      style: TextStyle(fontSize: 20)),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  // onTap: () => Get.to(() => (AjoutSpecialiteScreen())),
                  leading: Container(
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text('Une spécialité',
                      style: TextStyle(fontSize: 20)),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
              ]));
        });
  }

  void _bottomSheetUniversities() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: 400,
              child: Wrap(children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ListTile(
                  //onTap: () => Get.to(() => const AddUniversitiyScreen()),
                  leading: Container(
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text(
                    'Une université',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
              ]));
        });
  }
}
