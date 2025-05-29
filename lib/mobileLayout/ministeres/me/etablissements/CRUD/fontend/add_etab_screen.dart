import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddEtabScreen extends StatefulWidget {
  const AddEtabScreen({super.key});

  @override
  State<AddEtabScreen> createState() => _AddEtabScreenState();
}

class _AddEtabScreenState extends State<AddEtabScreen> {
  final focus = FocusNode();
  String selectedNature = '';
  String selectedDelegation = '';
  String selectedTypeEtab = 'étatique';
  String selectedBloc = '';
  String selectedCadre = '';
  String selectedRole = '';
  TextEditingController nomController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController telFaxController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sitewebController = TextEditingController();
  final TextEditingController blocController = TextEditingController();
  final TextEditingController salleController = TextEditingController();

  final TextEditingController telController = TextEditingController();
  List<String> typeEtab = ['étatique', 'privé'];
  String screenNumber = '0';
  List<String> screenNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8'];

  List<String> typesalles = [
    'labo sciences',
    'labo mecanique',
    'labo physique',
    'salle',
    'labo technique'
  ];
  List<String> tachesEmpl = [
    'Directeur',
    'Surveillant géneral',
    'Enseignant',
    'Sécretaire',
    'Ouvrier',
    'Garde'
  ];
  String selectedService = '';
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
  List<String> blocs = [];
  callbackBloc(varSelectedBloc) {
    setState(() {
      selectedBloc = varSelectedBloc;
    });
  }

  callbackCadre(varSelectedBloc) {
    setState(() {
      selectedCadre = varSelectedBloc;
    });
  }

