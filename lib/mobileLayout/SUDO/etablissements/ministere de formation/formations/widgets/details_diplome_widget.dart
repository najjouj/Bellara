import 'package:bellaraa/commun/commun/list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DEtailsDiplomeWidget extends StatelessWidget {
  final String diplome;
  DEtailsDiplomeWidget({super.key, required this.diplome});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: diplomesMF.map((e) {
          return (e['diplome'] == diplome)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Diplôme : ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          e['diplome'] + '(' + e['lib'] + ')',
                        ),
                      ],
                    ),
                    Gap(5),
                    Row(
                      children: [
                        Text(
                          'Durée de formation : ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          e['durée de formation'],
                        ),
                      ],
                    ),
                    Gap(5),
                    Row(
                      children: [
                        Text(
                          "Niveau d'admission : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          e["niveau d'admission"],
                        ),
                      ],
                    )
                  ],
                )
              : SizedBox.shrink();
        }).toList(),
      ),
    );
    /*
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Diplôme : ',
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  detailDiplome['diplome'] + '(' + detailDiplome['lib'] + ')',
                ),
              ],
            ),
            Gap(5),
            Row(
              children: [
                Text(
                  'Durée de formation : ',
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  detailDiplome['durée de formation'],
                ),
              ],
            ),
            Gap(5),
            Row(
              children: [
                Text(
                  "Niveau d'admission : ",
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  detailDiplome["niveau d'admission"],
                ),
              ],
            )
          ],
        ));
  */
  }
}
