import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_firebase/constants.dart';
import 'package:proyecto_firebase/services/data_services.dart';

class DetalleEventosPages extends StatefulWidget {
  const DetalleEventosPages({
    super.key,
    required this.eventoId,
    required this.boolId,
  });
  final String eventoId;
  final bool boolId;

  @override
  State<DetalleEventosPages> createState() => _DetalleEventosPagesState();
}

class _DetalleEventosPagesState extends State<DetalleEventosPages> {
  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  void cargarDatos() {
    print("Cargando datos...");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                future: FsService().eventoDetalle(widget.eventoId),
                builder:
                    (
                      context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshot,
                    ) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      var evento = snapshot.data!;

                      return Container(
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(ColorsLetters().kWhiteCream),
                          border: Border.all(
                            color: Color(
                              ColorsLetters().kWhiteCream,
                            ), // Color del borde
                            width: 2,
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.date_range),
                                Text(
                                  '[${DateFormat('dd-MM-yyyy').format(evento['fecha'].toDate())} | ${DateFormat('HH:mm').format(evento['fecha'].toDate())}]',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(ColorsBackGround().kGreyDark),
                            ),
                            Text(
                              'Titulo: ${evento['titulo']}',
                              style: TextStyle(fontSize: 40),
                            ),

                            Text(
                              'Autor: ${evento['autor'].toString()}',
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              evento['lugar'].toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                            Spacer(),
                            Divider(
                              thickness: 1,
                              color: Color(ColorsBackGround().kGreyDark),
                            ),

                            Text(
                              evento['categoria'].toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    },
              ),
            ),
          ),
          if (widget.boolId)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(ColorsLetters().kWhiteCream),
                border: Border.all(
                  color: Color(ColorsLetters().kWhiteCream), // Color del borde
                  width: 2,
                ),
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero, // No altera el tamaño
                  side: BorderSide.none, // Sin borde
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () async {
                  await FsService().borrarEventos(widget.eventoId);
                  Navigator.pop(context);
                },
                //Navigator.pop(context),
                child: Text(
                  "Borrar",
                  style: TextStyle(color: Color(ColorsBackGround().kGreyDark)),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(ColorsLetters().kWhiteCream),
              border: Border.all(
                color: Color(ColorsLetters().kWhiteCream), // Color del borde
                width: 2,
              ),
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero, // No altera el tamaño
                side: BorderSide.none, // Sin borde
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () => Navigator.pop(context),
              //Navigator.pop(context),
              child: Text(
                "volver",
                style: TextStyle(color: Color(ColorsBackGround().kGreyDark)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
