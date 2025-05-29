import 'dart:io';

import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SalleScreen extends StatefulWidget {
  const SalleScreen({super.key});

  @override
  State<SalleScreen> createState() => _SalleScreenState();
}

class _SalleScreenState extends State<SalleScreen> {
  String selectedBloc = '';
  bool galerieLoading = false;
  List salleGalerie = [];
  final TextEditingController salleController = TextEditingController();
  callbackBloc(varSelectedBloc) {
    setState(() {
      selectedBloc = varSelectedBloc;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    salleController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    salleController.addListener(() {
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
              Text('Salles',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.7,
                      decorationThickness: .2,
                      fontSize: 26,
                      color: Colors.black)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (alreadyExist(salleController.text)) {
                      Get.snackbar(
                          'Salle', '${salleController.text} already exist');
                    } else {
                      blocs.add(salleController.text.trim());
                      print(salleController.text);
                      Get.snackbar('Salle', '${salleController.text} added');
                      salleController.clear();

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
          height: 700,
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  "Département/Bloc ",
                  style: TextStyle(
                      letterSpacing: 1.3,
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300),
                ),
              ),
              //Gap(5),
              GestureDetector(
                onTap: () {
                  Get.to(() => ListViewSearchScreen(
                      items: blocs, stringCallback: callbackBloc));
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      borderRadius: BorderRadius.circular(5)),
                  child: SizedBox(
                    width: 350,
                    child: (selectedBloc != '')
                        ? Text(
                            selectedBloc,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          )
                        : const Text(
                            'rechercher',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                  ),
                ),
              ),
              const Gap(30),
              Container(
                height: 80,
                //width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: salleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'salle. est vide';
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
                    labelText: "Libellé ",
                    labelStyle: const TextStyle(
                        letterSpacing: 1.3,
                        fontSize: 24,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                    /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                    hintText: "saisir la libellé de la salle ou bien labo",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: salleController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              salleController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              const Gap(5),

              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                        _saveSalleGalerie();
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
                            : (salleGalerie.isEmpty)
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
                                    itemCount: salleGalerie.length,
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
                                            salleGalerie[index],
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

  void _saveSalleGalerie() async {
    String nomSalle = salleController.text.trim();
    List<File?> galerie = await pickImagesFromGallery(context);
    setState(() {
      galerieLoading = true;
    });
    salleGalerie = await saveimagesFiles(
        "Bloc/departement/$selectedBloc/Salles/$nomSalle",
        'galerie',
        galerie, []).then((value) {
      setState(() {
        galerieLoading = false;
      });
      return value;
    });
  }
}
