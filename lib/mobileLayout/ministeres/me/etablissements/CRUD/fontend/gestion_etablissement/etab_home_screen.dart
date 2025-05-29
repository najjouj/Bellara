import 'package:flutter/material.dart';

import 'taches/Rh_screen.dart';
import 'taches/adresses_screen.dart';
import 'taches/bloc_departement_screen.dart';
import 'taches/club_screen.dart';
import 'taches/presentation_etab_screen.dart';
import 'taches/salle_screen.dart';
import 'taches/services_screen.dart';

class EtabHomeScreen extends StatefulWidget {
  const EtabHomeScreen({super.key});

  @override
  State<EtabHomeScreen> createState() => _EtabHomeScreenState();
}

class _EtabHomeScreenState extends State<EtabHomeScreen> {
  bool menuOn = false;
  int page = 0;
  List<Widget> taskPage = [
    PrentationScreen(),
    AdressessScreen(),
    BlocDepartmentScreen(),
    SalleScreen(),
    RhScreen(),
    ServicesScreen(),
    ClubScreen()
  ];
  final List<Map<String, dynamic>> taches = [
    {'tache': 'Présentation', 'icon': 'assets/icons/school.png'},
    {'tache': 'Adresses', 'icon': 'assets/icons/adress.png'},
    {'tache': 'Bloc/Département', 'icon': 'assets/icons/department.png'},
    {'tache': 'Salles', 'icon': 'assets/icons/classroom.png'},
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
            //height: 900,
            child: Column(
              children: [
                Text('hello'),
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
