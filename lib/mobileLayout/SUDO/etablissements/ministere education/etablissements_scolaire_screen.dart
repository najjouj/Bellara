import 'package:flutter/material.dart';

import 'college_list_screen.dart';
import 'ecole_primaire_home_screen.dart';
import 'lycees_list_screen.dart';

class EtablissementsScolaireScreen extends StatefulWidget {
  final String delegation;
  EtablissementsScolaireScreen({super.key, required this.delegation});

  @override
  State<EtablissementsScolaireScreen> createState() =>
      _EtablissementsScolaireScreenState();
}

class _EtablissementsScolaireScreenState
    extends State<EtablissementsScolaireScreen> with TickerProviderStateMixin {
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
            EcolesPrimaireScolaireHomeScreen(delegation: widget.delegation),
            CollegeListScreen(
              delegation: widget.delegation,
            ),
            LyceeListScreen(
              delegation: widget.delegation,
            )
          ]),
        )
      ]),
    );
  }
}
