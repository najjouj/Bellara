import 'package:flutter/material.dart';

class ChildCard extends StatefulWidget {
  final Map<String, dynamic> child;
  const ChildCard({super.key, required this.child});

  @override
  State<ChildCard> createState() => _ChildCardState();
}

class _ChildCardState extends State<ChildCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 350),
        child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.child['photoUrl']),
            ),
            title: Text(widget.child['nom'],
                style: TextStyle(fontSize: 14, color: Colors.black)),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  widget.child['tapped'] = !widget.child['tapped'];
                });
                // Get.back();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                child: (widget.child['etat'] == 'envoyée')
                    ? Text(
                        'En attente',
                        style: TextStyle(color: Colors.white),
                      )
                    : (widget.child['etat'] == 'Supprimée')
                        ? Text(
                            'Supprimée',
                            style: TextStyle(color: Colors.white),
                          )
                        : (widget.child['etat'] == 'membre')
                            ? Text('Membre',
                                style: TextStyle(color: Colors.white))
                            : Text('Suivre',
                                style: TextStyle(color: Colors.white)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.child['tapped']
                        ? Colors.deepPurple
                        : Colors.deepPurple.shade200),
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.child['etablissement actuel'],
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      color: Colors.black54),
                ),
                if (widget.child['specialité'] != '')
                  Text(widget.child['specialité'],
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          color: Colors.grey)),
                if (widget.child['niveau scolaire'] != '')
                  Text(widget.child['niveau scolaire'],
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          color: Colors.grey)),

                //**************************gestion des invitations ********************************** */

                if (widget.child['etat'] == 'envoyée')
                  Text('Invitations envoyée',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          color: Colors.deepPurple)),
                if (widget.child['etat'] == 'supprimée')
                  Text('Invitations supprimée',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          color: Colors.deepPurple)),
                if (widget.child['etat'] == 'membre')
                  Text('Membre',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          color: Colors.deepPurple)),
                if (widget.child['etat'] == '')
                  Text('envoyer une invitation',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          color: Colors.deepPurple)),
              ],
            )),
      ),

      //
    );
  }
}
