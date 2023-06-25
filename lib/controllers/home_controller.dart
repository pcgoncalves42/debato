import 'package:debato/componentes/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../data/models/post_model.dart';
import '../data/repository/debato_repository.dart';

class HomeController extends GetxController {

  Rx<User?> usuario = Rx<User?>(null);
  Rx<List<PostModel>?> posts = Rx<List<PostModel>?>(null);

  @override
  void onInit() {
    super.onInit();
    loginFirebaseAnonimo();
  }

  void openDebate(PostModel post){
    Get.toNamed("/debate", arguments: {"post": post, "userID": usuario.value!.uid});
  }

  void irPostar() async{
    dynamic novoPost = await Get.toNamed("/postar");
    if(novoPost == PostModel){
      posts.value!.add(novoPost);
      posts.refresh();
    }
  }

  void dialogErroLogin(String erro){
    dialogPadrao(
      titulo: "Erro ao efetuar login",
      texto: erro,
      barrierDismissible: false,
      txtConfirmar: "Tentar novamente",
      onConfirm: (){
        Get.back();
        loginFirebaseAnonimo();
      },
    );
  }

  Future<void> loginFirebaseAnonimo() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      usuario.value = userCredential.user;
      if(usuario.value == null){
        throw Exception("Esse é um aplicativo protótipo, erros acontecem.");
      }
      listarPosts();
    } catch (e) {
      dialogErroLogin(e.toString());
    }
  }


  void listarPosts() async{
    posts.value = null;
    await Future.delayed(const Duration(seconds: 1));
    posts.value = await debatoRepository.listarPosts();
  }



}