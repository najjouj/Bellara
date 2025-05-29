import 'package:bellaraa/commun/widgets/commun_widgets.dart';
import 'package:bellaraa/mobileLayout/users/register/backend/anonymous/sign_in_anonymous.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../backend/google/google_auth.dart';

class GoogleAth extends StatelessWidget {
  const GoogleAth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.amber,
              child: MaterialButton(
                onPressed: () => googleAuth().signInWithGoogleAccount(),
                child: const Text('Sign in with Google'),
              ),
            ),
            const Gap(15),
            Container(
              color: Colors.amber,
              child: MaterialButton(
                onPressed: () => googleAuth().handleSignOut(),
                child: const Text('Sign out with Google'),
              ),
            ),
            const Gap(15),
            Container(
              color: Colors.amber,
              child: MaterialButton(
                onPressed: () =>
                    alertSnackBar(context, 'Alert', 'problem somewhere!!'),
                child: const Text('test snackbar'),
              ),
            ),
            const Gap(15),
            Container(
              color: Colors.amber,
              child: MaterialButton(
                onPressed: () =>
                    SuccessSnackBar(context, 'Success', 'good well doing!!'),
                child: const Text('success snackbar'),
              ),
            ),
            const Gap(15),
            Container(
              color: Colors.amber,
              child: MaterialButton(
                onPressed: () => ShowDialogProgress(context),
                child: const Text('progress show dialog'),
              ),
            ),
            const Gap(15),
            Container(
              color: Colors.amber,
              child: MaterialButton(
                onPressed: () => AnonymousAuth().signInAnonymous(),
                child: const Text('sign in anonymous show dialog'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
