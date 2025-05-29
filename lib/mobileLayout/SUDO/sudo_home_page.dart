import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'create/create_etab_screen.dart';
import 'create/create_univ_screen.dart';
import 'etablissements/etab_list_home_screen.dart';
import 'formations/frontend/create_formation_screen.dart';

class SudoHomePage extends StatefulWidget {
  const SudoHomePage({super.key});

  @override
  State<SudoHomePage> createState() => _SudoHomePageState();
}

class _SudoHomePageState extends State<SudoHomePage> {
  bool menuOn = false;
  int page = 0;

  List<Widget> taskPage = [
    EtabListHomeScrenn(),
    CreateUnivScreen(),
    CreateEtabScreen(),
    CreateFormationScreen(),
    Text('hello'),
    Text('hello'),
    Text('hello'),
  ];
  final List<Map<String, dynamic>> taches = [
    {'tache': 'Etab list', 'icon': 'assets/icons/list.png'},
    {'tache': 'Université', 'icon': 'assets/icons/university.png'},
    {'tache': 'Etablissement', 'icon': 'assets/icons/school.png'},
    {'tache': 'Formation', 'icon': 'assets/icons/learning.png'},
    {'tache': 'RH', 'icon': 'assets/icons/employee.png'},
    {'tache': 'Services', 'icon': 'assets/icons/transport.png'},
    {'tache': 'Clubs', 'icon': 'assets/icons/club.png'},
  ];
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final hight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            menuOn = !menuOn;
          });
        },
        child: Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.deepPurple.withOpacity(.3)),
          child: Image.asset(
            'assets/icons/boss.png',
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Stack(alignment: Alignment.center, children: [
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            // height: 900,
            child: Column(
              children: [
                Gap(15),
                taskPage[page],
              ],
            ),
          ),
        ),
        if (menuOn)
          Positioned(
            // bottom: 10,
            right: 13,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.withOpacity(.3)),
              child: Column(
                children: taches
                    .map((e) => GestureDetector(
                          onTap: () {
                            setState(() {
                              page = taches.indexOf(e);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                //border: Border.all(color: Colors),
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(.7)),
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              e['icon'],
                              width: 15,
                              height: 15,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
      ]),
    );
  }
}
