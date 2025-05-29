import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'me_formation_matiere_card.dart';

class MEFormationAfficherNiveauxEcole extends StatelessWidget {
  MEFormationAfficherNiveauxEcole({super.key});
  final List<String> ecole = [
    'Première année',
    'Deuxième année',
    'Troisième année',
    'Quatrième année',
    'Cinquième année',
    'Sixième année'
  ];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbFormation()
          .academiaStore
          .doc('me')
          .collection('niveaux scolaire')
          .where('cycle', isEqualTo: 'Enseignement de base')
          .where('niveau', whereIn: List.from(ecole))
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
                    child: Text('no data erreur',
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
                    const Text("Ajouter un niveau scolaire",
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
              height: 400,
              //height: 600,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.only(
                            top: 15, left: 10, bottom: 20),
                        margin: const EdgeInsets.all(8),
                        height: 280,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Text(
                              documents[index]['cycle'],
                              style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Gap(5),
                            Text(
                              documents[index]['nom'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.deepPurple[200],
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.5),
                            ),
                            const Gap(10),
                            MEFormationMatiereCard(
                              niv: documents[index]['nom'],
                            )
                          ],
                        ));
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
                    child: Text('no data else',
                        style: TextStyle(color: Colors.black))),
              ],
            ),
          );
        }
      },
    );
  }
}
