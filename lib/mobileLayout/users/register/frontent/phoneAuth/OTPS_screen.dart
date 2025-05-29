import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../backend/phoneAuth/phone_auth.dart';

class OTPSScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OTPSScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OTPSScreen> createState() => _OTPSScreenState();
}

class _OTPSScreenState extends State<OTPSScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Enter your phone number'),
      ),
      body: Center(
          child: Column(
        children: [
          const Gap(
            20,
          ),
          const Text('We have sent an SMS with a code'),
          SizedBox(
            width: size.width * 0.5,
            child: TextField(
              onChanged: ((value) {
                if (value.length == 6) {
                  print('verifying otp..');
                  verifyOTP(context, value.trim());
                }
                print('this function was run');
              }),
              keyboardType: TextInputType.number,
              //inputFormatters: [0:9],
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  hintText: '-   -   -   -   -   -',
                  hintStyle: TextStyle(fontSize: 30)),
            ),
          ),
          // Text(widget.verificationId),
        ],
      )),
    );
  }

  void verifyOTP(BuildContext context, String userOTP) {
    PhoneAuth().verifyOtTP(widget.verificationId, userOTP, widget.phoneNumber);
  }
}
