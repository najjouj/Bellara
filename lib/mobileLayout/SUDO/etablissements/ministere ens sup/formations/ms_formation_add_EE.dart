// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MSFormationAddEE extends StatefulWidget {
  final String etab;
  final String speciality;
  final String planEtude;
  const MSFormationAddEE({
    Key? key,
    required this.etab,
    required this.speciality,
    required this.planEtude,
  }) : super(key: key);

  @override
  State<MSFormationAddEE> createState() => _MSFormationAddEEState();
}

class _MSFormationAddEEState extends State<MSFormationAddEE> {


  final _formKey = GlobalKey<FormState>();

  final TextEditingController eE_lib = TextEditingController();
  final TextEditingController eE_coef = TextEditingController();
  final TextEditingController eE_regime = TextEditingController();
  final TextEditingController eE_credit = TextEditingController();
  final TextEditingController eE_VH_cours = TextEditingController();
  final TextEditingController eE_VH_TD = TextEditingController();
  final TextEditingController eE_VH_TP = TextEditingController();
  final TextEditingController eE_VH_total = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    eE_credit.dispose();

    eE_lib.dispose();
    eE_coef.dispose();
    eE_regime.dispose();
    eE_VH_cours.dispose();
    eE_VH_TD.dispose();
    eE_VH_TP.dispose();
    eE_VH_total.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eE_credit.addListener(() {
      setState(() {});
    });
    eE_regime.addListener(() {
      setState(() {});
    });
    eE_coef.addListener(() {
      setState(() {});
    });
    eE_lib.addListener(() {
      setState(() {});
    });

