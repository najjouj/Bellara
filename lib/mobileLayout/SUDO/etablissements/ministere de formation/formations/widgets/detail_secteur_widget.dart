import 'package:bellaraa/commun/commun/list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailSecteurWidget extends StatelessWidget {
  final String secteur;
  const DetailSecteurWidget({super.key, required this.secteur});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 15),
      height: 70,
      child: Row(
          children: secteursMF.map((e) {
        return (e['Secteur'] == secteur)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Secteur :',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Gap(5),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * .65),
                        child: Text(
                          e['Secteur'],
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Text(
                        'Sous secteur :',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      Gap(5),
                      Text(
                        e['sous-secteur'],
                      ),
                    ],
                  ),
                ],
              )
            : SizedBox.shrink();
      }).toList()),
    );
  }
}
