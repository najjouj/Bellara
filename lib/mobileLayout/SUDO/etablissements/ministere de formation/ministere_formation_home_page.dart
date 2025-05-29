import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'centres/centres_list_screen.dart';
import 'formations/mf_formation_home_screen.dart';

class MinistereFormationHomePage extends StatefulWidget {
  const MinistereFormationHomePage({super.key});

  @override
  State<MinistereFormationHomePage> createState() =>
      _MinistereFormationHomePageState();
}

class _MinistereFormationHomePageState
    extends State<MinistereFormationHomePage> {
  String activeSelection = 'Centres';

  String governorat = '';

  List<String> listOfValue = ['Centres', 'Formations'];
  gouvcallback(varSelectedNatEtab) {
    setState(() {
      governorat = varSelectedNatEtab;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                Get.to(() => ListViewSearchScreen(
                    items: gouvernorats, stringCallback: gouvcallback));
              });
            },
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    // width: double.infinity,
                    child: (governorat != '')
                        ? Text(
                            governorat,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          )
                        : const Text(
                            'Gouvernorat',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.deepPurple,
                  )
                ],
              ),
            ),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ministère de l'emploi \net de la formation  professionelle",
                  style: const TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                // Gap(8),
                Container(
                  width: 120,
                  // height: 50,
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
                        });
                      }),
                )
              ],
            ),
          ),
          const Gap(20),
          (activeSelection == 'Centres')
              ? CentreListScreen(
                  governorat: governorat,
                )
              : MFFormationHomeScreen(
                  gouvernorat: governorat,
                )
        ],
      ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              )),
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: 400,
              child: Wrap(children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    height: 5,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                ListTile(
                  //onTap: () => Get.to(() => const AjoutCentrePage()),
                  leading: Container(
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text(
                    'Un centre',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  // onTap: () => Get.to(() => AddSpecialityScreen()),
                  leading: Container(
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text(
                    "Une spécialté",
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  leading: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title:
                      const Text("Un module", style: TextStyle(fontSize: 20)),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                  //onTap: () => Get.to(() => (const AjoutModuleScreen())),
                ),
                ListTile(
                  //onTap: () => Get.to(() => (AddElementEnsScreen())),
                  leading: Container(
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text("un element d'enseignment",
                      style: TextStyle(fontSize: 20)),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
                ListTile(
                  // onTap: () => Get.to(() => (AjoutSpecialiteScreen())),
                  leading: Container(
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[400]),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                  ),
                  title: const Text('Une spécialité',
                      style: TextStyle(fontSize: 20)),
                  subtitle: const Divider(
                    color: Colors.deepPurple,
                  ),
                ),
              ]));
        });
  }
}