  callbackRole(varSelectedBloc) {
    setState(() {
      selectedRole = varSelectedBloc;
    });
  }

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nomController.dispose();
    adresseController.dispose();
    descriptionController.dispose();
    telController.dispose();
    emailController.dispose();
    sitewebController.dispose();
    blocController.dispose();
    salleController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocController.addListener(() {
      setState(() {});
    });
    salleController.addListener(() {
      setState(() {});
    });
    sitewebController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    nomController.addListener(() {
      setState(() {});
    });
    adresseController.addListener(() {
      setState(() {});
    });
    descriptionController.addListener(() {
      setState(() {});
    });
    telController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(.2),
                shape: BoxShape.circle),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ajout d'un établissement",
                  style: TextStyle(
                      fontSize: 16, letterSpacing: 1.2, color: Colors.black),
                ),
                Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(children: [
            Column(
              children: [
                // Gap(10),
                if (screenNumber == '0')
                
                  Container(
                    height: 600,
                    margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
                    padding: const EdgeInsets.only(bottom: 35),
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.grey),
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    //height: 390,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(10),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                ),
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
                                      items: natureTablissment,
                                      stringCallback: callback));
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
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
                                                fontSize: 16,
                                                color: Colors.black87),
                                          )
                                        : const Text(
                                            'rechercher',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
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
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: SizedBox(
                                    width: 350,
                                    child: (selectedDelegation != '')
                                        ? Text(
                                            selectedDelegation,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87),
                                          )
                                        : const Text(
                                            'rechercher',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                  ),
                                ),
                              ),
                              const Gap(35),
                              Center(
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: (e == selectedTypeEtab)
                                                      ? Colors.deepPurple
                                                      : Colors.deepPurple
                                                          .withOpacity(.2)),
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
                              const Gap(45),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                
                const Gap(15),
                if (screenNumber == '1')
                  Center(
                    child: Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Présentation',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 35),
                              //padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                controller: nomController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'nom est vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: "Nom de l'établissement",
                                  labelStyle: const TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 24,
                                      color: Colors.grey),
                                  /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                                  hintText: "saisir le nom de l'établissement",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16),
                                  // contentPadding: const EdgeInsets.all(8),
                                  suffixIcon: nomController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: (() {
                                            nomController.clear();
                                          }),
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                            ),
                            const Gap(35),
                            Container(
                              height: 250,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: TextFormField(
                                maxLines: 10,
                                keyboardType: TextInputType.text,
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'description est vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: "Description",
                                  labelStyle: const TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 24,
                                      color: Colors.grey),
                                  /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                                  hintText:
                                      "saisir une description de l'établissement",
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
                          ],
                        ),
                      ),
                    ]),
                  ),
                const Gap(15),
                if (screenNumber == '2')
                  Center(
                    child: 

                    Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Galerie',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Logo',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.grey),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Icon(
                                      Icons.image_search,
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Gap(25),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Galerie de photos',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.grey),
                                  ),
                                  const Gap(5),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: GridView.builder(
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
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                 
                  ),
                const Gap(15),
                if (screenNumber == '3')
                  Center(
                    child: 

                    Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Adresses',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              //padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                controller: adresseController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'tel. est vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: "Adresse",
                                  labelStyle: const TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 24,
                                      color: Colors.grey),
                                  /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                                  hintText: "saisir l'adresse",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16),
                                  // contentPadding: const EdgeInsets.all(8),
                                  suffixIcon: adresseController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: (() {
                                            adresseController.clear();
                                          }),
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              //padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                controller: telController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'tel. est vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: "Tel./ Fax",
                                  labelStyle: const TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 24,
                                      color: Colors.grey),
                                  /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                                  hintText: "saisir la liste des numéros",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16),
                                  // contentPadding: const EdgeInsets.all(8),
                                  suffixIcon: telController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: (() {
                                            telController.clear();
                                          }),
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                            ),
                            //Gap(15),

                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              //padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                controller: telController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'tel. est vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: "E-mail",
                                  labelStyle: const TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 24,
                                      color: Colors.grey),
                                  /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                                  hintText: "xxx@yy.zz",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16),
                                  // contentPadding: const EdgeInsets.all(8),
                                  suffixIcon: telController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: (() {
                                            telController.clear();
                                          }),
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                            ),

                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              //padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                controller: sitewebController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'site web. est vide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 25),
                                  filled: true,
                                  fillColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  labelText: "Site web",
                                  labelStyle: const TextStyle(
                                      letterSpacing: 1.2,
                                      fontSize: 24,
                                      color: Colors.grey),
                                  /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                                  hintText: "www.xxxxxxxx.yy",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                      fontSize: 16),
                                  // contentPadding: const EdgeInsets.all(8),
                                  suffixIcon: sitewebController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          onPressed: (() {
                                            sitewebController.clear();
                                          }),
                                          icon: const Icon(Icons.close)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                
                  ),
                const Gap(15),
                if (screenNumber == '4')
                  Center(
                    child:

                     Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Bloc/département',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                            const Gap(55),
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width * .6,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
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
                                          borderSide: BorderSide(
                                              color: Colors.deepPurple)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 25),
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      labelText: "Bloc/département",
                                      labelStyle: const TextStyle(
                                          letterSpacing: 1.2,
                                          fontSize: 24,
                                          color: Colors.grey),
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
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (alreadyExist(blocController.text)) {
                                        Get.snackbar('Département',
                                            '${blocController.text} already exist');
                                      } else {
                                        blocs.add(blocController.text.trim());
                                        print(blocController.text);
                                        Get.snackbar('Département',
                                            '${blocController.text} added');
                                        blocController.clear();

                                        print(blocs.length.toString());
                                      }
                                    });
                                  },
                                  color: Colors.white,
                                  icon: Container(
                                    height: 80,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Gap(25),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Galerie de photos',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.grey),
                                  ),
                                  const Gap(10),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: GridView.builder(
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
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                
                  ),
                const Gap(15),
                if (screenNumber == '5')
                  Center(
                    child: 
                    
                    Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Salles',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                                    items: blocs,
                                    stringCallback: callbackBloc));
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
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
                                  child: (selectedBloc != '')
                                      ? Text(
                                          selectedBloc,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87),
                                        )
                                      : const Text(
                                          'rechercher',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                ),
                              ),
                            ),
                            const Gap(30),
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width * .6,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
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
                                          borderSide: BorderSide(
                                              color: Colors.deepPurple)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 25),
                                      filled: true,
                                      fillColor: Colors.white,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      labelText: "Libellé ",
                                      labelStyle: const TextStyle(
                                          letterSpacing: 1.2,
                                          fontSize: 24,
                                          color: Colors.grey),
                                      /*  label: Text(
                                        "Nom de l'établissement",
                                        style: TextStyle(
                                          letterSpacing: 1.3,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey,
                                        ),
                                      ),*/
                                      hintText:
                                          "saisir la libellé de la salle ou bien labo",
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
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (alreadyExist(salleController.text)) {
                                        Get.snackbar('Département',
                                            '${salleController.text} already exist');
                                      } else {
                                        blocs.add(salleController.text.trim());
                                        print(salleController.text);
                                        Get.snackbar('Département',
                                            '${salleController.text} added');
                                        salleController.clear();

                                        print(salles.length.toString());
                                      }
                                    });
                                  },
                                  color: Colors.white,
                                  icon: Container(
                                    height: 80,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Gap(5),

                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Galerie de photos',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.grey),
                                  ),
                                  const Gap(5),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: GridView.builder(
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
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  
                  ),
                const Gap(15),
                if (screenNumber == '6')
                  Center(
                    child: 

                    Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Services',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .43,
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 100,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      margin: EdgeInsets.all(8),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15),
                                                          color: (e['selected'])
                                                              ? Colors
                                                                  .deepPurple
                                                                  .shade100
                                                              : Colors.grey
                                                                  .shade300,
                                                          border: Border.all(
                                                              color: (e['selected'])
                                                                  ? Colors
                                                                      .deepPurple
                                                                      .shade400
                                                                  : Colors.grey
                                                                      .shade400,
                                                              width: 1.5)),
                                                      child:
                                                          Text(e['service'])),
                                                  //Gap(2),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (e['selected'])
                                                        showBottomModal(e);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1.2,
                                                              color:
                                                                  e['selected']
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: Icon(
                                                          Icons.image_search,
                                                          size: 25,
                                                          color: e['selected']
                                                              ? Colors.green
                                                                  .shade700
                                                              : Colors.grey
                                                                  .shade600),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Transport',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Gap(10),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridView.builder(
                                  itemCount: transports.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 3,
                                          crossAxisSpacing: 3),
                                  itemBuilder: ((context, index) {
                                    return Stack(children: [
                                      Container(
                                        height: 230,
                                        width: 230,
                                        margin: EdgeInsets.all(5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.asset(
                                            transports[index]['image']!,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              transports[index]['selected'] =
                                                  !transports[index]
                                                      ['selected'];
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: transports[index]
                                                        ['selected']
                                                    ? Colors.green.shade100
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Icon(
                                              Icons.check_circle_outline,
                                              color: transports[index]
                                                      ['selected']
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
                                                color: Colors.white
                                                    .withOpacity(.8)),
                                            child: Text(
                                                transports[index]['moyen']!)),
                                      ),
                                    ]);
                                  })),
                            )
                          ],
                        ),
                      ),
                    ]),
                 
                  ),
                const Gap(15),
                if (screenNumber == '7')
                  Center(
                    child: 

                    Stack(children: [
                      const Positioned(
                        left: 25,
                        top: -8,
                        child: Text(
                          'Administratives',
                          style: TextStyle(
                              letterSpacing: 1.3,
                              decorationThickness: .2,
                              fontSize: 28,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 600,
                        margin:
                            const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                            const Gap(45),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Text(
                                "Cadre éducative ",
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
                                    items: apprenant,
                                    stringCallback: callbackCadre));
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
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
                                  child: (selectedCadre != '')
                                      ? Text(
                                          selectedCadre,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87),
                                        )
                                      : const Text(
                                          'rechercher',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                ),
                              ),
                            ),
                            const Gap(30),
                            const Gap(15),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Text(
                                "Tâche ",
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
                                    items: tachesEmpl,
                                    stringCallback: callbackRole));
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
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
                                  child: (selectedRole != '')
                                      ? Text(
                                          selectedRole,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87),
                                        )
                                      : const Text(
                                          'rechercher',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                ),
                              ),
                            ),

                            /*******************************/
                            const Gap(200),
                            Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (alreadyExist(salleController.text)) {
                                      Get.snackbar('Département',
                                          '${salleController.text} already exist');
                                    } else {
                                      blocs.add(salleController.text.trim());
                                      print(salleController.text);
                                      Get.snackbar('Département',
                                          '${salleController.text} added');
                                      salleController.clear();

                                      print(salles.length.toString());
                                    }
                                  });
                                },
                                color: Colors.white,
                                icon: Container(
                                  height: 50,
                                  width: 280,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple.shade100,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(5),
                          ],
                        ),
                      ),
                    ]),
                 
                  ),
                const Gap(15),
                if (screenNumber == '8')
                
                  Stack(children: [
                    const Positioned(
                      left: 25,
                      top: -8,
                      child: Text(
                        'Clubs',
                        style: TextStyle(
                            letterSpacing: 1.3,
                            decorationThickness: .2,
                            fontSize: 28,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      height: 650,
                      margin:
                          const EdgeInsets.only(top: 25, left: 15, right: 15),
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            //padding: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              //maxLines: 2,
                              keyboardType: TextInputType.text,
                              controller: salleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'club. est vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 25),
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                labelText: "Club ",
                                labelStyle: const TextStyle(
                                    letterSpacing: 1.2,
                                    fontSize: 24,
                                    color: Colors.grey),
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
                          const Gap(20),
                          Container(
                            height: 147,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            //padding: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              maxLines: 4,
                              keyboardType: TextInputType.text,
                              controller: salleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'description. est vide';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 25),
                                filled: true,
                                fillColor: Colors.white,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                labelText: "Description ",
                                labelStyle: const TextStyle(
                                    letterSpacing: 1.2,
                                    fontSize: 24,
                                    color: Colors.grey),
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
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Galerie de photos',
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.grey),
                                ),
                                const Gap(5),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: GridView.builder(
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
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 0,
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(
                                color: Colors.grey.shade400, width: 1.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ]),
             
              ],
            ),
            Positioned(
              bottom: 20,
              right: 0,
              child: SizedBox(
                height: 60,
                width: 370,
                child: ListView.builder(
                  itemCount: screenNumbers.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          screenNumber = screenNumbers[index];
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (screenNumber == screenNumbers[index])
                                ? Colors.deepPurple.shade100
                                : Colors.deepPurple),
                        child: Text(
                          screenNumbers[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (screenNumber == screenNumbers[index])
                                  ? Colors.black
                                  : Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ]),
        ),
      );
    });
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
                Container(
                  height: 550,
                  width: 350,
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 3.5),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: const Icon(
                          Icons.image_search_outlined,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

}
