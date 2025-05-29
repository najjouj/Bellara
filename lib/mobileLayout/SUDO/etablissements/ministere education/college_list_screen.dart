import 'dart:io';

import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/mobileLayout/SUDO/DBoperation/etab_DB_operation.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CollegeListScreen extends StatefulWidget {
  final String delegation;
  const CollegeListScreen({super.key, required this.delegation});

  @override
  State<CollegeListScreen> createState() => _CollegeListScreenState();
}

class _CollegeListScreenState extends State<CollegeListScreen> {
  CarouselController carouselController = CarouselController();
  bool gallerieSalleEmpty = true;
  String? selectedTypeSalle;
  List gallerieSalleUrl = [];
  List<File?> galleriesSalleFiles = [];
  final _formK = GlobalKey<FormState>();

  final List<String> typesSalle = [
    'Salle',
    'Labo Info',
    'Labo sciences',
    'Labo technique',
  ];
  TextEditingController libController = TextEditingController();
  TextEditingController blocController = TextEditingController();
  TextEditingController nbTableController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController siteWebController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    if (widget.delegation == '')
      return StreamBuilder(
        stream: etabDBoperations()
            .academiaStore
            .doc('me')
            .collection('etablissements')
            .where('nature', isEqualTo: 'Collège')
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
                      const Text("Ajouter un collège",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        constraints:
                                            const BoxConstraints(maxWidth: 250),
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
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => _moreBottomSheet(
                                              context,
                                              documents[index]['nom'],
                                              images[0]),
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
                                            padding: const EdgeInsets.all(8),
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
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                          text: documents[index]['description'],
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
                                  text: "Ministère d'éducation\n",
                                  style: const TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  children: [
                                TextSpan(
                                  text: '   Colleges',
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
    else
      return StreamBuilder(
        stream: etabDBoperations()
            .academiaStore
            .doc('me')
            .collection('etablissements')
            .where('nature', isEqualTo: 'Collège')
            .where('delegation regionale', isEqualTo: widget.delegation)
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
                      const Text("Ajouter un collège",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        constraints:
                                            const BoxConstraints(maxWidth: 250),
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
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => _moreBottomSheet(
                                              context,
                                              documents[index]['nom'],
                                              images[0]),
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
                                            padding: const EdgeInsets.all(8),
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
                                          color: Colors.black, fontSize: 18),
                                      children: [
                                        TextSpan(
                                          text: documents[index]['description'],
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

  void _moreBottomSheet(BuildContext context, String uid, String imgUrl) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              //height: 1500,
              //padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(imgUrl),
                  ),
                ),
                Gap(30),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 80,
                      color: Colors.deepPurple,
                    ),
                    Gap(5),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: Text(
                        ' $uid',
                        style: const TextStyle(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 2,
                          color: Colors.deepPurple,
                          //fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(25),
                ListTile(
                  title: const Text('+ Un directeur'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  // onTap: () => _openBottomSheetSalle(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/boss.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  title: const Text('+ Une salle'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  onTap: () => _openBottomSheetSalle(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/classroom.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  title: const Text('+ Un e-mail'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  onTap: () => _openBottomSheetEmail(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/email.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  title: const Text('+ Un site web'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  onTap: () => _openBottomSheetSteWeb(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/site.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
              ]));
        });
  }

  void _morreBottomSheet(BuildContext context, String uid, String imgUrl) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              //height: 1500,
              //padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 30, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(imgUrl),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 80,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      'Ecole primaire $uid',
                      style: const TextStyle(
                          letterSpacing: 1.2,
                          fontSize: 22,
                          height: 2,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const Gap(25),
                ListTile(
                  title: const Text('+ Un directeur'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  // onTap: () => _openBottomSheetSalle(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/boss.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  title: const Text('+ Une salle'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  onTap: () => _openBottomSheetSalle(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/classroom.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  title: const Text('+ Un e-mail'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  onTap: () => _openBottomSheetEmail(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/email.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  title: const Text('+ Un site web'),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  onTap: () => _openBottomSheetSteWeb(context, uid, imgUrl),
                  leading: Image.asset(
                    'assets/icons/site.png',
                    width: 25,
                    height: 25,
                    color: Colors.deepPurple,
                  ),
                ),
              ]));
        });
  }

  void _openBottomSheetSalle(BuildContext context, String uid, String imgUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
          height: 1500,
          child: Wrap(children: [
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(imgUrl),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 80,
                  color: Colors.deepPurple,
                ),
                Gap(5),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text(
                    ' $uid',
                    style: const TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 2,
                      color: Colors.deepPurple,
                      //fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.deepPurple[100],
                padding: const EdgeInsets.only(
                    bottom: 35, left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ajout d'une salle",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 223, 222, 222)),
                          shape: BoxShape.circle,
                          color: Colors.grey[100]),
                      child: IconButton(
                          onPressed: () {
                            _addSalle(uid);
                          },
                          icon: const Icon(
                            Icons.save,
                            color: Colors.deepPurple,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  _selectPhotosSalleFromGallerie();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide.none,
                          left: BorderSide.none,
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 133, 132, 132)),
                          top: BorderSide(
                              color: Color.fromARGB(255, 129, 129, 129)))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gallerie',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const Icon(
                          Icons.photo_library_sharp,
                          color: Colors.deepPurple,
                        )
                      ]),
                ),
              ),
            ),
            (gallerieSalleEmpty == false)
                ? SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: galleriesSalleFiles.length,
                        itemBuilder: (context, index) {
                          print(
                              '${galleriesSalleFiles.length}jjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
                          return Container(
                            margin: const EdgeInsets.all(5),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.file(
                              galleriesSalleFiles[index]!,
                              fit: BoxFit.cover,
                            ),
                          );
                        }))
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Form(
                  key: _formK,
                  child: Column(
                    children: [
                      TextFormField(
                        // key: _formK,
                        controller: libController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Libellé est vide';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Libellé'),
                      ),
                      TextFormField(
                        // key: _formK,
                        controller: blocController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bloc est vide';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Bloc'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          //key: _formK,
                          controller: nbTableController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nombre de tables est vide';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Nombre de tables'),
                        ),
                      ),
                      Container(
                        //padding: const EdgeInsets.only(bottom: 10),
                        //width: MediaQuery.of(context).size.width * .30,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        Color.fromARGB(255, 133, 132, 132)))),
                        child: DropdownSearch<String>(
                          //key: _formK,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'type est vide';
                            }
                            return null;
                          },
                          items: typesSalle,
                          onChanged: (value) {
                            setState(() {
                              selectedTypeSalle = value!;
                            });
                          },
                          selectedItem: selectedTypeSalle,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                hintText: 'Type',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                          popupProps: const PopupProps.menu(
                            title: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Type de salle:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                              ),
                            ),
                            isFilterOnline: true,
                            showSelectedItems: true,
                            showSearchBox: false,
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ]),
        );
      },
      /* isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),*/
    );
  }

