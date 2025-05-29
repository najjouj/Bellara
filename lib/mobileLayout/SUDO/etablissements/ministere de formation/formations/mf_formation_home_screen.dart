import 'package:flutter/material.dart';

import 'mf_formation_btp_screen.dart';
import 'mf_formation_bts_screen.dart';
import 'mf_formation_cap_screen.dart';
import 'mf_formation_cc_screen.dart';

class MFFormationHomeScreen extends StatefulWidget {
  final String gouvernorat;
  const MFFormationHomeScreen({super.key, required this.gouvernorat});

  @override
  State<MFFormationHomeScreen> createState() => _MFFormationHomeScreenState();
}

class _MFFormationHomeScreenState extends State<MFFormationHomeScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
                  text: 'CC',
                ),
                Tab(
                  text: 'CAP',
                ),
                Tab(
                  text: 'BTP',
                ),
                Tab(
                  text: 'BTS',
                ),
              ]),
        ),
        Container(
          height: 400,
          child: TabBarView(controller: _tabController, children: [
            //NiveauScolairePage(),
            MFFormationCCScreen(
              gouvernorat: widget.gouvernorat,
            ),
            MFFormationCAPScreen(gouvernorat: widget.gouvernorat,),
            MFFormationBTPScreen(
              gouvernorat: widget.gouvernorat,
            ),
            MFFormationBTSScreen(gouvernorat: widget.gouvernorat,)
          ]),
        )
      ]),
    );
  }
}
