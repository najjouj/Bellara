import 'package:bellaraa/commun/commun/list.dart';
import 'package:bellaraa/commun/widgets/commun_widgets.dart';
import 'package:bellaraa/commun/widgets/list_view_search_screen.dart';
import 'package:bellaraa/mobileLayout/users/register/backend/EmailPassword/email_password_auth.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/frontend/profile_info_cadre.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/frontend/profile_info_eleve.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/frontend/profile_info_enseignant.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/frontend/profile_info_etudiant.dart';
import 'package:bellaraa/mobileLayout/users/welcomeScreens/frontend/profile_info_parent.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'sign_in_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String firstnameErr = '';
  String lastnameErr = '';
  String emailErr = '';
  String passwordErr = '';
  bool passwordobscure = true;
  String role = '';
  rolecallback(varSelectedNatEtab) {
    setState(() {
      role = varSelectedNatEtab;
    });
  }

  // String selectedState = 'State';
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstname.addListener(() {
      setState(() {});
    });
    lastname.addListener(() {
      setState(() {});
    });
    email.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    const Gap(20),
                    TextFormField(
                      controller: firstname,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            firstnameErr = 'first name is empty';
                          });
                          return firstnameErr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          suffixIcon: firstname.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    firstname.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                          //prefixText: 'First name:',
                          //labelText: 'First name',
                          // prefix: Icon(Icons.person),
                          hintText: 'First name',
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: lastname,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            lastnameErr = 'last name is empty';
                          });
                          return lastnameErr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          suffixIcon: lastname.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    lastname.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                          icon: const Icon(Icons.person),
                          //label: Text('Last name'),
                          //prefix: Icon(Icons.person),
                          hintText: 'Last name',
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const Gap(15),
                    const Gap(15),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            emailErr = 'email is empty';
                          });
                          return emailErr;
                        } else {
                          if (!value.contains('@')) {
                            setState(() {
                              emailErr = 'Email not valid';
                            });
                            return emailErr;
                          }
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          icon: const Icon(Icons.email_outlined),
                          suffixIcon: email.text.isEmpty
                              ? null
                              : IconButton(
                                  onPressed: (() {
                                    email.clear();
                                  }),
                                  icon: const Icon(Icons.close)),
                          //prefixText: 'First name:',
                          //labelText: 'First name',
                          // prefix: Icon(Icons.person),

                          hintText: 'Email',
                          //(emailErr == '') ? errorText:  null : emailErr,
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const Gap(10),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            passwordErr = 'password is empty';
                          });
                          return passwordErr;
                        }
                        return null;
                      },
                      obscureText: passwordobscure,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.password_outlined),
                          suffixIcon: passwordobscure
                              ? IconButton(
                                  onPressed: (() {
                                    setState(() {
                                      passwordobscure = !passwordobscure;
                                    });
                                  }),
                                  icon:
                                      const Icon(Icons.visibility_off_outlined))
                              : IconButton(
                                  onPressed: (() {
                                    setState(() {
                                      passwordobscure = !passwordobscure;
                                    });
                                  }),
                                  icon: const Icon(Icons.visibility_outlined)),
                          //prefixText: 'First name:',
                          //labelText: 'First name',
                          // prefix: Icon(Icons.person),

                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.white),
                    ),
                    const Gap(15),
                  ],
                ),
              ),
              Gap(10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Get.to(() => ListViewSearchScreen(
                        items: roles, stringCallback: rolecallback));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.work),
                    Container(
                      height: 50,
                      width: 300,
                      alignment: Alignment.centerLeft,
                      //width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      //margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          /*   boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              offset: const Offset(0, 10),
                                              color: Colors.grey.withOpacity(.2))
                                        ],*/
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: SizedBox(
                        width: 350,
                        child: (role != '')
                            ? Text(
                                role,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              )
                            : Text(
                                'Occupation',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.7)),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(85),
              SizedBox(
                  width: size.width * 75,
                  height: 50,
                  child: CommonButton(
                    text: 'Create an account',
                    onPressed: (() {
                      regiser();
                    }),
                  )),
              const Gap(20),
              GestureDetector(
                onTap: () {
                  //Get.to(() => SignInScreen());
                  //print('whats wrong');
                  Get.to(() => const SignInScreen());
                },
                child: Container(
                  //color: Colors.amber,
                  padding: const EdgeInsets.all(5),
                  child: RichText(
                      text: const TextSpan(
                          text: 'You have an account? ',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          children: [
                        TextSpan(
                            text: 'Log in',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12))
                      ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void regiser() {
    if (formkey.currentState!.validate()) {
      if (role != '') {
        String name = '${firstname.text.trim()} ${lastname.text.trim()}';
        emailPasswordAuthentification().registerUser(
            email.text.trim(),
            password.text.trim(),
            '${firstname.text.trim()} ${lastname.text.trim()}',
            role);
        email.clear();
        password.clear();
        firstname.clear();
        lastname.clear();
        //emailPasswordAuthentification().signOutUser();
        if (role == 'Cadre administrative') {
          Get.to(() => ProfileInfoCadre(
                name: name,
              ));
        } else if (role == 'Parent') {
          Get.to(() => ProfileInfoParent(
                name: name,
              ));
        } else if (role == 'Enseignant') {
          Get.to(() => ProfileInfoEnseignant(
                name: name,
              ));
        } else if (role == 'Eleve') {
          Get.to(() => ProfileInfoEleve(
                name: name,
              ));
        } else if (role == 'Etudiant') {
          Get.to(() => ProfileInfoEtudiant(
                name: name,
              ));
        }
      } else
        Get.snackbar('Registration', 'all field must be filled!!');
      //signinwithemailandpasswordMeth().registerUser(firstname, lastname, email, password, selectedNiveauS, selectedstatus, );
    } else {
      Get.snackbar('Registration', 'registration pb!!');
    }
  }
}
