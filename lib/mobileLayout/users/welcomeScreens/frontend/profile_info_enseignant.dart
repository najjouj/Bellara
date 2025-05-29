import 'dart:io';

import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/commun/constants/constants.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/commun/widgets/multiselection_list_view_search.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/backend/DBwelcomeInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileInfoEnseignant extends StatefulWidget {
  final String name;
  const ProfileInfoEnseignant({super.key, required this.name});

  @override
  State<ProfileInfoEnseignant> createState() => _ProfileInfoEnseignantState();
}

class _ProfileInfoEnseignantState extends State<ProfileInfoEnseignant> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      mfSubjects = [];
      msSubjects = [];
    });
    getData();
    setState(() {});

    //getMSsubjects();

    // print('msssssssssssssssssssssssssssssssssssssssssssssssssss');

    // getMFSubjects();
    print('mffffffffffffffffffffffffffffffffffffffffffffffffffffff');

    print('msssssssssssssssssssssssssssssssssssssssssssssssssss count' +
        msSubjects.length.toString());
    print('mffffffffffffffffffffffffffffffffffffff count' +
        mfSubjects.length.toString());
  }

  bool isloading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController univEtabAnnee = TextEditingController();
  TextEditingController ecoleEtabAnnee = TextEditingController();
  TextEditingController collegeEtabAnnee = TextEditingController();
  TextEditingController lyceeEtabAnnee = TextEditingController();
  String centreActuel = '';
  String avatarUrl = '';
  String bannerUrl = '';
  bool logLoading = false;
  String actuelMinistere = '';
  String ecoleP = '';
  String college = '';
  String lycee = '';
  String univetab = '';
  String actuelEtabName = '';

  String natureEtabActuel = '';

  List<String> msSubjects = [];
  List<String> mfSubjects = [];
  List<String> selectedmfSubjects = [];
  List<String> selectedmsSubjects = [];
  List<String> selectedmeSubjects = [];
  List<String> etabs = [];

  List<String> lycees = [];
  List<String> ecoles = [];
  List<String> colleges = [];
  List<String> univEtab = [];
  String semestre = '';
  //List<String> selectedNatureEtabs = natureTablissment;
  List<String> meEtabsNature = [
    'Ecole primaire',
    'Lycée secondaire',
    'Collège'
  ];
  List<String> msEtabsNature = [
    'Institut supérieur',
    'Ecole supérieur',
    'Faculté'
  ];
  List<String> mfEtabsNature = ['Centre de formation'];

  callbackNatureEtabActuel(varSelectedNatEtab) {
    setState(() {
      natureEtabActuel = varSelectedNatEtab;
      if (meEtabsNature.contains(natureEtabActuel)) {
        actuelMinistere = 'me';
      } else if (msEtabsNature.contains(natureEtabActuel)) {
        actuelMinistere = 'ms';
      } else {
        actuelMinistere = 'mf';
      }
      print('ffffffffffffffffffffffffffffffffffffff');
      print(actuelMinistere);
      print(natureEtabActuel);
    });
  }

  callbackSelectedMSSubjetcs(varSelectedBloc) {
    setState(() {
      selectedmsSubjects.assignAll(varSelectedBloc);

      print('ggggggggggggggg subjetcs ggggggggggggggggggggg');
      for (int i = 0; i < selectedmsSubjects.length; i++) {
        print(selectedmsSubjects[i] + '\n');
      }
    });
  }

  callbackSelectedMFSubjetcs(varSelectedBloc) {
    setState(() {
      selectedmfSubjects.assignAll(varSelectedBloc);

      print('ggggggggggggggg subjetcs ggggggggggggggggggggg');
      for (int i = 0; i < selectedmfSubjects.length; i++) {
        print(selectedmfSubjects[i] + '\n');
      }
    });
  }

  callbackSelectedMESubjetcs(varSelectedBloc) {
    setState(() {
      selectedmeSubjects.assignAll(varSelectedBloc);

      print('ggggggggggggggg subjetcs ggggggggggggggggggggg');
      for (int i = 0; i < selectedmeSubjects.length; i++) {
        print(selectedmeSubjects[i] + '\n');
      }
    });
  }

  callbacCentreActuel(varSelectedBloc) {
    setState(() {
      centreActuel = varSelectedBloc;

      print('gggggggggggggggggggggggggggggggggggg');
      print(actuelEtabName);
    });
  }

  callbackEtabActuel(varSelectedBloc) {
    setState(() {
      actuelEtabName = varSelectedBloc;
    });
  }

  callbackSemestre(varSelectedNatEtab) {
    setState(() {
      semestre = varSelectedNatEtab;

      print('ddddddddddddddddddddddddddddddddddddddddddddd');
      print(semestre);
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
              //color: Colors.red,
              margin: EdgeInsets.only(left: 5, right: 5, top: 25, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Administration ',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          letterSpacing: 1.2),
                    ),
                  ),
                  Container(
                    //height: 420,
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

                        GestureDetector(
                          onTap: () {
                            Get.to(() => ListViewSearchScreen(
                                items: natureTablissment,
                                stringCallback: callbackNatureEtabActuel));
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
                              child: (natureEtabActuel != '')
                                  ? Text(
                                      natureEtabActuel,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    )
                                  : const Text(
                                      "Nature de l'établissement actuel",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                            ),
                          ),
                        ),

                        Gap(15),
                        //****************************ms**************************** */
                        if (msEtabsNature.contains(natureEtabActuel))
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  //color: Colors.blue,
                                  width: double.infinity,
                                  height: 80,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('ms')
                                        .collection('etablissements')
                                        .where('nature',
                                            isEqualTo: natureEtabActuel)
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

                                        etabs = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          etabs.add(documents[i]['nom']);
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
                                                          items: etabs,
                                                          stringCallback:
                                                              callbackEtabActuel));
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
                                                  child: (actuelEtabName != '')
                                                      ? Text(
                                                          actuelEtabName,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'Etablissement actuel',
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
                                Gap(15),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => MultiselectionListViewSearch(
                                        items: msSubjects,
                                        stringCallback:
                                            callbackSelectedMSSubjetcs));
                                  },
                                  child: Container(
                                    // height: 50,
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
                                    child: (selectedmsSubjects.isNotEmpty)
                                        ? GridView.builder(
                                            itemCount:
                                                selectedmsSubjects.length,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 1.9),
                                            itemBuilder: (context, index) {
                                              return ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: 200,
                                                    minHeight: 50),
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors
                                                          .deepPurple.shade200),
                                                  child: Text(
                                                      selectedmsSubjects[
                                                          index]),
                                                ),
                                              );
                                            },
                                          )
                                        : const Text(
                                            "Matières ms",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                  ),
                                ),
                                Gap(15),
                              ],
                            ),
                          ),
                        //*********************************me************************* */
                        if (meEtabsNature.contains(natureEtabActuel))
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  //color: Colors.blue,
                                  width: double.infinity,
                                  height: 80,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('me')
                                        .collection('etablissements')
                                        .where('nature',
                                            isEqualTo: natureEtabActuel)
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

                                        etabs = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          etabs.add(documents[i]['nom']);
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
                                                          items: etabs,
                                                          stringCallback:
                                                              callbackEtabActuel));
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
                                                  child: (actuelEtabName != '')
                                                      ? Text(
                                                          actuelEtabName,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'Etablissement actuel',
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
                                Gap(15),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => MultiselectionListViewSearch(
                                        items: matieres,
                                        stringCallback:
                                            callbackSelectedMESubjetcs));
                                  },
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Container(
                                      height: 150,
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
                                      child: (selectedmeSubjects.isNotEmpty)
                                          ? GridView.builder(
                                              itemCount:
                                                  selectedmeSubjects.length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 2.5),
                                              itemBuilder: (context, index) {
                                                return ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 200,
                                                      minHeight: 50),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.deepPurple
                                                            .shade200),
                                                    child: Text(
                                                        selectedmeSubjects[
                                                            index]),
                                                  ),
                                                );
                                              },
                                            )
                                          : const Text(
                                              "Matières me",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                    ),
                                  ),
                                ),
                                Gap(15),
                              ],
                            ),
                          ),
                        //**************************************mf**************************** */

                        if (mfEtabsNature.contains(natureEtabActuel))
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  //color: Colors.blue,
                                  width: double.infinity,
                                  height: 80,
                                  child: StreamBuilder(
                                    stream: etabDBoperations()
                                        .academiaStore
                                        .doc('mf')
                                        .collection('centres de formations')
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

                                        etabs = [];
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          etabs.add(documents[i]['nom']);
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
                                                          items: etabs,
                                                          stringCallback:
                                                              callbackEtabActuel));
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
                                                  child: (actuelEtabName != '')
                                                      ? Text(
                                                          actuelEtabName,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black87),
                                                        )
                                                      : const Text(
                                                          'Centre de formation',
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
                                Gap(15),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => MultiselectionListViewSearch(
                                        items: mfSubjects,
                                        stringCallback:
                                            callbackSelectedMFSubjetcs));
                                  },
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Container(
                                      height: 150,
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
                                      child: (selectedmfSubjects.isNotEmpty)
                                          ? GridView.builder(
                                              itemCount:
                                                  selectedmfSubjects.length,
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 2.5),
                                              itemBuilder: (context, index) {
                                                return ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 200,
                                                      minHeight: 50),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.deepPurple
                                                            .shade200),
                                                    child: Text(
                                                        selectedmfSubjects[
                                                            index]),
                                                  ),
                                                );
                                              },
                                            )
                                          : const Text(
                                              "Matières mf",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                    ),
                                  ),
                                ),
                                Gap(15),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
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
                          //************************univ***************************** */

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

  void _updateInfo() {
    if (_formKey.currentState!.validate()) {
      String uidUser = FirebaseAuth.instance.currentUser!.uid;
      // String amicaleUniv = 'amicale ${univEtab.toLowerCase}';

      setState(() {
        logLoading = true;
        welcomeDBInfo().enseignantWelcomeInfo(
            uidUser,
            widget.name,
            avatarUrl,
            bannerUrl,
            actuelMinistere,
            selectedmeSubjects,
            selectedmfSubjects,
            selectedmsSubjects,
            natureEtabActuel,
            actuelEtabName,
            ecoleP,
            college,
            lycee,
            univetab);
        print(ecoleP);
        print(college);
        print(lycee);

        etabDBoperations().etabAddPersonnel(uidUser, widget.name, 'Enseignant',
            actuelMinistere, actuelEtabName);
      });

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
      setState(() {
        logLoading = false;
      });
    }
  }

  Future<List<String>> getMSsubjects() async {
    List<String> specialities = [];
    List<String> pe = [];
    List<String> ee = [];

    var a = await FirebaseFirestore.instance
        .collection('academia')
        .doc('ms')
        .collection('specialités')
        .get();

    for (int i = 0; i < a.docs.length; i++) {
      specialities.add(a.docs[i]['specialité']);
      print(a.docs.length.toString() + 'specilities counttttttttttttt');
      print('specialitéeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(a.docs[i]['specialité']);
      //************specilities***** */
      String sp = a.docs[i]['specialité'];
      var b = await FirebaseFirestore.instance
          .collection('academia')
          .doc('ms')
          .collection('specialités')
          .doc(sp.toLowerCase())
          .collection("plan d'etude")
          .get();

      for (int j = 0; j < b.docs.length; j++) {
        print(b.docs.length.toString() + 'plan etude counttttttttttttt');
        pe.add(b.docs[j]['libellé']);
        print("plan d'etuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuude");
        print(b.docs[j]['libellé']);
        //***********plan d'etude ************* */

        var c = await FirebaseFirestore.instance
            .collection('academia')
            .doc('ms')
            .collection('specialités')
            .doc(a.docs[i]['specialité'])
            .collection("plan d'etude")
            .doc(b.docs[j]['libellé'])
            .collection("element d'enseignment")
            .get();

        for (int k = 0; k < c.docs.length; k++) {
          print(c.docs.length.toString() + 'elements counttttttttttttt');

          ee.add(c.docs[k]['libellé']);

          print(
              "elements d'enseignementssssssssssssssssssssssssssssssssssssssssss");
          print(c.docs[k]['libellé']);
        }
      }
    }
    print('nombre des elements enseignements' + ee.length.toString());
    return (ee);
  }

  Future<List<String>> getMFSubjects() async {
    List<String> specialities = [];

    List<String> unites = [];

    var x = await FirebaseFirestore.instance
        .collection('academia')
        .doc('mf')
        .collection('specialités')
        .get();

    for (int i = 0; i < x.docs.length; i++) {
      specialities.add(x.docs[i]['specialité']);
      print(x.docs.length.toString() + 'specilities counttttttttttttt');
      print('specialitéeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
      print(x.docs[i]['specialité']);
      //************specilities***** */

      try {
        String sp = x.docs[i]['specialité'];
        var y = await FirebaseFirestore.instance
            .collection('academia')
            .doc('mf')
            .collection('specialités')
            .doc((sp.toLowerCase()))
            .collection('modules')
            .get();

        for (int j = 0; j < y.docs.length; j++) {
          var z = await FirebaseFirestore.instance
              .collection('academia')
              .doc('mf')
              .collection('specialités')
              .doc((sp.toLowerCase()))
              .collection('modules')
              .doc(y.docs[j]['libellé'])
              .collection('unités')
              .get();
          for (int k = 0; k < z.docs.length; k++) {
            unites.add(z.docs[k]['libellé']);
          }
        }
        print('gwwwwwwwwwwwwwija start');
      } catch (e) {
        print('pb somewhere' + e.toString());
      }
    }
    print('unittttttttttttttttttttteees:' + unites.length.toString());
    return unites;
  }

  void getData() async {
    msSubjects = await getMSsubjects();
    mfSubjects = await getMFSubjects();
    setState(() {});
  }
}
