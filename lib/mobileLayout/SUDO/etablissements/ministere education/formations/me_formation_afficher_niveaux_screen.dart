import 'package:flutter/material.dart';

import 'me_formation_afficher_niveaux_college.dart';
import 'me_formation_afficher_niveaux_ecole.dart';
import 'me_formation_afficher_niveaux_lycee.dart';

class MEFormationAfficherNiveauxScreen extends StatefulWidget {
  const MEFormationAfficherNiveauxScreen({super.key});

  @override
  State<MEFormationAfficherNiveauxScreen> createState() =>
      _MEFormationAfficherNiveauxScreenState();
}

class _MEFormationAfficherNiveauxScreenState
    extends State<MEFormationAfficherNiveauxScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(children: [
        //Gap(25),
        SizedBox(
          height: 25,
          child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(color: Colors.grey),
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Ecoles',
                ),
                Tab(
                  text: 'Collèges',
                ),
                Tab(
                  text: 'Lycées',
                )
              ]),
        ),
        Container(
          height: 400,
          child: TabBarView(controller: _tabController, children: [
            //NiveauScolairePage(),
            MEFormationAfficherNiveauxEcole(),
            MEFormationAfficherNiveauxCollege(),
            MEFormationAfficherNiveauxLycee()
          ]),
        )
      ]),
    );
  }
}
