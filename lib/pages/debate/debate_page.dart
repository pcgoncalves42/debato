import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../componentes/meu_card.dart';
import '../../controllers/debate_controller.dart';
import '../../data/models/comentario_model.dart';
import '../../uteis/theme.dart';
import '../../uteis/tools.dart';
import '../../uteis/validate.dart';

class DebatePage extends GetView<DebateController> {
  const DebatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            children: [
              GestureDetector(
                onTap: controller.voltar,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 7.0, bottom: 5.0, left: 10.0),
                      child: Icon(Icons.chevron_left, color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5),
                      child: Text("VOLTAR",
                        style: GoogleFonts.nunito(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontSize: 13.0
                        ),
                      ),
                    )
                  ],
                )
              ),
              Expanded(
                child: MeuCard(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  borderRadius: BorderRadius.circular(10.0),
                  shadowBlurRadius: 15.0,
                  child: Obx(() {
                    if(controller.post.value == null){
                      return const Center(child: CircularProgressIndicator(color: Colors.black54));
                    }
                    return ListView(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(controller.post.value!.texto,
                                      style: GoogleFonts.nunito(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w800,
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
                                    if(controller.post.value!.totalComentarios > 0) Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children:  [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.comment_outlined, color: Colors.black54),
                                        ),
                                        Text(controller.post.value!.totalComentarios.toString(),
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
                                      //showDuration: Duration(milliseconds: 1),
                                      preferredDirection: AxisDirection.right,
                                      content:  Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                        child: Text(controller.post.value!.explicacao,
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
                                          color: corGrau(controller.post.value!.grau),
                                          value: controller.post.value!.grau
                                        )
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              const Divider(color: Colors.black54),
                            ],
                          ),
                        ),

                        Obx(() {
                          if(controller.comentarios.value == null){
                            return Center(
                              child: Container(
                                width: 25.0,
                                height: 25.0,
                                margin: const EdgeInsets.only(top: 15.0),
                                child: const CircularProgressIndicator(color: Colors.black12)
                              )
                            );

                          }else if(controller.comentarios.value!.isEmpty){
                            return Center(
                              child: Text("Seja o primeiro a comentar",
                                style: GoogleFonts.nunito(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0
                                ),
                              ),
                            );
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for(ComentarioModel comentario in controller.comentarios.value!) Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                                child: Column(
                                  children: [
                                    /*Row(
                                      children: [
                                        Text("10/10/2020",
                                          style: GoogleFonts.nunito(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),*/
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(comentario.texto,
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
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: ()=> controller.darVoz(comentario),
                                              child: Obx((){
                                                bool deuVox = controller.vozesAlters[controller.comentarios.value!.indexOf(comentario)] ?? false;
                                                return Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children:  [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 4.0),
                                                      child: Icon(Icons.record_voice_over_rounded,
                                                          color: comentario.deuVoz || deuVox ? Colors.blueAccent : Colors.black54
                                                      ),
                                                    ),
                                                    Text((comentario.totalVoz + (deuVox ? 1 : 0)).toString(),
                                                      style: GoogleFonts.nunito(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.0
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                            ),
                                          ),
                                          const SizedBox(width: 15.0),
                                          JustTheTooltip(
                                            triggerMode: TooltipTriggerMode.tap,
                                            backgroundColor: Colors.black,
                                            elevation: 1.0,
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                            //showDuration: Duration(milliseconds: 1),
                                            preferredDirection: AxisDirection.right,
                                            content:  Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                              child: Text(comentario.explicacao,
                                                style: GoogleFonts.nunito(
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                            child: SizedBox(
                                              width: 15.0,
                                              height: 15.0,
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.black12,
                                                color: corGrau(comentario.grau),
                                                value: comentario.grau
                                              )
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    const Divider(color: Colors.black12),
                                  ],
                                )
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
              Obx((){
                if(controller.post.value == null){
                  return const SizedBox();
                }else if(controller.comentando.isTrue){
                  return Center(
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      margin: const EdgeInsets.all(15.0),
                      child: const CircularProgressIndicator(color: Colors.black12)
                    )
                  );
                }
                return MeuCard(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  borderRadius: BorderRadius.circular(10.0),
                  shadowBlurRadius: 15.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Form(
                    key: controller.keyFormComentar,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0, right: 4.0),
                              child: TextFormField(
                                controller: controller.ctrlInputComentario,
                                decoration: inputDecoration(
                                  hintText: "Comentar:",
                                ),
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                validator: (value)=> FormValidate.requiredMin(value, 10, null),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: controller.onSubmitComentario,
                            icon: const Icon(Icons.send)
                          )
                        ],
                      )
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}