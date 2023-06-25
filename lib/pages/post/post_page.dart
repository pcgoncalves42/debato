import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../componentes/meu_card.dart';
import '../../controllers/postar_controller.dart';
import '../../uteis/theme.dart';
import '../../uteis/validate.dart';

class PostarPage extends GetView<PostarController> {
  const PostarPage({Key? key}) : super(key: key);

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
                child: Form(
                  key: controller.keyFormPostar,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: MeuCard(
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    borderRadius: BorderRadius.circular(10.0),
                    shadowBlurRadius: 15.0,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.ctrlInputPost,
                            keyboardType: TextInputType.multiline,
                            decoration: inputDecoration(
                              hintText: "...",
                            ),
                            maxLines: 800,
                            validator: (value)=> FormValidate.requiredMin(value, 10, null),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),

              Obx((){
                if(controller.postando.isTrue){
                  return Center(
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      margin: const EdgeInsets.all(15.0),
                      child: const CircularProgressIndicator(color: Colors.black)
                    )
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black
                    ),
                    onPressed: controller.onSubmitPost,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("POSTAR",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.send),
                        ),
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