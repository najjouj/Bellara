import 'dart:io';

import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/commun/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BlocDepartmentScreen extends StatefulWidget {
  const BlocDepartmentScreen({super.key});

  @override
  State<BlocDepartmentScreen> createState() => _BlocDepartmentScreenState();
}

class _BlocDepartmentScreenState extends State<BlocDepartmentScreen> {
  final TextEditingController blocController = TextEditingController();
  bool galerieLoading = false;
  List blocGalerie = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bloc/Département',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.7,
                      decorationThickness: .2,
                      fontSize: 26,
                      color: Colors.black)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (alreadyExist(blocController.text)) {
                      Get.snackbar('Département',
                          '${blocController.text} already exist');
                    } else {
                      blocs.add(blocController.text.trim());
                      print(blocController.text);
                      Get.snackbar(
                          'Département', '${blocController.text} added');
                      blocController.clear();

                      print(blocs.length.toString());
                    }
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
                      Icons.add,
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
              const Gap(25),
              Container(
                height: 80,
                //width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: blocController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'bloc. est vide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Bloc/département",
                    labelStyle: const TextStyle(
                        letterSpacing: 1.2, fontSize: 24, color: Colors.grey),
                    /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                    hintText: "libellé",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: blocController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              blocController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              const Gap(25),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Galerie de photos',
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                    const Gap(10),
                    GestureDetector(
                      onTap: () {
                        _saveBlocGalerie();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)),
                        child: (galerieLoading)
                            ? Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator()),
                              )
                            : (blocGalerie.isEmpty)
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 3.5),
                                    itemCount: 9,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          height: 70,
                                          width: 70,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Icon(
                                              Icons.image_search,
                                              color: Colors.grey,
                                            ),
                                          ));
                                    },
                                  )
                                : GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 3.5),
                                    itemCount: blocGalerie.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          height: 70,
                                          width: 70,
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              blocGalerie[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ));
                                    },
                                  ),
                      ),
                    )
                  ],
                ),
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

  void _saveBlocGalerie() async {
    String nombloc = blocController.text.trim();
    List<File?> galerie = await pickImagesFromGallery(context);
    setState(() {
      galerieLoading = true;
    });
    blocGalerie = await saveimagesFiles(
        "Bloc/departement/$nombloc", 'galerie', galerie, []).then((value) {
      setState(() {
        galerieLoading = false;
      });
      return value;
    });
  }
}