    eE_VH_total.addListener(() {
      setState(() {});
    });
    eE_VH_TP.addListener(() {
      setState(() {});
    });
    eE_VH_TD.addListener(() {
      setState(() {});
    });
    eE_VH_cours.addListener(() {
      setState(() {});
    });
    eE_VH_cours.text = '0';
    eE_VH_TD.text = '0';
    eE_VH_TP.text = '0';
    eE_VH_total.text = (int.parse(eE_VH_cours.text) +
            int.parse(eE_VH_TD.text) +
            int.parse(eE_VH_TP.text))
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("+ Un element d'enseignement"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _addElementEnseignment();
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
    
                Gap(20),
               
                  Container(
                    padding: EdgeInsets.all(18),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18)),
                        border: Border.all(
                            color: const Color.fromARGB(255, 206, 205, 205))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                          Container(
                            margin: EdgeInsets.only(
                              left: 5,
                            ),
                            width: MediaQuery.of(context).size.width * .90,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[100]!.withOpacity(.4),
                                borderRadius: BorderRadius.circular((10)),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 238, 235, 235))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Element d'enseignement :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.black.withOpacity(.4)),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: GestureDetector(
                                          onTap: () => _addElementEnseignment(),
                                          child: Icon(Icons.add)),
                                    )
                                  ],
                                ),
                                Gap(10),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: eE_lib,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Libellé est vide';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    //labelText: 'Libellé',
                                    labelText: 'Libellé',
                                    suffixIcon: eE_lib.text.isEmpty
                                        ? null
                                        : IconButton(
                                            onPressed: (() {
                                              eE_lib.clear();
                                            }),
                                            icon: const Icon(Icons.close)),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  controller: eE_coef,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Coef. est vide';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    //labelText: 'Libellé',
                                    labelText: 'Coefficient',
                                    suffixIcon: eE_coef.text.isEmpty
                                        ? null
                                        : IconButton(
                                            onPressed: (() {
                                              eE_coef.clear();
                                            }),
                                            icon: const Icon(Icons.close)),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: eE_credit,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Credit est vide';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    //labelText: 'Libellé',
                                    labelText: 'Crédit',
                                    suffixIcon: eE_credit.text.isEmpty
                                        ? null
                                        : IconButton(
                                            onPressed: (() {
                                              eE_credit.clear();
                                            }),
                                            icon: const Icon(Icons.close)),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: eE_regime,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Régime est vide';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    //labelText: 'Libellé',
                                    labelText: 'Régime',
                                    suffixIcon: eE_regime.text.isEmpty
                                        ? null
                                        : IconButton(
                                            onPressed: (() {
                                              eE_regime.clear();
                                            }),
                                            icon: const Icon(Icons.close)),
                                  ),
                                ),
                                Gap(15),
                                Text(
                                  'Volume horaire :',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(8),
                                  width: MediaQuery.of(context).size.width * .7,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular((8)),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 238, 235, 235))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Cours:'),
                                          Gap(8),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            height: 35,
                                            child: Center(
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: eE_VH_cours,
                                                onChanged: (value) {
                                                  setState(() {
                                                    eE_VH_total
                                                        .text = (int.parse(
                                                                eE_VH_cours
                                                                    .text) +
                                                            int.parse(
                                                                eE_VH_TD.text) +
                                                            int.parse(
                                                                eE_VH_TP.text))
                                                        .toString();
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'cours est vide';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  //labelText: 'Libellé',
                                                  // labelText: 'Régime',
                                                  suffixIcon: eE_VH_cours
                                                          .text.isEmpty
                                                      ? null
                                                      : IconButton(
                                                          onPressed: (() {
                                                            eE_VH_cours.clear();
                                                          }),
                                                          icon: const Icon(
                                                              Icons.close)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Gap(10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('TD:'),
                                          Gap(23),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            height: 35,
                                            child: Center(
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {
                                                    eE_VH_total
                                                        .text = (int.parse(
                                                                eE_VH_cours
                                                                    .text) +
                                                            int.parse(
                                                                eE_VH_TD.text) +
                                                            int.parse(
                                                                eE_VH_TP.text))
                                                        .toString();
                                                  });
                                                },
                                                controller: eE_VH_TD,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'TD est vide';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  //labelText: 'Libellé',
                                                  // labelText: 'Régime',
                                                  suffixIcon: eE_VH_TD
                                                          .text.isEmpty
                                                      ? null
                                                      : IconButton(
                                                          onPressed: (() {
                                                            eE_VH_TD.clear();
                                                          }),
                                                          icon: const Icon(
                                                              Icons.close)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Gap(10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('TP:'),
                                          Gap(23),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            height: 35,
                                            child: Center(
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {
                                                    eE_VH_total
                                                        .text = (int.parse(
                                                                eE_VH_cours
                                                                    .text) +
                                                            int.parse(
                                                                eE_VH_TD.text) +
                                                            int.parse(
                                                                eE_VH_TP.text))
                                                        .toString();
                                                  });
                                                },
                                                controller: eE_VH_TP,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'TP est vide';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  //labelText: 'Libellé',
                                                  // labelText: 'Régime',
                                                  suffixIcon: eE_VH_TP
                                                          .text.isEmpty
                                                      ? null
                                                      : IconButton(
                                                          onPressed: (() {
                                                            eE_VH_TP.clear();
                                                          }),
                                                          icon: const Icon(
                                                              Icons.close)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Gap(10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Total:'),
                                          Gap(15),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .25,
                                            height: 35,
                                            child: Center(
                                              child: TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: eE_VH_total,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'total est vide';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                  //labelText: 'Libellé',
                                                  // labelText: 'Régime',
                                                  suffixIcon: eE_VH_total
                                                          .text.isEmpty
                                                      ? null
                                                      : IconButton(
                                                          onPressed: (() {
                                                            eE_VH_total.clear();
                                                          }),
                                                          icon: const Icon(
                                                              Icons.close)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                const Gap(25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addElementEnseignment() async {
    if (_formKey.currentState!.validate()) {
 dbFormation().registerElementEnseignment(
 
        widget.speciality,
        widget.planEtude,
        eE_lib.text.trim(),
        eE_coef.text.trim(),
        eE_credit.text.trim(),
        eE_regime.text.trim(),
        eE_VH_cours.text.trim(),
        eE_VH_TD.text.trim(),
        eE_VH_TP.text.trim(),
        eE_VH_total.text.trim()
      );
    }

    eE_lib.clear();
    eE_coef.clear();
    eE_credit.clear();
    eE_regime.clear();
    eE_VH_cours.clear();
    eE_VH_TD.clear();
    eE_VH_TP.clear();
    eE_VH_total.clear();
    /*  signinwithemailandpasswordMeth().registerNvEcole(
          nomController.text,
          adresseController.text,
          presentationController.text,
          telController.text,
          selectedServices,
          galleries);*/
  }
}