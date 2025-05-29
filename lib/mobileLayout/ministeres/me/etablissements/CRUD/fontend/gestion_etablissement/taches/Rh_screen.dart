import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RhScreen extends StatefulWidget {
  const RhScreen({super.key});

  @override
  State<RhScreen> createState() => _RhScreenState();
}

class _RhScreenState extends State<RhScreen> {
  String selectedCadre = '';
  String selectedRole = '';
  List<String> tachesEmpl = [
    'Directeur',
    'Surveillant géneral',
    'Enseignant',
    'Sécretaire',
    'Ouvrier',
    'Garde'
  ];
  callbackRole(varSelectedBloc) {
    setState(() {
      selectedRole = varSelectedBloc;
    });
  }

  callbackCadre(varSelectedBloc) {
    setState(() {
      selectedCadre = varSelectedBloc;
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
              Text('Ressources humaine',
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
                      items: apprenant, stringCallback: callbackCadre));
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
                    child: (selectedCadre != '')
                        ? Text(
                            selectedCadre,
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
                      items: tachesEmpl, stringCallback: callbackRole));
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
                    child: (selectedRole != '')
                        ? Text(
                            selectedRole,
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

              /*******************************/
              const Gap(200),

              const Gap(5),
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
}
