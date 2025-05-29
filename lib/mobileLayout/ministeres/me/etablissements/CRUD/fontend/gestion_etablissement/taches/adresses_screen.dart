import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdressessScreen extends StatefulWidget {
  const AdressessScreen({super.key});

  @override
  State<AdressessScreen> createState() => _AdressessScreenState();
}

class _AdressessScreenState extends State<AdressessScreen> {
  TextEditingController telFaxController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController sitewebController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    adresseController.dispose();

    telFaxController.dispose();
    emailController.dispose();
    sitewebController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    sitewebController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });

    adresseController.addListener(() {
      setState(() {});
    });

    telFaxController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Adresses',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.7,
                      decorationThickness: .2,
                      fontSize: 26,
                      color: Colors.black)),
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurple.shade100,
                      ),
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.save,
                    color: Colors.deepPurple,
                  ))
            ],
          ),
        ),
        Container(
          height: 600,
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
          padding: const EdgeInsets.only(bottom: 35),
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          //height: 390,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(15),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                //padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: adresseController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'tel. est vide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Adresse",
                    labelStyle: const TextStyle(
                        letterSpacing: 1.2, fontSize: 24, color: Colors.grey),
                    /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                    hintText: "saisir l'adresse",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: adresseController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              adresseController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                //padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: telFaxController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'tel. est vide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Tel./ Fax",
                    labelStyle: const TextStyle(
                        letterSpacing: 1.2, fontSize: 24, color: Colors.grey),
                    /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                    hintText: "saisir la liste des numéros",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: telFaxController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              telFaxController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
              //Gap(15),

              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                //padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: telFaxController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'tel. est vide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "E-mail",
                    labelStyle: const TextStyle(
                        letterSpacing: 1.2, fontSize: 24, color: Colors.grey),
                    /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                    hintText: "xxx@yy.zz",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: telFaxController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              telFaxController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),

              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: sitewebController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'site web. est vide';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    filled: true,
                    fillColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Site web",
                    labelStyle: const TextStyle(
                        letterSpacing: 1.2, fontSize: 24, color: Colors.grey),
                    /*  label: Text(
                                    "Nom de l'établissement",
                                    style: TextStyle(
                                      letterSpacing: 1.3,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),*/
                    hintText: "www.xxxxxxxx.yy",
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                        fontSize: 16),
                    // contentPadding: const EdgeInsets.all(8),
                    suffixIcon: sitewebController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: (() {
                              sitewebController.clear();
                            }),
                            icon: const Icon(Icons.close)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
