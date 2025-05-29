import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

void alertSnackBar(BuildContext context, String title, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.fixed,
      elevation: 0,
      content: Stack(clipBehavior: Clip.none, children: [
        Container(
          // margin: EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 90,
          //width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.red),
          child: Row(
            children: [
              const Gap(55),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      msg,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis, fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          //bottom: 0,
          top: -10,
          left: -5,
          child: SvgPicture.asset(
            'assets/svg/fail.svg',
            height: 105,
            width: 75,
            //color: const Color.fromARGB(255, 122, 2, 2),
          ),
        ),
        Positioned(
          bottom: -10,
          //left: -5,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              'assets/svg/bolle.svg',
              height: 48,
              width: 40,
              color: const Color.fromARGB(255, 122, 2, 2),
            ),
          ),
        ),
      ])));
}
//**************************success snackbar******************************  */

void SuccessSnackBar(BuildContext context, String title, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.fixed,
      elevation: 0,
      content: Stack(clipBehavior: Clip.none, children: [
        Container(
          // margin: EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 90,
          //width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.lightGreen),
          child: Row(
            children: [
              const Gap(95),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Gap(10),
                    Text(
                      msg,
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          //bottom: 0,
          top: -10,
          left: -5,
          child: SvgPicture.asset(
            'assets/svg/happy.svg',
            height: 105,
            width: 35,
            //color: const Color.fromARGB(255, 122, 2, 2),
          ),
        ),
      ])));
}

//********************show dialog progress circular bar *****************************************************************/
void ShowDialogProgress(BuildContext context) {
  showDialog(
      context: context,
      builder: ((context) {
        return Center(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black45),
              child: const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )),
        );
      }));
}
class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CommonButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple, minimumSize: const Size(double.infinity, 50)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}