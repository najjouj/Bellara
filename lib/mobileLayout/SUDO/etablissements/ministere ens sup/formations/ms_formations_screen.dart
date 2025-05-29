import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'ms_formations_ecoles_screen.dart';
import 'ms_formations_facultes_screen.dart';
import 'ms_formations_institus_screen.dart';

class MSFormationsScreen extends StatefulWidget {
  final String university;
  const MSFormationsScreen({super.key, required this.university});

  @override
  State<MSFormationsScreen> createState() => _MSFormationsScreenState();
}

class _MSFormationsScreenState extends State<MSFormationsScreen>
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
                    text: "E. d'ingenieurs",
                  ),
                  Tab(
                    text: 'E. medicales',
                  ),
                  Tab(
                    text: 'LMD',
                  ),
                ]),
          ),
          Gap(20),
          Container(
            // color: Colors.blue,
            height: 440,
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: TabBarView(controller: _tabController, children: [
              // AfficherFaculteesScreen( university: widget.university,  ),
              // AfficherInstitusScreen( university: widget.university, ),
              // AfficherEcolesScreen( university: widget.university,  ),
              MSFormationsFacultesScreen(
                university: widget.university,
              ),
              MSFormationsINstitusScreen(
                university: widget.university,
              ),
              MSFormationsEcolesScreen(
                university: widget.university,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
