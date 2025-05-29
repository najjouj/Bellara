import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'afficher_ecoles.dart';
import 'afficher_facultees_screen.dart';
import 'afficher_institus_screen.dart';

class UnivEtabsScreen extends StatefulWidget {
  final String university;
  const UnivEtabsScreen({super.key, required this.university});

  @override
  State<UnivEtabsScreen> createState() => _UnivEtabsScreenState();
}

class _UnivEtabsScreenState extends State<UnivEtabsScreen>
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
       // color: Colors.amber,

        child: Column(
          children: [
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
                      text: 'Facultés',
                    ),
                    Tab(
                      text: 'Institus',
                    ),
                    Tab(
                      text: 'Ecoles',
                    ),
                  ]),
            ),
            Gap(20),
            Container(
              height: 400,
              child: TabBarView(controller: _tabController, children: [
                AfficherFaculteesScreen(
                  university: widget.university,
                ),
                AfficherInstitusScreen(
                  university: widget.university,
                ),
                AfficherEcolesScreen(
                  university: widget.university,
                ),
              ]),
            ),
          ],
        ));
 
  }
}
