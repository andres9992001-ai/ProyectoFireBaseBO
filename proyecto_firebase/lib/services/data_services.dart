import 'package:cloud_firestore/cloud_firestore.dart';

class FsService {
  //Listar Categorias
  Stream<QuerySnapshot> categorias() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }

  //Agregar Evento
  Future<void> agregarEvento(
    String titulo,
    String lugar,
    String categoria,
    String autor,
    DateTime fecha,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('eventos').doc().set({
        'autor': autor,
        'titulo': titulo,
        'categoria': categoria,
        'lugar': lugar,
        'fecha': fecha,
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').orderBy('fecha', descending: false).snapshots();
  }

  //obtener un evento con su detalle
  Stream<DocumentSnapshot<Map<String, dynamic>>> eventoDetalle(String id) {
    return FirebaseFirestore.instance.collection('eventos').doc(id).get();
  }

  //borrar un evento
  Future<void> borrarEventos(String id) {
    return FirebaseFirestore.instance.collection('eventos').doc(id).delete();
  }
}

