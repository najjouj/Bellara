import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../DBoperation/etab_DB_operation.dart';

class PrivateUniversityScreen extends StatelessWidget {
  final String governorat;
  const PrivateUniversityScreen({super.key, required this.governorat});

  @override
  Widget build(BuildContext context) {
    if (governorat != '')
      return Scaffold(
          body: StreamBuilder(
        stream: etabDBoperations()
            .academiaStore
            .doc('ms')
            .collection('universities')
            .where('type', isEqualTo: 'privé')
            .where('gouvernorat', isEqualTo: governorat)
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
                      const Text("Ajouter une université",
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
                          List images = documents[index]['galerieUrls'];
                          // List transports = documents[index]['transport'];
                          int n = images.length;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 8, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage:
                                                NetworkImage(images[0]),
                                          ),
                                          const Gap(5),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxWidth: 250),
                                            child: Text(
                                              documents[index]['nom'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              //onTap: () => _moreBottomSheet(context,documents[index]['nom'],       images[0]),
                                              child: const Icon(
                                                Icons.more_horiz_outlined,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ),
                                            const Gap(12),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        ' Gouvernorat',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      const Gap(5),
                                      Text(
                                        documents[index]['gouvernorat'],
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(15),
                                Stack(children: [
                                  CarouselSlider.builder(
                                    itemCount: images.length,
                                    itemBuilder: (context, i, j) {
                                      return Container(
                                        height: 150,
                                        width: double.infinity,
                                        //margin: EdgeInsets.all(5),
                                        color: Colors.grey[100],
                                        child: Stack(children: [
                                          Container(
                                            decoration: const BoxDecoration(),
                                            child: ClipRRect(
                                              child: Image.network(
                                                images[i],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: 10,
                                              bottom: 10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(.3),
                                                    shape: BoxShape.circle),
                                                child: Text(
                                                  '${i + 1}/$n',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ]),
                                      );
                                    },
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      aspectRatio: 1.2,
                                      initialPage: 2,
                                    ),
                                  ),
                                ]),
                                const Gap(5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 5, right: 8, bottom: 10),
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          text: documents[index]['nom'] + ' ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          children: [
                                            TextSpan(
                                              text: documents[index]
                                                  ['description'],
                                              style: TextStyle(
                                                  height: 1.5,
                                                  wordSpacing: 1.1,
                                                  letterSpacing: .5,
                                                  color: Colors.grey[700],
                                                  fontSize: 13),
                                            )
                                          ])),
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
                                  text:
                                      "Ministere de l'enseignement superieur\n",
                                  style: const TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  children: [
                                TextSpan(
                                  text: 'Les universités',
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
      ));
    else
      return Scaffold(
          body: StreamBuilder(
        stream: etabDBoperations()
            .academiaStore
            .doc('ms')
            .collection('universities')
            .where('type', isEqualTo: 'privé')
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
                      const Text("Ajouter une universités",
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
                          List images = documents[index]['galerieUrls'];
                          // List transports = documents[index]['transport'];
                          int n = images.length;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 8, top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundImage:
                                                NetworkImage(images[0]),
                                          ),
                                          const Gap(5),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxWidth: 250),
                                            child: Text(
                                              documents[index]['nom'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              //onTap: () => _moreBottomSheet(context,documents[index]['nom'],       images[0]),
                                              child: const Icon(
                                                Icons.more_horiz_outlined,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ),
                                            const Gap(12),
                                            GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        ' Gouvernorat',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      const Gap(5),
                                      Text(
                                        documents[index]['gouvernorat'],
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(15),
                                Stack(children: [
                                  CarouselSlider.builder(
                                    itemCount: images.length,
                                    itemBuilder: (context, i, j) {
                                      return Container(
                                        height: 150,
                                        width: double.infinity,
                                        //margin: EdgeInsets.all(5),
                                        color: Colors.grey[100],
                                        child: Stack(children: [
                                          Container(
                                            decoration: const BoxDecoration(),
                                            child: ClipRRect(
                                              child: Image.network(
                                                images[i],
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              right: 10,
                                              bottom: 10,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(.3),
                                                    shape: BoxShape.circle),
                                                child: Text(
                                                  '${i + 1}/$n',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ]),
                                      );
                                    },
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      aspectRatio: 1.2,
                                      initialPage: 2,
                                    ),
                                  ),
                                ]),
                                const Gap(5),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 5, right: 8, bottom: 10),
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                          text: documents[index]['nom'] + ' ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                          children: [
                                            TextSpan(
                                              text: documents[index]
                                                  ['description'],
                                              style: TextStyle(
                                                  height: 1.5,
                                                  wordSpacing: 1.1,
                                                  letterSpacing: .5,
                                                  color: Colors.grey[700],
                                                  fontSize: 13),
                                            )
                                          ])),
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
                                  text:
                                      "Ministere de l'enseignement superieur\n",
                                  style: const TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  children: [
                                TextSpan(
                                  text: '  Les universités',
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
      ));
  }
}
