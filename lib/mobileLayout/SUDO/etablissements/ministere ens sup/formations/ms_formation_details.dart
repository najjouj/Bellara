// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'ms_formation_add_EE.dart';
import 'ms_formation_afficher_EE.dart';
import 'ms_formation_details_EE.dart';

class MSFormationDetails extends StatelessWidget {
  final String speciality;
  final String etab;
  MSFormationDetails({
    Key? key,
    required this.speciality,
    required this.etab,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: InkWell(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.deepPurple,
              size: 25,
            )),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              speciality,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Les unites d'enseignement",
                style: TextStyle(
                    color: Colors.grey, fontSize: 16, letterSpacing: 1.2)),
          ),
          Gap(20),
          StreamBuilder(
            stream: dbFormation()
                .academiaStore
                .doc('ms')
                .collection('specialités')
                .doc(speciality)
                .collection("plan d'etude")
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
                          child: Text('no has error',
                              style: TextStyle(color: Colors.black))),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                //final String lib = snapshot.data!.get('uid');
                // final List etablissements = [];
                /* for (int i = 0; i < documents.length; i++) {
                  // print(documents[i]['uid']);
                  etablissements.add(documents[i]['uid']);
                }*/

                if (snapshot.data!.docs.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: documents.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () => Get.to(() => MSFormationAddEE(
                                etab: etab,
                                speciality: speciality,
                                planEtude: documents[index]['libellé'],
                              )),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 212, 212, 212)),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Libellé :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          letterSpacing: 1.2),
                                    ),
                                    Gap(5),
                                    Text(documents[index]['libellé']),
                                  ],
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Text('Coefficient :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 1.2)),
                                    Gap(5),
                                    Text(documents[index]['coef']),
                                  ],
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Text('Crédit :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 1.2)),
                                    Gap(5),
                                    Text(documents[index]['credit']),
                                  ],
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Text("Modalité d'evaluation :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            letterSpacing: 1.2)),
                                    Gap(5),
                                    Text(documents[index]['regime']),
                                  ],
                                ),
                                Gap(20),
                                Text(
                                  "Les élèments d'enseignement :",
                                  style: TextStyle(
                                      letterSpacing: 1.1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                Gap(5),
                                MSFormationAfficherEE(
                                  uniteEnsg: documents[index]['libellé'],
                                  speciality: speciality,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => Get.to(() => MSFormationDetailsEE(
                          etab: etab,
                          speciality: speciality,
                        )),
                    child: Center(
                        child: Column(
                      children: [
                        const Gap(50),
                        Icon(Icons.add),
                        Text("Ajouter un plan d'etude",
                            style: TextStyle(color: Colors.black)),
                      ],
                    )),
                  );
                }
              } else {
                return GestureDetector(
                  onTap: () => Get.to(() => MSFormationDetailsEE(
                        etab: etab,
                        speciality: speciality,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
                    child: Column(
                      children: [
                        const Gap(50),
                        Center(child: Icon(Icons.add)),
                        const Center(
                            child: Text('no data',
                                style: TextStyle(color: Colors.black))),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
