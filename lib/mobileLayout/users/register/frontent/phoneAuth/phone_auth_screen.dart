import 'package:bellaraa/commun/widgets/commun_widgets.dart';
import 'package:bellaraa/mobileLayout/users/register/backend/phoneAuth/phone_auth.dart';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  Country? country;
  final TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(20),
                const Text(
                  'WhatsApp well need to verify your phone number.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(20),
                TextButton(
                  onPressed: countryPicker,
                  child: const Text(
                    'Pick country',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    (country == null)
                        ? const Text('+91')
                        : Text('+${country!.phoneCode}'),
                    const Gap(10),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: phoneController,
                        decoration:
                            const InputDecoration(hintText: 'phone number'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 60,
              width: size.width * 0.25,
              child: CommonButton(
                  text: 'NEXT',
                  onPressed: (() {
                    sendPhonenumber();
                  })),
            )
          ],
        ),
      ),
    );
  }

  void countryPicker() {
    showCountryPicker(
        context: context,
        onSelect: (Country countryPicked) {
          setState(() {
            country = countryPicked;
            print('gggggggggggggggggggggggggg${country!.displayName}');
          });
        });
  }

  void sendPhonenumber() {
    final phonenumber = '+${country!.phoneCode}${phoneController.text.trim()}';
    if (country != null && phonenumber.isNotEmpty) {
      print('${phonenumber}resuuuuuuuuult to send');
      PhoneAuth().signInWithPhone(phonenumber);
      // AuthRepository().signInWithPhone( BuildContext, context, '+${country!.phoneCode}$phonenumber');
    } else {
      const SnackBar(
        content: Text('Fill all the fields!!'),
      );
    }
  }
}
