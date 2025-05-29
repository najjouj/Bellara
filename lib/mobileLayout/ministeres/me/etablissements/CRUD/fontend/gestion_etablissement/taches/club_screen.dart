import 'dart:io';

import 'package:bellaraa/commun/commun/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({super.key});

  @override
  State<ClubScreen> createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  final TextEditingController clubController = TextEditingController();
  bool galerieLoading = false;
  List clubGalerie = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clubController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clubController.dispose();
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
              Text('Clubs',
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
                      Icons.add,
                      color: Colors.deepPurple,
                    )),
              )
            ],
          ),
        ),
        Container(
          height: 750,
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
              const Gap(15),
              Container(
                height: 60,
                width: double.maxFinite,
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
                  //maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: clubController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'club. est vide';
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
                    labelText: "Club ",
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
                    hintText: "saisir le nom du club",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: clubController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              clubController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              const Gap(20),
              Container(
                height: 147,
                width: double.maxFinite,
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
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  controller: clubController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'description. est vide';
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
                    labelText: "Description ",
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
                    hintText: "saisir une description du club",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: clubController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              clubController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              const Gap(5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
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
                    const Gap(5),
                    GestureDetector(
                      onTap: () {
                        _saveClubGalerie();
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
                            : (clubGalerie.isEmpty)
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
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 3.5),
                                    itemCount: clubGalerie.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 70,
                                        width: 70,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            clubGalerie[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
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

  void _saveClubGalerie() async {
    String nomclub = clubController.text.trim();
    List<File?> galerie = await pickImagesFromGallery(context);
    setState(() {
      galerieLoading = true;
    });
    clubGalerie =
        await saveimagesFiles("Clubs/$nomclub", 'galerie', galerie, [])
            .then((value) {
      setState(() {
        galerieLoading = false;
      });
      return value;
    });
  }
}
