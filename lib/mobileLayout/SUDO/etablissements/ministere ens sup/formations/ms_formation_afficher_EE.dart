import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MSFormationAfficherEE extends StatelessWidget {
  final String speciality;
  final String uniteEnsg;
  const MSFormationAfficherEE(
      {super.key, required this.speciality, required this.uniteEnsg});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbFormation()
          .academiaStore
          .doc('ms')
          .collection('specialités')
          .doc(speciality)
          .collection("plan d'etude")
          .doc(uniteEnsg)
          .collection("element d'enseignment")
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
            return Container(
              padding:
                  EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.deepPurple[100],
              ),
              //width: double.infinity,

              child: PageView.builder(
                controller: PageController(viewportFraction: .75),
                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: documents.length,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    // width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Libellé :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2),
                            ),
                            Gap(5),
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            .30),
                                child: Text(
                                  documents[index]['libellé'],
                                  //overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Coefficient :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2),
                            ),
                            Gap(5),
                            Text(documents[index]['coef']),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              'Crédit :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2),
                            ),
                            Gap(5),
                            Text(documents[index]['credit']),
                          ],
                        ),
                        Gap(5),
                        Row(
                          children: [
                            Text(
                              "Modalité d'evaluation :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1.2),
                            ),
                            Gap(5),
                            Text(documents[index]['regime']),
                          ],
                        ),
                        Container(
                          height: 170,
                          width: 220,
                          // width: double.maxFinite,
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple[100]!.withOpacity(.4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Volume horaire',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 1.2),
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Text(
                                    'Cours :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 1.2),
                                  ),
                                  Gap(5),
                                  Text(
                                      documents[index]['volume horaire cours']),
                                ],
                              ),
                              Gap(5),
                              Row(
                                children: [
                                  Text(
                                    'TD :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 1.2),
                                  ),
                                  Gap(5),
                                  Text(documents[index]['volume horaire TD']),
                                ],
                              ),
                              Gap(5),
                              Row(
                                children: [
                                  Text(
                                    'TP :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 1.2),
                                  ),
                                  Gap(5),
                                  Text(documents[index]['volume horaire TP']),
                                ],
                              ),
                              Gap(5),
                              Row(
                                children: [
                                  Text(
                                    'Total :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 1.2),
                                  ),
                                  Gap(5),
                                  Text(
                                    documents[index]['volume horaire total'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            );
          } else {
            return Center(
                child: Text(' no data, is empty',
                    style: TextStyle(color: Colors.black)));
          }
        } else {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 60, 10, 0),
            child: Column(
              children: [
                const Gap(10),
                const Center(
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
