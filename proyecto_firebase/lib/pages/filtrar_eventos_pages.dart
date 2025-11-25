import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_firebase/constants.dart';
import 'package:proyecto_firebase/services/data_services.dart';

class FiltrarEventosPages extends StatefulWidget {
  const FiltrarEventosPages({super.key, required this.idUser});
  final String idUser;

  @override
  State<FiltrarEventosPages> createState() => _FiltrarEventosPagesState();
}

class _FiltrarEventosPagesState extends State<FiltrarEventosPages> {
  @override
  //refrescar datos
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
              child: StreamBuilder(
                stream: FsService().eventos(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var listaFiltrada = snapshot.data!.docs
                      .where((doc) => doc['autor'].trim() == widget.idUser)
                      .toList();

                  if (listaFiltrada.isEmpty) {
                    return Center(
                      child: Text(
                        "No tienes eventos ingresados",
                        style: TextStyle(
                          color: Color(ColorsLetters().kWhiteCream),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      var eventos = listaFiltrada[index];
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            if (FirebaseAuth.instance.currentUser!.email ==
                                eventos['autor'].trim())
                              SlidableAction(
                                backgroundColor: Color(
                                  ColorsLetters().kWhiteCream,
                                ),
                                label: ' [ Borrar ]',

                                onPressed: (context) async {
                                  if (FirebaseAuth
                                          .instance
                                          .currentUser!
                                          .email ==
                                      eventos['autor'].trim()) {
                                    await FsService().borrarEventos(eventos.id);
                                  }
                                },
                              ),
                            if (FirebaseAuth.instance.currentUser!.email !=
                                eventos['autor'].toString())
                              SlidableAction(
                                backgroundColor: Color(
                                  ColorsLetters().kWhiteCream,
                                ),
                                label: ' [ No Eres el autor ]',

                                onPressed: (context) async {},
                              ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(ColorsBackGround().kGreyDark),
                            border: Border.all(
                              color: Color(
                                ColorsLetters().kWhiteCream,
                              ), // Color del borde
                              width: 2,
                            ),
                          ),

                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: Color(ColorsLetters().kWhiteCream),
                                  ),
                                  Text(
                                    '[${DateFormat('dd-MM-yyyy').format(eventos['fecha'].toDate())} | ${DateFormat('HH:mm').format(eventos['fecha'].toDate())}]',
                                    style: TextStyle(
                                      color: Color(ColorsLetters().kWhiteCream),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index + 1}# ',
                                    style: TextStyle(
                                      color: Color(ColorsLetters().kWhiteCream),
                                      fontSize: 40,
                                    ),
                                  ),
                                  Text(
                                    eventos['titulo'],
                                    style: TextStyle(
                                      color: Color(ColorsLetters().kWhiteCream),
                                      fontSize: 40,
                                    ),
                                  ),
                                ],
                              ),

                              // Text(
                              //   eventos['autor'].toString(),
                              //   style: TextStyle(
                              //     color: Color(ColorsLetters().kWhiteCream),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
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
