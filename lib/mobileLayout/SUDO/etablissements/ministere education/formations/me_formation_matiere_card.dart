import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'me_formation_update_matiere.dart';

class MEFormationMatiereCard extends StatelessWidget {
  final String niv;
  const MEFormationMatiereCard({super.key, required this.niv});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbFormation()
          .academiaStore
          .doc('me')
          .collection('niveaux scolaire')
          .doc(niv.toLowerCase())
          .collection('matieres')
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
                    child:
                        Text('no data', style: TextStyle(color: Colors.black))),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          if (snapshot.data!.docs.isEmpty) {
            return Column(
              children: [
                const Gap(90),
                Center(
                    child: Column(
                  children: [
                    const Text("Ajouter une matière",
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
            return Container(
              height: 160,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(viewportFraction: .75),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var mat = documents[index];
                    List supports = mat['supports'];
                    return GestureDetector(
                      onTap: () => Get.to(() =>
                          MEFormationUpdateMatiere(matiere: mat, uidNiv: niv)),
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, bottom: 5, right: 10),
                          margin: const EdgeInsets.all(8),
                          height: 110,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  mat['matière'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14),
                                ),
                              ),
                              Gap(8),
                              Text('Domaine : ' + mat['domaine']),
                              const Gap(5),
                              Text('Coefficient : ' + mat['coef']),
                              const Gap(5),
                              Row(
                                children: [
                                  Text('Supports : ${supports.length}'),
                                  const Gap(5),
                                  const Icon(
                                    Icons.file_present,
                                    size: 15,
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  }),
            );
          }
        } else {
          return const Padding(
            padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
            child: Column(
              children: [
                Gap(10),
                Center(
                    child:
                        Text('no data', style: TextStyle(color: Colors.black))),
              ],
            ),
          );
        }
      },
    );
  }
}
