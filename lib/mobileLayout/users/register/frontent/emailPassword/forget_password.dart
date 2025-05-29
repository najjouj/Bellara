import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../backend/EmailPassword/email_password_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String emailErr = '';

  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Enter your Email and we'll send you a password reset link",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
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
            ),
            const Gap(10),
            MaterialButton(
                color: Colors.deepPurple[200],
                onPressed: (() {
                  resetPassord();
                }),
                child: const Text('Reset Password'))
          ],
        ),
      ),
    );
  }

  void resetPassord() {
    if (formkey.currentState!.validate()) {
      emailPasswordAuthentification()
          .forgotpassword(emailController.text.trim());
      //signinwithemailandpasswordMeth().forgotpassword(_emailController.text.trim());
    } else {
      //showDialog(context: context, builder: builder)
      Get.snackbar('Forgot email', 'problem!!');
    }
  }
}
