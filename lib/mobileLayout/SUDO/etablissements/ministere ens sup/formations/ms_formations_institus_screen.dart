import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MSFormationsINstitusScreen extends StatefulWidget {
  final String university;
  const MSFormationsINstitusScreen({super.key, required this.university});

  @override
  State<MSFormationsINstitusScreen> createState() =>
      _MSFormationsINstitusScreenState();
}

class _MSFormationsINstitusScreenState
    extends State<MSFormationsINstitusScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.university != '')
      return StreamBuilder(
        stream: dbFormation()
            .academiaStore
            .doc('ms')
            .collection('specialités')
            .where('université', isEqualTo: widget.university)
            .where('formation', isEqualTo: "etudes medicales")
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
                      const Text("Ajouter une specialité",
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
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // List transports = documents[index]['transport'];

                      return Container(
                        padding: EdgeInsets.only(bottom: 10),
                        margin: const EdgeInsets.only(
                          bottom: 15,
                          right: 5,
                          left: 5,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 187, 163, 228)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 8, top: 5),
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              .90),
                                  child: Text(
                                    documents[index]['specialité'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Gap(10),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 8, top: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Université : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .750),
                                      child: Text(
                                        documents[index]['université'],
                                        textAlign: TextAlign.justify,
                                      ))
                                ],
                              ),
                            ),
                            Gap(10),
                            Container(
                              // width:
                              margin:
                                  EdgeInsets.only(left: 15, right: 8, top: 5),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Etablissement : ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Gap(5),
                                  Text(
                                    documents[index]['etablissements'],
                                    style: TextStyle(),
                                  )
                                ],
                              ),
                            ),
                            Gap(10),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, right: 15, top: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      // width:                                        MediaQuery.of(context).size.width * .45,
                                      child: Row(children: [
                                    Text(
                                      'Formation : ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(documents[index]['formation']),
                                  ])),
                                  Gap(15),
                                  Container(
                                    // width:                                        MediaQuery.of(context).size.width * .45,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Domaine de la formation : ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .42),
                                          child: Text(documents[index]
                                              ['domaine de la formation']),
                                        )
                                      ],
                                    ),
                                  ),
                                  Gap(15),
                                  Container(
                                    // width:                                        MediaQuery.of(context).size.width * .45,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Type de diplôme : ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(documents[index]['diplome'])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              );
            }
          } else {
            return Column(
              children: [
                const Gap(150),
                Center(
                    child: Column(
                  children: [
                    const Text("Ajouter une specialité",
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
          }
        },
      );
    else
      return StreamBuilder(
        stream: dbFormation()
            .academiaStore
            .doc('ms')
            .collection('specialités')
            .where('formation', isEqualTo: "etudes medicales")
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
                      const Text("Ajouter une faculté",
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
                          // List images = documents[index]['galerieUrls'];
                          // List transports = documents[index]['transport'];
                          //  int n = images.length;

                          return Container(
                            padding: EdgeInsets.only(bottom: 10),
                            margin: const EdgeInsets.only(
                              bottom: 15,
                              right: 5,
                              left: 5,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color.fromARGB(255, 187, 163, 228)),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 8, top: 5),
                                  child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .90),
                                      child: Text(
                                        documents[index]['specialité'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Gap(10),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 8, top: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Université : ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .750),
                                          child: Text(
                                            documents[index]['université'],
                                            textAlign: TextAlign.justify,
                                          ))
                                    ],
                                  ),
                                ),
                                Gap(10),
                                Container(
                                  // width:
                                  margin: EdgeInsets.only(
                                      left: 15, right: 8, top: 5),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Etablissement : ',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Gap(5),
                                      Text(
                                        documents[index]['etablissements'],
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                ),
                                Gap(10),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 15, top: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          // width:                                        MediaQuery.of(context).size.width * .45,
                                          child: Row(children: [
                                        Text(
                                          'Formation : ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(documents[index]['formation']),
                                      ])),
                                      Gap(15),
                                      Container(
                                        // width:                                        MediaQuery.of(context).size.width * .45,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Domaine de la formation : ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .42),
                                              child: Text(documents[index]
                                                  ['domaine de la formation']),
                                            )
                                          ],
                                        ),
                                      ),
                                      Gap(15),
                                      Container(
                                        // width:                                        MediaQuery.of(context).size.width * .45,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Type de diplôme : ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(documents[index]['diplome'])
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            }
          } else {
            return Column(
              children: [
                const Gap(150),
                Center(
                    child: Column(
                  children: [
                    const Text("Ajouter une specialité",
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
          }
        },
      );
  }
}
