
import 'package:flutter/material.dart';

import 'centre_public_list_screen.dart';
import 'centres_prives_list_screen.dart';

class CentreListScreen extends StatefulWidget {
  final String governorat;
  const CentreListScreen({super.key, required this.governorat});

  @override
  State<CentreListScreen> createState() => _CentreListScreenState();
}

class _CentreListScreenState extends State<CentreListScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Expanded(
        //height: 600,
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
                  text: 'Public',
                ),
                Tab(
                  text: 'Privée',
                ),
              ]),
        ),
        Expanded(
          //height: 300,
          child: TabBarView(controller: _tabController, children: [
            // PublicUniversityScreen(),
            // PrivateUniversityScreen(),
            CentresPublicListScreen(
              governorat: widget.governorat,
            ),
            CentresPrivesListScreen(governorat: widget.governorat,)
          ]),
        )
      ],
    ));
  }
}
