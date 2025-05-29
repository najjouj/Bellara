import 'dart:io';

import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/commun/constants/constants.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/commun/widgets/multiselection_child_view.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/backend/DBwelcomeInfo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileInfoParent extends StatefulWidget {
  final String name;
  const ProfileInfoParent({super.key, required this.name});

  @override
  State<ProfileInfoParent> createState() => _ProfileInfoParentState();
}

class _ProfileInfoParentState extends State<ProfileInfoParent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController univEtabAnnee = TextEditingController();
  TextEditingController ecoleEtabAnnee = TextEditingController();
  TextEditingController collegeEtabAnnee = TextEditingController();
  TextEditingController lyceeEtabAnnee = TextEditingController();
  String nivScolaire = '';
  String profession = '';
  String avatarUrl = '';
  String bannerUrl = '';
  String ecoleP = '';
  String college = '';
  String lycee = '';
  String univetab = '';
  String selectedStatut = '';
  bool logLoading = false;
  String etatInv = '';
  List<String> lycees = [];
  List<String> ecoles = [];
  List<String> colleges = [];
  List<String> univEtab = [];
  var elevesList = [];
  var etudiantsList = [];
  var selectedelevesList = [];
  var selectdetudiantsList = [];
  List<String> statuts = ['Elève', 'Etudiant'];
  String uidUser = FirebaseAuth.instance.currentUser!.uid;

  callbackSelectEleves(varSelectedBloc) {
    setState(() {
      selectedelevesList = varSelectedBloc;
    });
  }

  callbackSelectEtudiants(varSelectedBloc) {
    setState(() {
      selectdetudiantsList = varSelectedBloc;
    });
  }

  callbackStatut(varSelectedBloc) {
    setState(() {
      selectedStatut = varSelectedBloc;
    });
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Gap(45),

            Stack(children: [
              Stack(children: [
                Container(
                  width: double.infinity,
                  child: (bannerUrl == '')
                      ? Image.network(
                          Constants.bannerDefault,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          bannerUrl,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                    right: 4,
                    bottom: 4,
                    child: GestureDetector(
                      onTap: () {
                        _updateBanner();
                      },
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
                      backgroundImage: (avatarUrl == '')
                          ? NetworkImage(Constants.avatarDefault)
                          : NetworkImage(avatarUrl),
                    ),
                  ),
                  Positioned(
                      right: 3,
                      top: 6,
                      child: GestureDetector(
                        onTap: () {
                          _updateAvator();
                        },
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
                        ),
                      ))
                ]),
              )
            ]),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
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
                  IconButton(
                      onPressed: () {
                        _updateInfo();
                      },
                      icon: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.save_rounded,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 25, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Famille ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          letterSpacing: 1.2),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 4,
                    ),
                    margin: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Gap(5),
                        /*

                        GestureDetector(
                          onTap: () {
                            Get.to(() => ListViewSearchScreen(
                                items: statuts,
                                stringCallback: callbackStatut));
                          },
                          child: Container(
                            height: 50,
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
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
                            child: SizedBox(
                              //width: 350,
                              child: (selectedStatut != '')
                                  ? Text(
                                      selectedStatut,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    )
                                  : const Text(
                                      'Statut',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                            ),
                          ),
                        ),
                       
                       */
                        // Gap(15),
                        //**************eleves traitement*************************** */
                        Container(
                          //color: Colors.blue,
                          width: double.infinity,
                          //height: 80,
                          child: StreamBuilder(
                            stream: welcomeDBInfo().eleves.snapshots(),
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
                                  padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
                                  child: Column(
                                    children: [
                                      Gap(10),
                                      Center(
                                          child: Text('no data',
                                              style: TextStyle(
                                                  color: Colors.black))),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                final List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;

                                elevesList = [];
                                for (int i = 0; i < documents.length; i++) {
                                  List famille = documents[i]['Famille'];
                                  List invRecus =
                                      documents[i]['Invitations reçues'];
                                  List invSupp =
                                      documents[i]['Invitations supprimées'];

                                  //*****************famille ******************* */
                                  for (int j = 0; j < famille.length; j++) {
                                    if (famille[j]['uid'] == uidUser) {
                                      etatInv = 'membre';
                                    }
                                  }
                                  //****************inv recus    ************************ */
                                  for (int j = 0; j < famille.length; j++) {
                                    if (invRecus[j]['uid'] == uidUser) {
                                      etatInv = 'envoyée';
                                    }
                                  }
                                  //****************inv supprimees ************************* */
                                  for (int j = 0; j < famille.length; j++) {
                                    if (invSupp[j]['uid'] == uidUser) {
                                      etatInv = 'supprimée';
                                    }
                                  }
                                  elevesList.add({
                                    'uid': documents[i]['uid'],
                                    'nom': documents[i]['name'],
                                    'photoUrl': documents[i]['photoUrl'],
                                    'statut': 'élève',
                                    'etablissement actuel': documents[i]
                                        ['etablissement actuel'],
                                    'niveau scolaire': documents[i]
                                        ['niveau scolaire'],
                                    'specialité': documents[i]['specialité'],
                                    'etat': etatInv,
                                    'tapped': false
                                  });
                                  print(documents[i]['name']);
                                  print(documents[i]['uid']);
                                  print(documents[i]['etablissement actuel']);
                                  print(documents[i]['specialité']);
                                }
                                if (snapshot.data!.docs.isEmpty) {
                                  return Column(
                                    children: [
                                      Gap(150),
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
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          ChildMultiselectionListViewSearch(
                                              items: elevesList,
                                              stringCallback:
                                                  callbackSelectEleves));
                                    },
                                    child: Container(
                                      //height: 50,
                                      alignment: Alignment.centerLeft,

                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SizedBox(
                                        //width: 350,
                                        child: (selectedelevesList.isNotEmpty)
                                            ? Column(
                                                children: selectedelevesList
                                                    .map((e) => ListTile(
                                                          trailing:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedelevesList
                                                                    .remove(e);
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Colors
                                                                      .deepPurple),
                                                              child: Text(
                                                                'Retirer',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          leading: CircleAvatar(
                                                            radius: 15,
                                                            backgroundImage:
                                                                NetworkImage(e[
                                                                    'photoUrl']),
                                                          ),
                                                          title: Text(
                                                            e['nom'],
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          subtitle: Text(
                                                            e['etablissement actuel'],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ))
                                                    .toList(),
                                              )
                                            : const Text(
                                                'Rechercher élèves',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 60, 10, 0),
                                  child: Column(
                                    children: [
                                      Gap(150),
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
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Gap(20)
                        //*****************etudiants traitement********************************* */
                        ,
                        Container(
                          //color: Colors.blue,
                          width: double.infinity,
                          //height: 80,
                          child: StreamBuilder(
                            stream: welcomeDBInfo().etudiants.snapshots(),
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
                                  padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
                                  child: Column(
                                    children: [
                                      Gap(10),
                                      Center(
                                          child: Text('no data',
                                              style: TextStyle(
                                                  color: Colors.black))),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                final List<DocumentSnapshot> documents =
                                    snapshot.data!.docs;

                                etudiantsList = [];
                                for (int i = 0; i < documents.length; i++) {
                                  List famille = documents[i]['Famille'];
                                  List invRecus =
                                      documents[i]['Invitations reçues'];
                                  List invSupp =
                                      documents[i]['Invitations supprimées'];

                                  //*****************famille ******************* */
                                  for (int j = 0; j < famille.length; j++) {
                                    if (famille[j]['uid'] == uidUser) {
                                      etatInv = 'membre';
                                    }
                                  }
                                  //****************inv recus    ************************ */
                                  for (int j = 0; j < famille.length; j++) {
                                    if (invRecus[j]['uid'] == uidUser) {
                                      etatInv = 'envoyée';
                                    }
                                  }
                                  //****************inv supprimees ************************* */
                                  for (int j = 0; j < famille.length; j++) {
                                    if (invSupp[j]['uid'] == uidUser) {
                                      etatInv = 'supprimée';
                                    }
                                  }
                                  etudiantsList.add({
                                    'uid': documents[i]['uid'],
                                    'nom': documents[i]['name'],
                                    'photoUrl': documents[i]['photoUrl'],
                                    'statut': 'etudiant',
                                    'etablissement actuel': documents[i]
                                        ['etablissement actuel'],
                                    'niveau scolaire': documents[i]
                                        ['niveau scolaire'],
                                    'specialité': documents[i]['specialité'],
                                    'etat': etatInv,
                                    'tapped': false
                                  });
                                  print(documents[i]['name']);
                                  print(documents[i]['uid']);
                                  print(documents[i]['etablissement actuel']);
                                  print(documents[i]['specialité']);
                                }
                                if (snapshot.data!.docs.isEmpty) {
                                  return Column(
                                    children: [
                                      Gap(150),
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
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          ChildMultiselectionListViewSearch(
                                              items: etudiantsList,
                                              stringCallback:
                                                  callbackSelectEtudiants));
                                    },
                                    child: Container(
                                      //height: 50,
                                      alignment: Alignment.centerLeft,
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SizedBox(
                                        //width: 350,
                                        child: (selectdetudiantsList.isNotEmpty)
                                            ? Column(
                                                children: selectdetudiantsList
                                                    .map((e) => ListTile(
                                                          trailing:
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectdetudiantsList
                                                                    .remove(e);
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                      .deepPurple),
                                                              child: Text(
                                                                'Retirer',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          leading: CircleAvatar(
                                                            radius: 15,
                                                            backgroundImage:
                                                                NetworkImage(e[
                                                                    'photoUrl']),
                                                          ),
                                                          title: Text(
                                                            e['nom'],
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          subtitle: Text(
                                                              e[
                                                                  'etablissement actuel'],
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54)),
                                                        ))
                                                    .toList(),
                                              )
                                            : const Text(
                                                'Rechercher étudiants',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 60, 10, 0),
                                  child: Column(
                                    children: [
                                      Gap(150),
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
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Gap(20)
                      ],
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 25),
              child: Form(
                key: _formKey,
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
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: ecoleEtabAnnee,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'année est vide';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Année',

                                      // contentPadding: const EdgeInsets.symmetric( horizontal: 15, vertical: 25),
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                      // contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                )
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
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: collegeEtabAnnee,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'année est vide';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Année',

                                      // contentPadding: const EdgeInsets.symmetric( horizontal: 15, vertical: 25),
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                      // contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                )
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
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: lyceeEtabAnnee,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'année est vide';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Année',

                                      // contentPadding: const EdgeInsets.symmetric( horizontal: 15, vertical: 25),
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                      // contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                )
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
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: univEtabAnnee,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'année est vide';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Année',

                                      // contentPadding: const EdgeInsets.symmetric( horizontal: 15, vertical: 25),
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
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
                                      // contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateBanner() async {
    File? img = await pickImageFromGallery(context);
    //String nomEtab = nameController.text.trim();
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    print("avatars/$uidUser");
    setState(() {
      logLoading = true;
    });
    bannerUrl = await saveimageFiles("banners/$uidUser", 'banner', img, null)
        .then((value) {
      setState(() {
        logLoading = false;
      });
      return value;
    });
  }

  void _updateAvator() async {
    File? img = await pickImageFromGallery(context);
    //String nomEtab = nameController.text.trim();
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    print("avatars/$uidUser");
    setState(() {
      logLoading = true;
    });
    avatarUrl = await saveimageFiles("avatars/$uidUser", 'avatar', img, null)
        .then((value) {
      setState(() {
        logLoading = false;
      });
      return value;
    });
  }

  void _updateInfo() {
    if (_formKey.currentState!.validate()) {
      String uidUser = FirebaseAuth.instance.currentUser!.uid;
      // String amicaleUniv = 'amicale ${univEtab.toLowerCase}';

      setState(() {
        logLoading = true;
        welcomeDBInfo().parentWelcomeInfo(
            uidUser,
            widget.name,
            avatarUrl,
            bannerUrl,
            selectedelevesList,
            selectdetudiantsList,
            nivScolaire,
            profession,
            ecoleP,
            college,
            lycee,
            univetab);

        etabDBoperations().amicaleAddmembreCadre(
            uidUser,
            widget.name,
            ecoleP,
            ecoleEtabAnnee.text.trim(),
            college,
            collegeEtabAnnee.text.trim(),
            lycee,
            lyceeEtabAnnee.text.trim(),
            univetab,
            univEtabAnnee.text.trim());
      });
      setState(() {
        logLoading = false;
      });
    }
  }
}