//**************************************** add email**************** */
  void _openBottomSheetEmail(BuildContext context, String uid, String imgUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
          height: 1000,
          child: Wrap(children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                height: 5,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
            ),
            CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(imgUrl),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 80,
                  color: Colors.deepPurple,
                ),
                Text(
                  'Ecole primaire $uid',
                  style: const TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 22,
                      height: 2,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.deepPurple[100],
                padding: const EdgeInsets.only(
                    bottom: 35, left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ajout d'un e-mail",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 223, 222, 222)),
                          shape: BoxShape.circle,
                          color: Colors.grey[100]),
                      child: IconButton(
                          onPressed: () {
                            _addEmail(uid);
                          },
                          icon: const Icon(
                            Icons.save,
                            color: Colors.deepPurple,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                  key: _formK,
                  child: Column(
                    children: [
                      TextFormField(
                        // key: _formK,
                        controller: emailController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@')) {
                            return 'e-mail est vide';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'e-mail'),
                      ),
                    ],
                  )),
            )
          ]),
        );
      },
    );
  }

  void _addEmail(String uid) {
    if (_formK.currentState!.validate()) {
      print('iiiiiiiiiiiiiiiis valid');
      //signinwithemailandpasswordMeth().addEmail(uid, emailController.text);
    }
  }

////////////////////////////////EMAILLLLLLLLLLLLLLLLLLLLLL////////////////////////////////////////////////
  ///
//**************************************** site web**************** */
  void _openBottomSheetSteWeb(BuildContext context, String uid, String imgUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
          height: 1000,
          child: Wrap(children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                height: 5,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              ),
            ),
            CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(imgUrl),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 80,
                  color: Colors.deepPurple,
                ),
                Text(
                  'Ecole primaire $uid',
                  style: const TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 22,
                      height: 2,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                color: Colors.deepPurple[100],
                padding: const EdgeInsets.only(
                    bottom: 35, left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ajout d'un site web",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 223, 222, 222)),
                          shape: BoxShape.circle,
                          color: Colors.grey[100]),
                      child: IconButton(
                          onPressed: () {
                            _addSiteWeb(uid);
                          },
                          icon: const Icon(
                            Icons.save,
                            color: Colors.deepPurple,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Form(
                  key: _formK,
                  child: Column(
                    children: [
                      TextFormField(
                        // key: _formK,
                        controller: siteWebController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'site web est vide';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'site web'),
                      ),
                    ],
                  )),
            )
          ]),
        );
      },
    );
  }

  void _addSiteWeb(String uid) {
    if (_formK.currentState!.validate()) {
      //signinwithemailandpasswordMeth().addSiteWeb(uid, siteWebController.text);
    }
  }

////////////////////////////////EMAILLLLLLLLLLLLLLLLLLLLLL////////////////////////////////////////////////
  void _selectPhotosSalleFromGallerie() async {
    try {
      setState(() async {
        galleriesSalleFiles =
            await pickImagesFromGallery(context).then((value) {
          EasyLoading.showSuccess('images picked');
          gallerieSalleEmpty = false;
          return value;
        });
      });
    } catch (e) {
      EasyLoading.showError('picking images err');
    }
  }

  void _addSalle(String uid) {
    if (_formK.currentState!.validate()) {
      print('iiiiiiiiiiiiiiiis valid');
      setState(() async {
        gallerieSalleUrl.assignAll(await saveimagesFiles(
            'salles/$uid', libController.text, galleriesSalleFiles, []));

        if (gallerieSalleUrl.length < galleriesSalleFiles.length) {
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    content: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.deepPurple,
                      ),
                    ),
                  ));
        } else if (gallerieSalleUrl.length == galleriesSalleFiles.length) {
          //signinwithemailandpasswordMeth().addClassRoom(uid,gallerieSalleUrl,libController.text,blocController.text,nbTableController.text, selectedTypeSalle!);

          gallerieSalleUrl = [];
          galleriesSalleFiles = [];
          libController.clear();
          blocController.clear();
          nbTableController.clear();
          selectedTypeSalle = '';
          Get.back();
        }
      });
    }
  }
}
