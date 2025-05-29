import 'package:bellaraa/mobileLayout/SUDO/etablissements/ministere%20ens%20sup/ms_home_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'ministere de formation/ministere_formation_home_page.dart';

import 'ministere education/me_welcome_page.dart';

class EtabListHomeScrenn extends StatefulWidget {
  const EtabListHomeScrenn({super.key});

  @override
  State<EtabListHomeScrenn> createState() => _EtabListHomeScrennState();
}

class _EtabListHomeScrennState extends State<EtabListHomeScrenn> {
  int page = 0;
  String activeSelection = "Ministère d'éducation";
  List<String> listOfValue = [
    "Ministère d'éducation",
    "Ministère de l'emploi et de la formation \n professionelle",
    "Ministere de l'enseignement superieur"
  ];
  List<Widget> ministeresPage = [
    MEWelcomePage(),
    MinistereFormationHomePage(),
    MSHomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              //alignment: Alignment.,
              margin: EdgeInsets.all(5),
              width: double.maxFinite,
              //height: 50,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: 120,
                //height: 30,
                // padding: EdgeInsets.all(),
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                    icon: Icon(
                      Icons.arrow_drop_down_circle_rounded,
                      size: 20,
                      color: Colors.deepPurple,
                    ),
                    value: activeSelection,
                    items: listOfValue.map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val,
                            style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.3,
                                fontWeight: FontWeight.w200,
                                color: Colors.grey[800])),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        activeSelection = val as String;
                        page = listOfValue.indexOf(activeSelection);
                      });
                    }),
              )),
          Gap(15),
          ministeresPage[page]
        ],
      ),
    );
  }
}
