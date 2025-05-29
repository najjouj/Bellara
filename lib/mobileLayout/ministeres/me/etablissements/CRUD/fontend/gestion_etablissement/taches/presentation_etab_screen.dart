import 'dart:io';

import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PrentationScreen extends StatefulWidget {
  const PrentationScreen({super.key});

  @override
  State<PrentationScreen> createState() => _PrentationScreenState();
}

class _PrentationScreenState extends State<PrentationScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String logoUrl = '';
  bool logLoading = false;
  bool galerieLoading = false;
  List etabGalerie = [];
  String selectedNature = '';
  String selectedDelegation = '';
  String selectedTypeEtab = 'étatique';
  bool etatique = true;
  List<String> typeEtab = ['étatique', 'privé'];
  callback(varSelectedNatEtab) {
    setState(() {
      selectedNature = varSelectedNatEtab;
    });
  }

  callbackDeleg(varSelectedDeleg) {
    setState(() {
      selectedDelegation = varSelectedDeleg;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descriptionController.addListener(() {
      setState(() {});
    });
    nameController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        const Gap(10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Présentation',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.7,
                      decorationThickness: .2,
                      fontSize: 26,
                      color: Colors.black)),
              Container(
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
                  ))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
          padding: const EdgeInsets.only(bottom: 35),
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 35),
                child: Text(
                  "Nature de l'établissment ",
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
                      items: natureTablissment, stringCallback: callback));
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
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    width: 350,
                    child: (selectedNature != '')
                        ? Text(
                            selectedNature,
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  "Délégation régionale ",
                  style: TextStyle(
                    letterSpacing: 1.3,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Gap(5),
              GestureDetector(
                onTap: () {
                  Get.to(() => ListViewSearchScreen(
                      items: delegationsRegionales,
                      stringCallback: callbackDeleg));
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurple.shade100,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    width: 350,
                    child: (selectedDelegation != '')
                        ? Text(
                            selectedDelegation,
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
              const Gap(35),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .45,
                      child: CheckboxListTile(
                        value: etatique,
                        onChanged: (newValue) {
                          setState(() {
                            etatique = newValue!;
                          });
                        },
                        title: Text(
                          'Etatique',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      child: CheckboxListTile(
                        value: !etatique,
                        onChanged: (newValue) {
                          setState(() {
                            etatique = !newValue!;
                          });
                        },
                        title: Text('Privé', style: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),

              /* Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: typeEtab
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTypeEtab = e;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: (e == selectedTypeEtab)
                                      ? Colors.deepPurple
                                      : Colors.deepPurple.withOpacity(.2)),
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: (e == selectedTypeEtab)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            */
              Gap(25),
              Container(
                height: 75,
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
                  //maxLines: 10,
                  keyboardType: TextInputType.text,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'nom. est vide';
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
                    labelText: "Nom de l'établissement ",
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
                    hintText: "saisir le nom du l'établissement",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: nameController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              nameController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),

              Gap(25),
              Container(
                height: 270,
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
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
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
                    hintText: "saisir une description du l'établissement",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: descriptionController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              descriptionController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),

              const Gap(10),
            ],
          ),
        ),
        Gap(35),
        Stack(children: [
          const Positioned(
            left: 25,
            top: -8,
            child: Text(
              'Galerie',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.7,
                  decorationThickness: .2,
                  fontSize: 22,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                GestureDetector(
                  onTap: () {
                    _saveLogo();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.deepPurple.shade100,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: (logLoading)
                        ? Center(
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator()),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Logo',
                                style:
                                    TextStyle(fontSize: 22, color: Colors.grey),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: (logoUrl == '')
                                    ? Icon(
                                        Icons.image_search,
                                        color: Colors.grey,
                                        size: 25,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          logoUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                  ),
                ),
                const Gap(25),
                GestureDetector(
                  onTap: () {
                    _saveEtabGalerie();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
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
                        Container(
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
                              : (etabGalerie.isEmpty)
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
                                      itemCount: etabGalerie.length,
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
                                                etabGalerie[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ));
                                      },
                                    ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
        Gap(25)
      ]),
    );
  }

  void _saveLogo() async {
    File? img = await pickImageFromGallery(context);
    String nomEtab = nameController.text.trim();
    print("$nomEtab/klmmk");
    setState(() {
      logLoading = true;
    });
    logoUrl =
        await saveimageFiles("$selectedNature/$nomEtab/logo", 'logo', img, null)
            .then((value) {
      setState(() {
        logLoading = false;
      });
      return value;
    });
  }

  void _saveEtabGalerie() async {
    String nomEtab = nameController.text.trim();
    List<File?> galerie = await pickImagesFromGallery(context);
    setState(() {
      galerieLoading = true;
    });
    etabGalerie = await saveimagesFiles(
        "$selectedNature/$nomEtab", 'galerie', galerie, []).then((value) {
      setState(() {
        galerieLoading = false;
      });
      return value;
    });
  }
}
