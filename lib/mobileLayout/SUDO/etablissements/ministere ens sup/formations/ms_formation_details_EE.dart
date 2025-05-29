// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MSFormationDetailsEE extends StatefulWidget {
  final String etab;
  final String speciality;
  MSFormationDetailsEE({
    Key? key,
    required this.etab,
    required this.speciality,
  }) : super(key: key);

  @override
  State<MSFormationDetailsEE> createState() => _MSFormationDetailsEEState();
}

class _MSFormationDetailsEEState extends State<MSFormationDetailsEE> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController uE_lib = TextEditingController();
  final TextEditingController uE_coef = TextEditingController();
  final TextEditingController uE_credit = TextEditingController();
  final TextEditingController uE_regime = TextEditingController();
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
    uE_lib.dispose();
    eE_credit.dispose();
    uE_coef.dispose();
    uE_credit.dispose();
    uE_regime.dispose();
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
    uE_regime.addListener(() {
      setState(() {});
    });

    uE_lib.addListener(() {
      setState(() {});
    });
    uE_coef.addListener(() {
      setState(() {});
    });
    uE_credit.addListener(() {
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
        title: const Text("Ajouter un plan d'etude"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                _addSpecialite1();
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
/********************************************************etablissement **************/
              Gap(15),
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        widget.etab,
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        widget.speciality,
                        style: TextStyle(
                          letterSpacing: 1.7,
                          color: Colors.deepPurple.shade200,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
/********************************************************etablissement **************/

              Gap(10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Unité d'enseignement :",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black.withOpacity(.4)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: GestureDetector(
                                onTap: () => _addSpecialite1(),
                                child: Icon(Icons.add)),
                          )
                        ],
                      ),
                      Gap(10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: uE_lib,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'libellé est vide';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Libellé',
                          suffixIcon: uE_lib.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    uE_lib.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                        ),
                      ),
                      Gap(10),
                      TextFormField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        controller: uE_coef,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Coef. est vide';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Coefficient',
                          suffixIcon: uE_coef.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    uE_coef.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                        ),
                      ),
                      Gap(10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: uE_credit,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Credit est vide';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Credit',
                          suffixIcon: uE_credit.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    uE_credit.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                        ),
                      ),
                      Gap(10),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: uE_regime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Regime est vide';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Régime',
                          suffixIcon: uE_regime.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    uE_regime.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                        ),
                      ),
                      Gap(15),
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
                                color:
                                    const Color.fromARGB(255, 238, 235, 235))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          color: Colors.black.withOpacity(.4)),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                      onTap: () => _addSpecialite2(),
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
                                  fontWeight: FontWeight.w400, fontSize: 15),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Cours:'),
                                      Gap(8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        height: 35,
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: eE_VH_cours,
                                            onChanged: (value) {
                                              setState(() {
                                                eE_VH_total.text = (int.parse(
                                                            eE_VH_cours.text) +
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
                                                      BorderRadius.circular(3)),
                                              //labelText: 'Libellé',
                                              // labelText: 'Régime',
                                              suffixIcon:
                                                  eE_VH_cours.text.isEmpty
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('TD:'),
                                      Gap(23),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        height: 35,
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                eE_VH_total.text = (int.parse(
                                                            eE_VH_cours.text) +
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
                                                      BorderRadius.circular(3)),
                                              //labelText: 'Libellé',
                                              // labelText: 'Régime',
                                              suffixIcon: eE_VH_TD.text.isEmpty
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('TP:'),
                                      Gap(23),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        height: 35,
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                eE_VH_total.text = (int.parse(
                                                            eE_VH_cours.text) +
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
                                                      BorderRadius.circular(3)),
                                              //labelText: 'Libellé',
                                              // labelText: 'Régime',
                                              suffixIcon: eE_VH_TP.text.isEmpty
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Total:'),
                                      Gap(15),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        height: 35,
                                        child: Center(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
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
                                                      BorderRadius.circular(3)),
                                              //labelText: 'Libellé',
                                              // labelText: 'Régime',
                                              suffixIcon:
                                                  eE_VH_total.text.isEmpty
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
              ),
              const Gap(25),
            ],
          ),
        ),
      ),
    );
  }

  void _addSpecialite1() async {
    if (_formKey.currentState!.validate()) {
      dbFormation().registerPlanEtude(
       
        widget.speciality,
        uE_lib.text.trim(),
        uE_coef.text.trim(),
        uE_credit.text.trim(),
        uE_regime.text.trim(),
        eE_lib.text.trim(),
        eE_coef.text.trim(),
        eE_credit.text.trim(),
        eE_regime.text.trim(),
        eE_VH_cours.text.trim(),
        eE_VH_TD.text.trim(),
        eE_VH_TP.text.trim(),
        eE_VH_total.text.trim(),
      );
    }
    uE_lib.clear();
    uE_coef.clear();
    uE_credit.clear();
    uE_regime.clear();
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

  void _addSpecialite2() async {
    if (_formKey.currentState!.validate()) {
      dbFormation().registerPlanEtude(
       
        widget.speciality,
        uE_lib.text.trim(),
        uE_coef.text.trim(),
        uE_credit.text.trim(),
        uE_regime.text.trim(),
        eE_lib.text.trim(),
        eE_coef.text.trim(),
        eE_credit.text.trim(),
        eE_regime.text.trim(),
        eE_VH_cours.text.trim(),
        eE_VH_TD.text.trim(),
        eE_VH_TP.text.trim(),
        eE_VH_total.text.trim(),
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
