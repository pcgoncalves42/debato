import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../componentes/dialogs.dart';
import '../data/models/post_model.dart';
import '../data/repository/debato_repository.dart';
import 'home_controller.dart';

class PostarController extends GetxController {
  late GlobalKey<FormState> keyFormPostar;
  late TextEditingController ctrlInputPost;

  RxBool postando = false.obs;

  @override
  void onInit() {
    super.onInit();
    keyFormPostar     = GlobalKey<FormState>();
    ctrlInputPost     = TextEditingController();
  }

  void voltar(){
    Get.back();
  }

  void onSubmitPost() async{
    // fecha teclado aberto
    Get.focusScope?.unfocus();
    // valida o formulario
    if(keyFormPostar.currentState != null && keyFormPostar.currentState!.validate()){
      postando.value = true;

      PostouModel postou = await debatoRepository.postar(texto: ctrlInputPost.text);
      await Future.delayed(const Duration(seconds: 1));
      ctrlInputPost.clear();

      if(!postou.status){
        dialogPadrao(
          titulo: "Seu post foi recusado",
          texto: postou.msg,
          txtConfirmar: "Fechar",
          onConfirm: ()=> Get.back()
        );
      }else{
        Get.find<HomeController>().listarPosts();
        Get.back(result: postou.post);
        //snackBarSucess("Seu post foi enviado.");
      }
      postando.value = false;
    }
  }

}