import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../componentes/dialogs.dart';
import '../data/models/comentario_model.dart';
import '../data/models/post_model.dart';
import '../data/repository/debato_repository.dart';

class DebateController extends GetxController {
  late GlobalKey<FormState> keyFormComentar;
  late TextEditingController ctrlInputComentario;

  Rx<PostModel?> post = Rx<PostModel?>(null);
  Rx<List<ComentarioModel>?> comentarios = Rx<List<ComentarioModel>?>(null);
  RxBool comentando = false.obs;
  RxString userID = "".obs;
  RxMap<int, bool> vozesAlters = RxMap<int, bool>({});

  @override
  void onInit() {
    super.onInit();
    keyFormComentar      = GlobalKey<FormState>();
    ctrlInputComentario  = TextEditingController();
    post.value           = Get.arguments?["post"];
    userID.value         = Get.arguments?["userID"];
    loadComentarios();
  }

  void voltar(){
    Get.back();
  }

  void loadComentarios() async{
    if(post.value == null) return;
    await Future.delayed(const Duration(seconds : 1));
    comentarios.value = await debatoRepository.listaComentarios(
      idUsuario: userID.value,
      idPost: post.value!.id
    );
  }

  void darVoz(ComentarioModel comentario) async{
    if(comentarios.value == null || comentarios.value!.isEmpty) return;
    comentario.deuVoz = !comentario.deuVoz;
    bool status = await debatoRepository.darVoz(
      idUsuario: userID.value,
      idPost: post.value!.id,
      idComentario: comentario.id,
      deuVoz: comentario.deuVoz
    );

    int indexC = comentarios.value!.indexOf(comentario);

    if(status){
      if(comentario.deuVoz){
        vozesAlters[indexC] = true;
      }else{
        vozesAlters[indexC] = false;
      }
    }
  }

  void onSubmitComentario() async{
    // fecha teclado aberto
    Get.focusScope?.unfocus();
    // valida o formulario
    if(keyFormComentar.currentState != null && keyFormComentar.currentState!.validate()){
      comentando.value = true;

      ComentouModel comentou = await debatoRepository.comentar(
        idPost: post.value!.id,
        txtPost: post.value!.texto,
        txtComentario: ctrlInputComentario.text
      );
      await Future.delayed(const Duration(seconds: 1));
      ctrlInputComentario.clear();

      if(!comentou.status){
        dialogPadrao(
          titulo: "Seu comentário foi recusado",
          texto: comentou.msg,
          txtConfirmar: "Fechar",
          onConfirm: ()=> Get.back()
        );
      }else{
        comentarios.value!.add(comentou.comentario!);
        comentarios.refresh();
      }

      comentando.value = false;
    }
  }

}