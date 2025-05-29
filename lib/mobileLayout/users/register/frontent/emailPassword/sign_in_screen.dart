import 'package:bellaraa/commun/widgets/commun_widgets.dart';


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../backend/EmailPassword/email_password_auth.dart';
import 'forget_password.dart';
import 'register_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String emailErr = '';
  String passwordErr = '';
  bool passwordobscure = true;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
          child: Form(
            key: formkey,
            child: Column(
              children: [

                TextFormField(
                  controller: emailController,
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
                          emailErr = 'invalid email';
                        });
                        return emailErr;
                      }
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      icon: const Icon(Icons.email_outlined),
                      suffixIcon: emailController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: (() {
                                emailController.clear();
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
                  controller: passwordController,
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
                              icon: const Icon(Icons.visibility_off_outlined))
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
                const Gap(8),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ForgotPasswordPage());
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Forgot Paswword?',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                const Gap(45),
                SizedBox(
                  width: size.width * 75,
                  height: 50,
                  child: CommonButton(
                      text: 'Login in',
                      onPressed: (() {
                        login(context);
                      })),
                ),
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RegisterScreen());
                    //Navigator.of(context).push(MaterialPageRoute(             builder: ((context) => const RegisterScreen())));
                  },
                  child: Container(
                    //color: Colors.amber,
                    padding: const EdgeInsets.all(5.0),
                    child: RichText(
                        text: const TextSpan(
                            text: 'You don\'t have an account? ',
                            style: TextStyle(
                                color: Colors.black, fontSize: 12),
                            children: [
                          TextSpan(
                              //recognizer: TapGestureRecognizer()..onTap = () {},
                              text: 'Register',
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
      ),
    );
  }

  login(BuildContext context) {
    // signinwithemailandpasswordMeth().signinwithemailandpassword( context, emailController.text, passwordController.text);
    if (formkey.currentState!.validate()) {
      emailPasswordAuthentification().emailPasswordSignIN(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      emailController.clear();
      passwordController.clear();
      Get.snackbar('sign in ', 'sign in done!!');
      //signinwithemailandpasswordMeth().registerUser(firstname, lastname, email, password, selectedNiveauS, selectedstatus, );
    } else {
      Get.snackbar('Registration', 'registration pb!!');
    }
  }
}
