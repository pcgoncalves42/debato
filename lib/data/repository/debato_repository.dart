import 'package:cloud_firestore/cloud_firestore.dart';
import '../../componentes/dialogs.dart';
import '../../uteis/tools.dart';
import '../models/comentario_model.dart';
import '../models/post_model.dart';
import '../provider/api.dart';

final DebatoRepository debatoRepository = DebatoRepository._private();

class DebatoRepository {
  DebatoRepository._private();

  Future<PostouModel> postar({required String texto}) async{
    try {

      Map<String, dynamic> avaliacao = await chatApi.validarPost(texto);

      if(avaliacao["permitido"] == false){
        return PostouModel(
          status: false,
          msg: avaliacao["explicacao"] ?? "Erro ao obter a explicação"
        );
      }

      CollectionReference postsCollection = FirebaseFirestore.instance.collection('posts');

      String data = dataAtualBR();

      DocumentReference postRef = await postsCollection.add({
        'data': dataAtualBR(),
        'texto': texto,
        'grau': avaliacao["grau-argumentativo"],
        'explicacao': avaliacao["explicacao"],
      });

      return PostouModel(
        status: true,
        post: PostModel(
          id: postRef.id,
          data: data,
          texto: texto,
          totalComentarios: 0,
          grau: avaliacao["grau-argumentativo"],
          explicacao: avaliacao["explicacao"],
        )
      );

    }catch(e){
      print(e.toString());
      return PostouModel(
          status: false,
          msg: e.toString()
      );
    }
  }

  Future<List<PostModel>> listarPosts() async{
    try {
      List<PostModel> lista = [];
      await FirebaseFirestore.instance.collection('posts')
      .orderBy('data', descending: true).get().then((QuerySnapshot querySnapshot) async{
        for (QueryDocumentSnapshot postDoc in querySnapshot.docs) {
          Map<String, dynamic> data = postDoc.data() as Map<String, dynamic>;
          lista.add(PostModel(
              id: postDoc.id,
              data: data['data'],
              grau: data['grau'],
              explicacao: data['explicacao'],
              totalComentarios: await contarComentariosDoPost(postDoc.reference),
              texto: data['texto']
          ));
        }
      });
      return lista;

    }catch(e){
      snackBarError(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<int> contarComentariosDoPost(DocumentReference postRef) async {
    try {
      QuerySnapshot comentariosSnapshot = await postRef.collection('comentarios').get();
      int totalComentarios = comentariosSnapshot.size;
      return totalComentarios;

    }catch(e){
      snackBarError(e.toString());
      print(e.toString());
      return 0;
    }
  }

  Future<ComentouModel> comentar({
    required String idPost,
    required String txtPost,
    required String txtComentario
  }) async{
    try {

      Map<String, dynamic> avaliacao = await chatApi.validarComentario(
        post: txtPost,
        comentario: txtComentario
      );

      if(avaliacao["permitido"] == false){
        return ComentouModel(
          status: false,
          msg: avaliacao["explicacao"] ?? "Erro ao obter a explicação"
        );
      }

      CollectionReference comentariosCollection = FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .collection('comentarios');

      String data = dataAtualBR();

      DocumentReference comentarioRef = await comentariosCollection.add({
        'data': data,
        'texto': txtComentario,
        'totalVoz': 0,
        'grau': avaliacao["grau-argumentativo"],
        'explicacao': avaliacao["explicacao"],
        'deuVoz': false,
      });

      return ComentouModel(
        status: true,
        comentario: ComentarioModel(
          id: comentarioRef.id,
          data: data,
          texto: txtComentario,
          totalVoz: 0,
          grau: avaliacao["grau-argumentativo"],
          explicacao: avaliacao["explicacao"],
          deuVoz: false
        )
      );

    }catch(e){
      print(e.toString());
      return ComentouModel(
        status: false,
        msg: e.toString()
      );
    }

  }

  Future<List<ComentarioModel>> listaComentarios({required String idPost, required String idUsuario}) async{
    try {
      List<ComentarioModel> lista = [];
      await FirebaseFirestore.instance.collection('posts')
        .doc(idPost).collection('comentarios').orderBy('data', descending: true).get().then((QuerySnapshot querySnapshot) async{
          for (QueryDocumentSnapshot comentarioDoc in querySnapshot.docs) {
            Map<String, dynamic> data = comentarioDoc.data() as Map<String, dynamic>;
            List<dynamic> deramVoz = data['usersDeramVoz'] ?? [];
            lista.add(ComentarioModel(
                id: comentarioDoc.id,
                data: data['data'],
                grau: data['grau'],
                totalVoz: data['totalVoz'],
                texto: data['texto'],
                explicacao: data['explicacao'],
                deuVoz: deramVoz.contains(idUsuario)
            ));
          }
        }
      );
      return lista;
    }catch(e){
      snackBarError(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<bool> darVoz({
    required String idPost,
    required String idComentario,
    required String idUsuario,
    required bool deuVoz
  }) async{
    try {
      DocumentReference comentarioRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(idPost)
          .collection('comentarios')
          .doc(idComentario);

      await comentarioRef.update({
        'totalVoz': FieldValue.increment(deuVoz ? 1 : -1),
        'usersDeramVoz': deuVoz ? FieldValue.arrayUnion([idUsuario]) : FieldValue.arrayRemove([idUsuario]),
      });
      return true;

    }catch(e){
      snackBarError(e.toString());
      print(e.toString());
      return false;
    }
  }

}