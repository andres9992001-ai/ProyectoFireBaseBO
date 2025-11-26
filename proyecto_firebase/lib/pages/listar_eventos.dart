import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_firebase/constants.dart';
import 'package:proyecto_firebase/pages/detalle_eventos_pages.dart';
import 'package:proyecto_firebase/pages/filtrar_eventos_pages.dart';
import 'package:proyecto_firebase/services/data_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListarEventos extends StatefulWidget {
  const ListarEventos({super.key});

  @override
  State<ListarEventos> createState() => _ListarEventosState();
}

class _ListarEventosState extends State<ListarEventos> {
  @override
  // para refrescar pagina para obtner data actualizada cuando se entre al apartado
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(ColorsLetters().kWhiteCream),
              //border: Border.all(color: , width: 2),
              borderRadius: BorderRadius.circular(3),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.co_present_outlined),
                    Text(
                      "[ ${FirebaseAuth.instance.currentUser!.email ?? "none@User"} ]",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(ColorsBackGround().kGreyDark),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Color(ColorsBackGround().kGreyDark),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.network(
                      width: 40,
                      height: 40,
                      FirebaseAuth.instance.currentUser!.photoURL ??
                          "None/image",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // data solicitada referente al usuario ingresado
                          " @${FirebaseAuth.instance.currentUser!.displayName}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(ColorsBackGround().kGreyDark),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              //Actualizacion CONSTANTE (tiempo real)
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
                      bool verEmail =
                          FirebaseAuth.instance.currentUser!.email ==
                          eventos['autor'];
                      print("valor${verEmail}");
                      return OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero, // No altera el tamaño
                          side: BorderSide.none, // Sin borde
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleEventosPages(
                                eventoId: eventos.id,
                                boolId: verEmail,
                              ),
                            ),
                          );
                        }, //Navigator.pop(context),
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
                              Divider(
                                thickness: 1,
                                color: Color(ColorsLetters().kWhiteCream),
                              ),
                              Text(
                                '${eventos['categoria']}',
                                style: TextStyle(
                                  color: Color(ColorsLetters().kWhiteCream),
                                  fontSize: 20,
                                ),
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
              onPressed: () {
                print(
                  "valor email ${FirebaseAuth.instance.currentUser?.email ?? "test@gmail.com"}",
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FiltrarEventosPages(
                      idUser:
                          FirebaseAuth.instance.currentUser?.email ??
                          "test@gmail.com",
                    ),
                  ),
                );
              },
              //Navigator.pop(context),
              child: Text(
                "[F] Filtrar Por Usuario",
                style: TextStyle(
                  color: Color(ColorsBackGround().kGreyDark),
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
