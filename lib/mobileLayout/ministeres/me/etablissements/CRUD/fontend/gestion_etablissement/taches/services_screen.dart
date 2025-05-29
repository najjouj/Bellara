import 'dart:io';

import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/commun/widgets/commun_widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedService = '';
  bool galerieLoading = false;
  bool foyertapped = false;
  bool restotapped = false;
  List restoGalerie = [];
  List foyerGalerie = [];
  List<Map<String, dynamic>> services = [
    {'service': 'Foyer', 'selected': false, 'galerie': []},
    {'service': 'Restaurant', 'selected': false, 'galerie': []}
  ];
  List<Map<String, dynamic>> transports = [
    {'moyen': 'Bus', 'image': 'assets/images/bus.jpg', 'selected': false},
    {'moyen': 'Métro', 'image': 'assets/images/metro.jpg', 'selected': false},
    {'moyen': 'Louage', 'image': 'assets/images/louage.jpg', 'selected': false},
    {'moyen': 'Taxi', 'image': 'assets/images/taxi.jpg', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Services',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.7,
                      decorationThickness: .2,
                      fontSize: 26,
                      color: Colors.black)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    /*  if (alreadyExist(salleController.text)) {
                      Get.snackbar(
                          'Salle', '${salleController.text} already exist');
                    } else {
                      blocs.add(salleController.text.trim());
                      print(salleController.text);
                      Get.snackbar('Salle', '${salleController.text} added');
                      salleController.clear();

                      print(blocs.length.toString());
                    }*/
                  });
                },
                child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple.shade100,
                        ),
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.save,
                      color: Colors.deepPurple,
                    )),
              )
            ],
          ),
        ),
        Container(
          height: 600,
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
          padding: const EdgeInsets.only(bottom: 35),
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          //height: 390,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(15),
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: services
                        .map((e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  e['selected'] = !e['selected'];
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width * .43,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 100,
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: (e['selected'])
                                                ? Colors.deepPurple.shade100
                                                : Colors.grey.shade300,
                                            border: Border.all(
                                                color: (e['selected'])
                                                    ? Colors.deepPurple.shade400
                                                    : Colors.grey.shade400,
                                                width: 1.5)),
                                        child: Text(e['service'])),
                                    //Gap(2),
                                    GestureDetector(
                                      onTap: () {
                                        if (e['selected']) showBottomModal(e);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.2,
                                                color: e['selected']
                                                    ? Colors.green
                                                    : Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: (e['selected'] && restotapped)
                                            ? Center(
                                                child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : Icon(Icons.image_search,
                                                size: 25,
                                                color: e['selected']
                                                    ? Colors.green.shade700
                                                    : Colors.grey.shade600),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
              ),
              Divider(),
              Gap(25),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Transport',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Gap(10),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: GridView.builder(
                    itemCount: transports.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3),
                    itemBuilder: ((context, index) {
                      return Stack(children: [
                        Container(
                          height: 230,
                          width: 230,
                          margin: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              transports[index]['image']!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                transports[index]['selected'] =
                                    !transports[index]['selected'];
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: transports[index]['selected']
                                      ? Colors.green.shade100
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.check_circle_outline,
                                color: transports[index]['selected']
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.8)),
                              child: Text(transports[index]['moyen']!)),
                        ),
                      ]);
                    })),
              )
            ],
          ),
        ),
      ]),
    );
  }

  bool alreadyExist(String text) {
    List<String> searchResult = [];
    searchResult = blocs
        .where(
            (e) => e.trim().toLowerCase().contains(text.trim().toLowerCase()))
        .toList();
    if (searchResult.isEmpty) {
      print('exist??');
      print(searchResult.length.toString());
      return false;
    } else {
      print('exist??');
      print(searchResult.length.toString());
      return true;
    }
  }

  void showBottomModal(Map<String, dynamic> e) {
    Get.bottomSheet(
        isScrollControlled: true,
        //isDismissible: false,
        SizedBox(
          height: 730,
          child: Container(
            width: double.maxFinite,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    e['service'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.6),
                  ),
                ),
                Container(
                    width: double.maxFinite,
                    color: Colors.grey.shade500,
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.image_search,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Galerie',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: 1.6),
                        ))),
                Gap(25),
                GestureDetector(
                  onTap: () {
                    _saveServiceGalerie(e['service']);
                  },
                  child: Container(
                      height: 550,
                      width: 350,
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12)),
                      child: (e['service'] == 'Foyer')
                          ? (foyerGalerie.isEmpty)
                              ? GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 3.5),
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: const Icon(
                                        Icons.image_search_outlined,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                )
                              : GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 3.5),
                                  itemCount: foyerGalerie.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          foyerGalerie[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                )
                          : (restoGalerie.isEmpty)
                              ? GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 3.5),
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: const Icon(
                                        Icons.image_search_outlined,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                )
                              : GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 3.5),
                                  itemCount: restoGalerie.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          restoGalerie[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                )),
                )
              ],
            ),
          ),
        ));
  }

  void _saveServiceGalerie(String service) async {
    List<File?> galerie = await pickImagesFromGallery(context);
    setState(() {
      galerieLoading = true;
      Get.back();
    });
    if (galerieLoading) ShowDialogProgress(context);
    if (service == 'Foyer') {
      foyerGalerie =
          await saveimagesFiles("Services/$service", 'galerie', galerie, [])
              .then((value) {
        setState(() {
          galerieLoading = false;
        });
        Get.back();
        return value;
      });
    } else {
      restoGalerie =
          await saveimagesFiles("Services/$service", 'galerie', galerie, [])
              .then((value) {
        setState(() {
          galerieLoading = false;
        });
        Get.back();
        return value;
      });
    }
  }
}
