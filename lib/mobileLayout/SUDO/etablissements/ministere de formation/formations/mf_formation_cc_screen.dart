import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'modules/mf_formation_show_modules.dart';
import 'widgets/detail_secteur_widget.dart';
import 'widgets/details_diplome_widget.dart';

class MFFormationCCScreen extends StatelessWidget {
  final String gouvernorat;
  MFFormationCCScreen({super.key, required this.gouvernorat});

  @override
  Widget build(BuildContext context) {
    List<String> centres = [];
    if (gouvernorat != '') {
      return StreamBuilder(
        stream: etabDBoperations()
            .academiaStore
            .doc('mf')
            .collection('centres de formations')
            .where('gouvernorat', isEqualTo: gouvernorat)
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

            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  const Gap(150),
                  Center(
                      child: Column(
                    children: [
                      const Text("Ajouter un centre de formation",
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
              );
            } else {
              centres = [];
              for (int i = 0; i < documents.length; i++) {
                centres.add(documents[i]['nom']);
              }
              return StreamBuilder(
                stream: dbFormation()
                    .academiaStore
                    .doc('mf')
                    .collection('specialités')
                    .where('diplome', isEqualTo: 'Certification de Compétence')
                    .where('centre', whereIn: centres)
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
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;

                    if (snapshot.data!.docs.isEmpty) {
                      return Column(
                        children: [
                          const Gap(150),
                          Center(
                              child: Column(
                            children: [
                              const Text("Ajouter une spécialité",
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
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            //height: 620,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  //List images = documents[index]['galleries'];
                                  // List transports = documents[index]['transport'];
                                  //int n = images.length;

                                  return Container(
                                    //height: 500,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: const EdgeInsets.only(
                                        bottom: 15, left: 5, right: 5, top: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: Text(
                                          documents[index]['specialité'],
                                          style: TextStyle(
                                              letterSpacing: 1.8,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                        Gap(10),
                                        Row(
                                          children: [
                                            Text(
                                              'Centre de formation : ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(documents[index]['centre'])
                                          ],
                                        ),
                                        Gap(5),
                                        Divider(),
                                        DEtailsDiplomeWidget(
                                          diplome: documents[index]['diplome'],
                                        ),
                                        Divider(),
                                        Gap(5),
                                        DetailSecteurWidget(
                                          secteur: documents[index]['secteur'],
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      MFFormationShowModules(
                                                        centre: documents[index]
                                                            ['centre'],
                                                        specialite:
                                                            documents[index]
                                                                ['specialité'],
                                                      ));
                                                },
                                                icon: Icon(Icons.open_in_new),
                                                label: Text('Modules')))
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
                      child: Column(
                        children: [
                          const Gap(10),
                          const Center(
                              child: Text('no data',
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .6,
                              maxHeight: 80),
                          child: RichText(
                              text: TextSpan(
                                  text: "Ministère de formation\n",
                                  style: const TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  children: [
                                TextSpan(
                                  text: '   Centre de formation',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[500]),
                                )
                              ])),
                        ),
                        GestureDetector(
                          onTap: () {
                            // _bottomSheet();
                          },
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .3),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 153, 152, 152))),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black54,
                                size: 35,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(10),
                  const Center(
                      child: Text('no data',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            );
          }
        },
      );
    } else {
      //***********filtre 1********** */

      return StreamBuilder(
        stream: etabDBoperations()
            .academiaStore
            .doc('mf')
            .collection('centres de formations')
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

            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  const Gap(150),
                  Center(
                      child: Column(
                    children: [
                      const Text("Ajouter un centre de formation",
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
              );
            } else {
              centres = [];
              for (int i = 0; i < documents.length; i++) {
                centres.add(documents[i]['nom']);
              }
              return StreamBuilder(
                stream: dbFormation()
                    .academiaStore
                    .doc('mf')
                    .collection('specialités')
                    .where('diplome', isEqualTo: 'Certification de Compétence')
                    .where('centre', whereIn: centres)
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
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;

                    if (snapshot.data!.docs.isEmpty) {
                      return Column(
                        children: [
                          const Gap(150),
                          Center(
                              child: Column(
                            children: [
                              const Text("Ajouter une spécialité",
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
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            //height: 620,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  //List images = documents[index]['galleries'];
                                  // List transports = documents[index]['transport'];
                                  //int n = images.length;

                                  return Container(
                                    //height: 500,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    margin: const EdgeInsets.only(
                                        bottom: 15, left: 5, right: 5, top: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: Text(
                                          documents[index]['specialité'],
                                          style: TextStyle(
                                              letterSpacing: 1.8,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                        Gap(10),
                                        Row(
                                          children: [
                                            Text(
                                              'Centre de formation : ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(documents[index]['centre'])
                                          ],
                                        ),
                                        Gap(5),
                                        Divider(),
                                        DEtailsDiplomeWidget(
                                          diplome: documents[index]['diplome'],
                                        ),
                                        Divider(),
                                        Gap(5),
                                        DetailSecteurWidget(
                                          secteur: documents[index]['secteur'],
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: TextButton.icon(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      MFFormationShowModules(
                                                        centre: documents[index]
                                                            ['centre'],
                                                        specialite:
                                                            documents[index]
                                                                ['specialité'],
                                                      ));
                                                },
                                                icon: Icon(Icons.open_in_new),
                                                label: Text('Modules')))
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
                      child: Column(
                        children: [
                          const Gap(10),
                          const Center(
                              child: Text('no data',
                                  style: TextStyle(color: Colors.black))),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .6,
                              maxHeight: 80),
                          child: RichText(
                              text: TextSpan(
                                  text: "Ministère de formation\n",
                                  style: const TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  children: [
                                TextSpan(
                                  text: '   Centre de formation',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[500]),
                                )
                              ])),
                        ),
                        GestureDetector(
                          onTap: () {
                            // _bottomSheet();
                          },
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * .3),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 153, 152, 152))),
                              child: const Icon(
                                Icons.add,
                                color: Colors.black54,
                                size: 35,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(10),
                  const Center(
                      child: Text('no data',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            );
          }
        },
      );
    }
  }
}
