import 'dart:io';

import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/commun/utils.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:searchfield/searchfield.dart';

class CreateEtabScreen extends StatefulWidget {
  const CreateEtabScreen({super.key});

  @override
  State<CreateEtabScreen> createState() => _CreateEtabScreenState();
}

class _CreateEtabScreenState extends State<CreateEtabScreen> {
  final String uid = '';

  final String adresse = '';

  final String name = '';

  final String presentation = '';

  String? directeur;

  String? uidDirecteur;

  final bool public = true;

  final bool private = false;

  final bool restaurant = false;

  final bool foyer = false;

  String typeEtab = '';

  final String transport = '';

  final String gouvernorat = '';

  final String tel = '';

  String? siteWeb;

  String? email;

  final filiaires = [];

  List galleries = [];

  final salles = [];

  List enseignants = [];

  final administratives = [];

  final anneesScolaire = [];
  bool gallerieEmpty = true;
  bool gallerieSalleEmpty = true;
  String? selectedTypeSalle;
  List<File?> galleriesFiles = [];
  List<File?> galleriesSalleFiles = [];
  String? selectedNatureEtab;
  final _formKey = GlobalKey<FormState>();
  final List<String> services = [
    'Foyer',
    'Restaurant',
    'Transport',
    'Public',
    'Privé'
  ];
  final List<String> typesSalle = [
    'Salle',
    'Labo Info',
    'Labo sciences',
    'Labo technique',
  ];
  final List<String> transports = [
    'Métro',
    'Bus',
    'Taxi',
    'Louage',
  ];
  final List<String> typesEtab = ['école ', 'collège', 'lycée'];
  String delegationReg = '';
  List selectedTransport = [];
  List selectedServices = [];
  final TextEditingController nomController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController presentationController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final focus = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nomController.dispose();
    adresseController.dispose();
    presentationController.dispose();
    telController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nomController.addListener(() {
      setState(() {});
    });
    adresseController.addListener(() {
      setState(() {});
    });
    presentationController.addListener(() {
      setState(() {});
    });
    telController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ajouter un établissement"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _addCollege();
                if (galleries.length < galleriesFiles.length) {
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
                }
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _natureEtablissement(),
                const Gap(25),
                _presentaionEtablissement(context),
                const Gap(25),
                _adressesEtablissement(),
                const Gap(25),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: Column(
                    children: [
                      const Gap(25),
                      _serviccesEtablissement(),

//******************* */
                      const Gap(25),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _serviccesEtablissement() {
    return Container(
      decoration: const BoxDecoration(color: Colors.green),
      //margin: EdgeInsets.only(left: 35, ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),

            //margin: EdgeInsets.only(left: 35, ),
            child: MultiSelectDialogField(
              validator: (value) {
                if (selectedServices.isEmpty) {
                  return 'services est obligatoire';
                }
                return null;
              },
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all()),
              buttonIcon: const Icon(Icons.keyboard_arrow_down),
              buttonText: const Text(
                'Services',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              title: const Text(
                'Services:',
                style: TextStyle(color: Colors.black54),
              ),
              items: services.map((e) => MultiSelectItem(e, e)).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (p0) {
                setState(() {
                  selectedServices = p0;
                });
              },
            ),
          ),
          MultiSelectDialogField(
            validator: (value) {
              if (selectedTransport.isEmpty) {
                return 'moyen de transport est obligatoire';
              }
              return null;
            },
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all()),
            buttonIcon: const Icon(Icons.keyboard_arrow_down),
            buttonText: const Text(
              'Transport',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            title: const Text(
              'Transport:',
              style: TextStyle(color: Colors.black54),
            ),
            items: transports.map((e) => MultiSelectItem(e, e)).toList(),
            listType: MultiSelectListType.CHIP,
            onConfirm: (p0) {
              setState(() {
                selectedTransport = p0;
              });
            },
          ),
        ],
      ),
    );
  }

  Container _adressesEtablissement() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepOrange,
          border: Border.all(color: Colors.deepOrange)),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            controller: adresseController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'adresse est vide';
              }
              return null;
            },
            maxLines: 3,
            decoration: InputDecoration(
                hintStyle:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                contentPadding: const EdgeInsets.all(8),
                hintText: "saisir l'adresse",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: adresseController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() {
                          adresseController.clear();
                        }),
                        icon: const Icon(Icons.close)),
                labelText: "Adresse de l'etablissement"),
          ),
          const Gap(25),
          TextFormField(
            maxLines: 3,
            keyboardType: TextInputType.phone,
            controller: telController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'tel. est vide';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintStyle:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                contentPadding: const EdgeInsets.all(8),
                hintText: "saisir les numéros de tel.",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: telController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() {
                          telController.clear();
                        }),
                        icon: const Icon(Icons.close)),
                labelText: 'Télephone'),
          ),
        ],
      ),
    );
  }

  Container _presentaionEtablissement(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.blue)),
      child: Column(
        children: [

          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'Select a country',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(0, 10),
                              color: Colors.grey.withOpacity(.2))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: SearchField(
                        hint: 'rechercher',
                        searchInputDecoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey.shade200, width: 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.deepPurple.withOpacity(.8)))),
                        itemHeight: 50,
                        maxSuggestionsInViewPort: 6,
                        suggestionsDecoration: SuggestionDecoration(
                            padding: const EdgeInsets.all(8),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),

                        //onSubmit: (p0) {},
                        suggestions: natureTablissment
                            .map((e) => SearchFieldListItem(e, child: Text(e)))
                            .toList())),
              ],
            ),
          ),
          
          const Gap(30),
          GestureDetector(
              onTap: () {
                print('ggggggggggggg');
              },
              child: const Text('heloooooo')),
          const Gap(20),
          const Gap(30),
          
          TextFormField(
            keyboardType: TextInputType.text,
            controller: nomController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'nom est vide';
              }
              return null;
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelText: "Nom de l'établissement",
              hintText: "saisir nom de l'établissement",
              hintStyle:
                  const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              contentPadding: const EdgeInsets.all(8),
              suffixIcon: nomController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: (() {
                        nomController.clear();
                      }),
                      icon: const Icon(Icons.close)),
            ),
          ),
          
          const Gap(30),
          DropdownSearch(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'délégation régionale est vide';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  delegationReg = value!;
                });
              },
              items: delegationsRegionales,
              selectedItem: delegationReg,
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // contentPadding: EdgeInsets.all(8),
                      labelText: 'Délegation régionale',
                      labelStyle: TextStyle(
                          height: 1.2,
                          letterSpacing: 1,
                          fontSize: 20,
                          color: Colors.grey[700]))),
              dropdownButtonProps: const DropdownButtonProps()),
          const Gap(25),
          const Gap(25),
          TextFormField(
            keyboardType: TextInputType.multiline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'présentation est vide';
              }
              return null;
            },
            controller: presentationController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintStyle:
                    const TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                contentPadding: const EdgeInsets.all(8),
                hintText: "décrire l'établissements..",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Presentation'),
            maxLines: 4,
          ),
          const Gap(25),
          GestureDetector(
            onTap: () {
              _selectPhotosFromGallerie();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12)),
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
          (gallerieEmpty == false)
              ? SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: galleriesFiles.length,
                      itemBuilder: (context, index) {
                        print(
                            '${galleriesFiles.length}jjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
                        return Container(
                          margin: const EdgeInsets.all(5),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.file(
                            galleriesFiles[index]!,
                            fit: BoxFit.cover,
                          ),
                        );
                      }))
              : const SizedBox.shrink(),
          const Gap(25),
        ],
      ),
    );
  }

  void _valider() {
    if (selectedNatureEtab != null) {
      print('${selectedNatureEtab!}teeeeeeeeeeeeeeeeeeeeeeeeeeest');
    } else {
      print('nuuuuuuuuuuuul text');
    }
  }

  Container _natureEtablissement() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber, border: Border.all(color: Colors.amber)),
      child: Column(
        children: [
          const Text(
            "Nature de l'établissements :",
            style: TextStyle(),
          ),
          const Divider(),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: typesEtab
                .map((e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          typeEtab = e;
                        });
                      },
                      child: Container(
                          width: 75,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (e == typeEtab)
                                      ? const Color.fromARGB(255, 142, 115, 190)
                                      : Colors.grey,
                                  width: 1.2),
                              borderRadius: BorderRadius.circular(12),
                              color: (e == typeEtab)
                                  ? const Color.fromARGB(255, 200, 173, 247)
                                  : const Color.fromARGB(255, 212, 211, 214)),
                          child: Text(
                            e,
                            textAlign: TextAlign.center,
                            style: const TextStyle(),
                          )),
                    ))
                .toList(),
          )),
          const Divider(),
          const Gap(25),
        ],
      ),
    );
  }

  _openSalleDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('hello'),
            ));
  }

  void _selectPhotosFromGallerie() async {
    try {
      setState(() async {
        galleriesFiles = await pickImagesFromGallery(context).then((value) {
          Get.snackbar('images picked', 'ff');
          gallerieEmpty = false;
          return value;
        });
      });
    } catch (e) {
      Get.snackbar('Erreur', 'picking images err');
    }
  }

  void _addCollege() async {
    if (_formKey.currentState!.validate()) {
      setState(() async {
        /* galleries.assignAll(await saveimagesFiles(
                'Lycée secondaire/', nomController.text, galleriesFiles, [])
            .then((value) {
          EasyLoading.showSuccess('photos stored');
         signinwithemailandpasswordMeth().registerNvLycee(
              nomController.text.trim(),
              adresseController.text.trim(),
              presentationController.text.trim(),
              telController.text.trim(),
              selectedServices,
              galleries,
              selectedTransport,
              delegationReg);

          Get.to(() => const EcolePrimairesWelcomePage());
          return value;
        })); */
      });

      /*  signinwithemailandpasswordMeth().registerNvEcole(
          nomController.text,
          adresseController.text,
          presentationController.text,
          telController.text,
          selectedServices,
          galleries);*/
    }
  }
}
