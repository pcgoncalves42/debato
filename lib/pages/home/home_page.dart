import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../componentes/meu_card.dart';
import '../../controllers/home_controller.dart';
import '../../data/models/post_model.dart';
import '../../uteis/theme.dart';
import '../../uteis/tools.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
        title: Text("DEBATO",
          style: GoogleFonts.nunitoSans(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.w800
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.listarPosts,
            icon: const Icon(Icons.refresh, color: Colors.black54)
          )
        ],
      ),
      body: Obx((){
        if(controller.posts.value == null){
          return const Center(child: CircularProgressIndicator(color: Colors.black54));

        }else if(controller.posts.value!.isEmpty){
          return Center(
            child: Text("Seja o primeiro a postar",
              style: GoogleFonts.nunito(
                color: Colors.black54,
                fontWeight: FontWeight.w300,
                fontSize: 16.0
              ),
            ),
          );
        }

        return ListView(
          children: <Widget>[
            for(PostModel post in controller.posts.value!) GestureDetector(
              onTap: ()=> controller.openDebate(post),
              child: MeuCard(
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
                borderRadius: BorderRadius.circular(10.0),
                shadowBlurRadius: 15.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(post.texto,
                            style: GoogleFonts.nunito(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0
                            ),
                          )
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if(post.totalComentarios > 0) Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              const Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.comment_outlined, color: Colors.black54),
                              ),
                              Text(post.totalComentarios.toString(),
                                style: GoogleFonts.nunito(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 15.0,),
                          JustTheTooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            backgroundColor: Colors.black,
                            elevation: 1.0,
                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                            preferredDirection: AxisDirection.right,
                            content:  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                              child: Text(post.explicacao,
                                style: GoogleFonts.nunito(
                                    color: Colors.white
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.black12,
                                color: corGrau(post.grau),
                                value: post.grau
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: controller.irPostar,
        tooltip: 'Adicionar Gasto',
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}