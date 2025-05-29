import 'dart:io';
import 'package:path/path.dart';
import 'package:bellaraa/commun/commun/utils.dart';
import 'package:bellaraa/mobileLayout/SUDO/formations/backend/dB_formation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'me_formation_pdf_screenView.dart';

class MEFormationUpdateMatiere extends StatefulWidget {
  final DocumentSnapshot matiere;
  final String uidNiv;
  const MEFormationUpdateMatiere(
      {super.key, required this.matiere, required this.uidNiv});

  @override
  State<MEFormationUpdateMatiere> createState() =>
      _MEFormationUpdateMatiereState();
}

class _MEFormationUpdateMatiereState extends State<MEFormationUpdateMatiere> {
  TextEditingController? coefController;
  String pdfFileName = '';
  String pdfUrl = '';
  String domainMat = '';
  String support = '';
  String coefMat = '';
  File? pdfFile;
  List supports = [];
  String mat = '';
  Uint8List? pdfwebfile;
  final _formKey = GlobalKey<FormState>();
  List<String> domaineMat = [
    'Langues',
    'Sciences',
    'Technologie',
    'Socialisation',
    'Eveil artistique et corporelle'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mat = widget.matiere['matière'];
    domainMat = widget.matiere['domaine'];
    coefMat = widget.matiere['coef'];
    supports = widget.matiere['supports'];
    coefController = TextEditingController(text: widget.matiere['coef']);
    coefController!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //String domaine = widget.matiere['domaine'];

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text(widget.matiere['matière']),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _saveModification();
            },
            icon: const Icon(Icons.save),
            color: Colors.deepPurple,
          )
        ],
      ),
      body: StreamBuilder(
        stream: dbFormation()
            .academiaStore
            .doc('me')
            .collection('niveaux scolaire')
            .doc(widget.uidNiv.toLowerCase())
            .collection('matieres')
            .doc(mat.toLowerCase())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          } else if (snapshot.hasError) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
              child: Column(
                children: [
                  Gap(10),
                  Center(
                      child: Text('no data',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            if (!snapshot.data!.exists) {
              return Column(
                children: [
                  const Gap(150),
                  Center(
                      child: Column(
                    children: [
                      const Text("Ajouter une matière",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w300)),
                      Image.asset(
                        'assets/icons/school.png',
                        height: 30,
                        width: 30,
                        color: Colors.deepPurple,
                      )
                    ],
                  )),
                ],
              );
            } else {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: 900,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                      widget.uidNiv,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const Gap(40),
                    DropdownSearch(
                        key: _formKey,
                        validator: <String>(value) {
                          if (value == null || value.isEmpty) {
                            print('ffffffffffffffffffffffffffffffffffff');
                            print(value);
                            return 'domaine est vide';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            domainMat = value!;
                          });
                        },
                        items: domaineMat,
                        selectedItem: domainMat,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                // contentPadding: EdgeInsets.all(8),
                                labelText: 'Domaine',
                                labelStyle: TextStyle(
                                    height: 1.2,
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    color: Colors.grey[700]))),
                        dropdownButtonProps: const DropdownButtonProps()),
                    const Gap(20),
                    TextFormField(
                      // key: _formKey,
                      keyboardType: TextInputType.text,
                      controller: coefController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          print('coef gggggggggggggggggggggg');
                          print(value);
                          return 'coefficient est vide';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Coefficient',
                        suffixIcon: coefController!.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: (() {
                                  coefController!.clear();
                                }),
                                icon: const Icon(Icons.close)),
                      ),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Supports : ${snapshot.data!.get('supports').length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 224, 224, 224))),
                          child: IconButton(
                              onPressed: () {
                                uploadpdf();
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.deepPurple,
                              )),
                        ),
                      ],
                    ),
                    const Gap(15),
                    if (pdfFile != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        child: SfPdfViewer.file(pdfFile!),
                      ),
                    SizedBox(
                        height: 600,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.2,
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1),
                            itemCount:
                                snapshot.data!.get('supports').length + 1,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return GestureDetector(
                                  onTap: () {
                                    uploadpdf();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 60,
                                    width: 60,
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      color: Colors.grey[400]!,
                                      dashPattern: const [8, 4],
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 20.0,
                                          color: Colors.grey,
                                        ),
                                        //end of icon
                                      ),
                                      //end of center
                                    ),
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () => Get.to(
                                  () => SupportViewScreen(
                                    title: snapshot.data!
                                        .get('supports')[index - 1]['title'],
                                    pdfUrl: snapshot.data!
                                        .get('supports')[index - 1]['pdfUrl'],
                                  ),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(5),
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 206, 206, 206))
                                        // color: Colors.deepPurple[100])
                                        ),
                                    child: Column(
                                      children: [
                                        Container(
                                          // width: 60,
                                          //height: 20,

                                          child: Text(
                                            snapshot.data!
                                                    .get('supports')[index - 1]
                                                ['title'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 14,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                        Expanded(
                                          child: SfPdfViewer.network(snapshot
                                                  .data!
                                                  .get('supports')[index - 1]
                                              ['pdfUrl']),
                                        ),
                                      ],
                                    )),
                              );
                            })),
                  ]),
                ),
              );
            }
          } else {
            return const Padding(
              padding: EdgeInsets.fromLTRB(5, 60, 10, 0),
              child: Column(
                children: [
                  Gap(10),
                  Center(
                      child: Text('no data',
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            );
          }
        },
      ),

      //****************************************old*********************************** */
    );
  }

  void _modifierDomaine(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: 400,
              child: Wrap(children: [
                const Text('welcome'),
                DropdownSearch(
                    onChanged: (value) {
                      setState(() {
                        domainMat = value!;
                      });
                    },
                    items: domaineMat,
                    selectedItem: domainMat,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            // contentPadding: EdgeInsets.all(8),
                            labelText: 'Domaine',
                            labelStyle: TextStyle(
                                height: 1.2,
                                letterSpacing: 1,
                                fontSize: 20,
                                color: Colors.grey[700]))),
                    dropdownButtonProps: const DropdownButtonProps()),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      dbFormation().updateMatiereDomaine(
                          widget.uidNiv, widget.matiere['matière'], domainMat);
                      Get.back();
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ]));
        });
  }

  void _modifierCoef(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: MediaQuery.of(context).size.height * .3,
              child: Wrap(children: [
                const Text('welcome coef'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .5,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              coefMat = value;
                            });
                          },
                          controller: coefController,
                          decoration:
                              const InputDecoration(label: Text('Coefficient')),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          dbFormation().updateMatiereCoef(widget.uidNiv,
                              widget.matiere['matière'], coefController!.text);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ]));
        });
  }

  void uploadpdf() async {
    final res = await pickpdf();
    if (res != null) {
      if (kIsWeb) {
        setState(() {
          pdfwebfile = res.files.first.bytes!;
        });
      } else {
        setState(() async {
          pdfFile = File(res.files.first.path!);
          pdfFileName = basename(pdfFile!.path);
          print('hellooooooooooooooo');
          print(widget.uidNiv);
          //print(basename(pdfFile!.path));
          pdfUrl = await savePdfFileME(widget.uidNiv, widget.matiere['matière'],
                  pdfFileName, pdfFile)
              .then((value) {
            dbFormation().addMatiereSupport(widget.uidNiv,
                widget.matiere['matière'], basename(pdfFile!.path), value);
            // pdfFile = null;
            return value;
          });
          print('zzzzzzzzzz$pdfUrl');
        });
      }
    }
    Widget previewPdf() {
      return SizedBox(
        height: 60,
        width: double.infinity,
        child: SfPdfViewer.file(pdfFile!),
      );
    }

    //
  }

  void _ajouterSupport(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: 200,
              child: Wrap(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('welcome support'),
                      SizedBox(
                          height: 40,
                          width: 120,
                          child: MaterialButton(
                            color: Colors.deepPurple,
                            onPressed: () async {
                              uploadpdf();
                              print('hellooooooooooooooo');
                              print(widget.uidNiv);
                              //print(basename(pdfFile!.path));
                              pdfUrl = await savePdfFileME(
                                      widget.uidNiv,
                                      widget.matiere['matière'],
                                      basename(pdfFile!.path),
                                      pdfFile)
                                  .then((value) {
                                dbFormation().addMatiereSupport(
                                    widget.uidNiv,
                                    widget.matiere['matière'],
                                    basename(pdfFile!.path),
                                    value);
                                // pdfFile = null;
                                return value;
                              });
                              print('zzzzzzzzzz$pdfUrl');
                              /* signinwithemailandpasswordMeth()
                                  .addMatiereSupport(widget.uidNiv,
                                      widget.matiere['matière'], pdfUrl); */

                              setState(() {
                                Get.back();
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Text(
                              'Chercher',
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ]));
        });
  }

  void openPdfFullScreen(BuildContext context, String title, String pdfUrl) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
              // padding: EdgeInsets.only(left: 25, top: 10, right: 25, bottom: 35),
              height: 1200,
              child: Wrap(children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(title),
                ),
                Expanded(child: SfPdfViewer.network(pdfUrl))
              ]));
        });
  }

  void _saveModification() {
    dbFormation().updateMatiereCoef(
        widget.uidNiv, widget.matiere['matière'], coefController!.text);

    // }

    dbFormation().updateMatiereDomaine(
        widget.uidNiv, widget.matiere['matière'], domainMat);
    // uploadpdf();

    Get.back();
  }
}
