import 'package:flutter/material.dart';
import 'package:proyecto_firebase/services/data_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:proyecto_firebase/services/data_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListarEventos extends StatefulWidget {
  const ListarEventos({super.key});

  @override
  State<ListarEventos> createState() => _ListarEventosState();
}

class _ListarEventosState extends State<ListarEventos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FsService().eventos(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var eventos = snapshot.data!.docs[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          label: 'Borrar',
                          icon: MdiIcons.trashCan,
                          onPressed: (context) async {
                            await FsService().borrarEventos(eventos.id);
                          },
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(MdiIcons.cube),
                      title: Text(eventos['titulo']),
                      subtitle: Row(
                        children: [Text(eventos['autor'].toString())],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
