import 'package:cloud_firestore/cloud_firestore.dart';

class FsService {
  //Listar Categorias
  Stream<QuerySnapshot> categorias() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }

  //Agregar Evento
  Future<void> agregarEvento(String titulo, String lugar, String categoria, String autor, DateTime fecha) async {
    try {
      await FirebaseFirestore.instance.collection('eventos').doc().set({'autor': autor, 'titulo': titulo, 'categoria': categoria, 'lugar': lugar, 'fecha': fecha});
    } catch (e) {
      rethrow;
    }
  }
}
