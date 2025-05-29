import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MFFormationUniteCard extends StatelessWidget {
  final String specialite;
  final String module;
  const MFFormationUniteCard(
      {super.key, required this.specialite, required this.module});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbFormation()
          .academiaStore
          .doc('mf')
          .collection('specialités')
          .doc(specialite.toLowerCase())
          .collection('modules')
          .doc(module)
          .collection('unités')
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
            return Center(
                child: Text('no data is empty',
                    style: TextStyle(color: Colors.black)));
          } else {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return Container(
              width: double.infinity,
              //color: Colors.amber,
              height: 120,
              child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(viewportFraction: .85),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unité : ',
                                ),
                                ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 120),
                                    child: Text(
                                      documents[index]['libellé'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                            Gap(10),
                            Row(
                              children: [
                                Text('Coefficient : '),
                                Text(
                                  documents[index]['coefficient'],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ));
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
    );
  }
}
