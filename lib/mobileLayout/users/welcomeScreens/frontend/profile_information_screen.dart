// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bellaraa/commun/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';

class ProfileInformationScreen extends StatefulWidget {
  final String name;

  ProfileInformationScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  String ecoleP = '';
  String college = '';
  String lycee = '';
  String univetab = '';
  List<String> lycees = [];
  List<String> ecoles = [];
  List<String> colleges = [];
  List<String> univEtab = [];
  ecolecallback(varSelectedNatEtab) {
    setState(() {
      ecoleP = varSelectedNatEtab;
    });
  }

  collegecallback(varSelectedNatEtab) {
    setState(() {
      college = varSelectedNatEtab;
    });
  }

  lyceecallback(varSelectedNatEtab) {
    setState(() {
      lycee = varSelectedNatEtab;
    });
  }

  univcallback(varSelectedNatEtab) {
    setState(() {
      univetab = varSelectedNatEtab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 900,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Gap(45),
              Stack(children: [
                Stack(children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      Constants.bannerDefault,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      right: 3,
                      bottom: 4,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.grey.withOpacity(.3),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ))
                ]),
                Positioned(
                  bottom: 5,
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(Constants.avatarDefault),
                      ),
                    ),
                    Positioned(
                        right: 3,
                        top: 3,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                          ),
                        ))
                  ]),
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                    text: TextSpan(
                        text: 'Bienvenue\n ',
                        style: TextStyle(
                            letterSpacing: 1.4,
                            color: Colors.grey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                          text: widget.name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w200))
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Joindre les amicales des établissements ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            letterSpacing: 1.2),
                      ),
                    ),
                    Gap(5),
                    //***********************ecoles primaires ***********************************/
                    Container(
                      height: 420,
                      padding: EdgeInsets.only(
                        top: 15,
                        left: 4,
                      ),
                      //margin: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      //color: Colors.amber,
                      child: Column(
                        children: [
                          Container(
                            //color: Colors.blue,
                            width: double.infinity,
                            height: 80,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //color: Colors.pink,
                                  width: 270,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('me')
                                        .collection('etablissements')
                                        .where('nature',
                                            isEqualTo: 'Ecole primaire')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.deepPurple,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(10),
                                              Center(
                                                  child: Text('no data',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))),
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasData) {
                                        final List<DocumentSnapshot> documents =
                                            snapshot.data!.docs;

                                        ecoles = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          ecoles.add(documents[i]['nom']);
                                        }
                                        if (snapshot.data!.docs.isEmpty) {
                                          return Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Gap(5),

                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ListViewSearchScreen(
                                                          items: ecoles,
                                                          stringCallback:
                                                              ecolecallback));
                                                },
                                                child: Container(
                                                  height: 80,
                                                  width: double.maxFinite,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.deepPurple
                                                            .shade100,
                                                      ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: (ecoleP != '')
                                                      ? Text(
                                                          ecoleP,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'Ecole primaire',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                  Image.asset(
                                                    'assets/icons/school.png',
                                                    height: 30,
                                                    width: 30,
                                                    color: Colors.deepPurple,
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: 60,
                                    width: 90,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Année',
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade100,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade400,
                                            )),
                                      ),
                                    ))
                              ],
                            ),
                          ),

                          //************************colleges***************************** */
                          Gap(25),

                          Container(
                            height: 80,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 270,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('me')
                                        .collection('etablissements')
                                        .where('nature', isEqualTo: 'Collège')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.deepPurple,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(10),
                                              Center(
                                                  child: Text('no data',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))),
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasData) {
                                        final List<DocumentSnapshot> documents =
                                            snapshot.data!.docs;

                                        colleges = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          colleges.add(documents[i]['nom']);
                                        }
                                        if (snapshot.data!.docs.isEmpty) {
                                          return Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ListViewSearchScreen(
                                                          items: colleges,
                                                          stringCallback:
                                                              collegecallback));
                                                },
                                                child: Container(
                                                  height: 80,
                                                  width: double.maxFinite,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.deepPurple
                                                            .shade100,
                                                      ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: (college != '')
                                                      ? Text(
                                                          college,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'Collège',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                  Image.asset(
                                                    'assets/icons/school.png',
                                                    height: 30,
                                                    width: 30,
                                                    color: Colors.deepPurple,
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: 60,
                                    width: 90,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Année',
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade100,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade400,
                                            )),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          //**********************Lycees ******************************************** */
                          Gap(25),

                          Container(
                            height: 80,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 270,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('me')
                                        .collection('etablissements')
                                        .where('nature',
                                            isEqualTo: 'Lycée secondaire')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.deepPurple,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(10),
                                              Center(
                                                  child: Text('no data',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))),
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasData) {
                                        final List<DocumentSnapshot> documents =
                                            snapshot.data!.docs;

                                        lycees = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          lycees.add(documents[i]['nom']);
                                        }
                                        if (snapshot.data!.docs.isEmpty) {
                                          return Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Gap(5),

                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ListViewSearchScreen(
                                                          items: lycees,
                                                          stringCallback:
                                                              lyceecallback));
                                                },
                                                child: Container(
                                                  height: 80,
                                                  width: double.maxFinite,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.deepPurple
                                                            .shade100,
                                                      ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: (lycee != '')
                                                      ? Text(
                                                          lycee,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'Lycée secondaire',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                  Image.asset(
                                                    'assets/icons/school.png',
                                                    height: 30,
                                                    width: 30,
                                                    color: Colors.deepPurple,
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: 60,
                                    width: 90,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Année',
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade100,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade400,
                                            )),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          //*****************************université ************************************** */
                          Gap(25),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 270,
                                  height: 80,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('ms')
                                        .collection('etablissements')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.deepPurple,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(10),
                                              Center(
                                                  child: Text('no data',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))),
                                            ],
                                          ),
                                        );
                                      } else if (snapshot.hasData) {
                                        final List<DocumentSnapshot> documents =
                                            snapshot.data!.docs;

                                        univEtab = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          univEtab.add(documents[i]['nom']);
                                        }
                                        if (snapshot.data!.docs.isEmpty) {
                                          return Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Gap(5),

                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(() =>
                                                      ListViewSearchScreen(
                                                          items: univEtab,
                                                          stringCallback:
                                                              univcallback));
                                                },
                                                child: Container(
                                                  height: 80,
                                                  width: double.maxFinite,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.deepPurple
                                                            .shade100,
                                                      ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: (univetab != '')
                                                      ? Text(
                                                          univetab,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'université',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 60, 10, 0),
                                          child: Column(
                                            children: [
                                              Gap(150),
                                              Center(
                                                  child: Column(
                                                children: [
                                                  const Text(
                                                      "Ajouter une université",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                  Image.asset(
                                                    'assets/icons/school.png',
                                                    height: 30,
                                                    width: 30,
                                                    color: Colors.deepPurple,
                                                  )
                                                ],
                                              )),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                    height: 60,
                                    width: 90,
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Année',
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade100,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.deepPurple.shade400,
                                            )),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
