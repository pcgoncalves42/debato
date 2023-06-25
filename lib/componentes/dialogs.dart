import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void snackBarError(String mensagem) {
  Get.showSnackbar(GetSnackBar(
    padding: const EdgeInsets.all(30),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    message: mensagem,
    duration: const Duration(seconds: 5),
  ));
}

void snackBarWarn(String mensagem) {
  Get.showSnackbar(GetSnackBar(
    padding: const EdgeInsets.all(30),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.orange,
    message: mensagem,
    duration: const Duration(seconds: 5),
  ));
}

void snackBarSucess(String mensagem) {
  Get.showSnackbar(GetSnackBar(
    padding: const EdgeInsets.all(30),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green[400]!,
    message: mensagem,
    duration: const Duration(seconds: 5),
  ));
}
void dialogPadrao({
  Widget? child,
  Widget? singleChildScrollView,
  String? titulo,
  String? texto,
  String? txtCancelar,
  String? txtConfirmar,
  String? txtConfirmarGrave,
  IconData? iconCancelar,
  IconData? iconConfirmar,
  IconData? iconConfirmarGrave,
  VoidCallback? onCancel,
  VoidCallback? onConfirm,
  VoidCallback? onConfirmGrave,
  Color? background,
  Color? backgroundCancel,
  Color? backgroundConfirm,
  Color? backgroundConfirmGrave,
  Color? colorTextConfirm,
  EdgeInsets? paddingButtons,
  bool barrierDismissible = true,
  bool actionsReverse = false,
  bool inColumn = false,
  bool actionSoIcons = false,
}){

  Widget botaoCancelar        = const SizedBox();
  Widget botaoConfirmar       = const SizedBox();
  Widget botaoConfirmarGrave  = const SizedBox();

  ElevatedButton elevatedButtonCancelar = ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: backgroundCancel ?? Colors.grey,
          padding: paddingButtons ?? const EdgeInsets.symmetric(vertical: 8.0)
      ),
      onPressed: onCancel,
      child: iconCancelar != null ? Icon(iconCancelar) : Text(txtCancelar ?? 'Cancelar',
          style: GoogleFonts.nunito(
              fontSize: 15.0,
              color: Colors.white
          )
      )
  );

  ElevatedButton elevatedButtonConfirmar = ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: backgroundConfirm ?? Colors.black,
        padding: paddingButtons ?? const EdgeInsets.symmetric(vertical: 8.0)
    ),
    onPressed: onConfirm,
    child: iconConfirmar != null ? Icon(iconConfirmar) : Text(txtConfirmar ?? 'Confirmar',
        style: GoogleFonts.nunito(
            fontSize: 15.0,
          color: colorTextConfirm ?? Colors.white
        )
    ),
  );

  ElevatedButton elevatedButtonConfirmarGrave = ElevatedButton(
    style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: backgroundConfirmGrave ?? Colors.red,
        padding: paddingButtons ?? const EdgeInsets.symmetric(vertical: 8.0)
    ),
    onPressed: onConfirmGrave,
    child: iconConfirmarGrave != null ? Icon(iconConfirmarGrave) : Text(txtConfirmarGrave ?? 'Confirmar!',
      style: GoogleFonts.nunito(
          fontSize: 15.0
      ),
      textAlign: TextAlign.center,
    ),
  );


  IconButton iconButtonCancelar = IconButton(
      onPressed: onCancel,
      icon: Icon(iconCancelar, color: Colors.grey)
  );

  IconButton iconButtonConfirmar = IconButton(
      onPressed: onConfirm,
      icon: Icon(iconConfirmar, color: Colors.orange)
  );

  IconButton iconButtonConfirmarGrave = IconButton(
      onPressed: onConfirmGrave,
      icon: Icon(iconConfirmarGrave, color: Colors.redAccent)
  );


  botaoCancelar       = actionSoIcons ? iconButtonCancelar       : elevatedButtonCancelar;
  botaoConfirmar      = actionSoIcons ? iconButtonConfirmar      : elevatedButtonConfirmar;
  botaoConfirmarGrave = actionSoIcons ? iconButtonConfirmarGrave : elevatedButtonConfirmarGrave;

  Get.dialog(WillPopScope(
    onWillPop: barrierDismissible ? null : () async{ return false; },
    child: AlertDialog(
        title: const Text("", textAlign: TextAlign.center, style: TextStyle(fontSize: 0.1)),
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0, bottom: 10.0),
        buttonPadding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
        backgroundColor: background ?? Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: singleChildScrollView != null ? SingleChildScrollView(
          child: singleChildScrollView,
        ) : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(titulo != null) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(titulo,
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18.0
                        )
                    ),
                  ),
                ),
              ],
            ),
            if(titulo != null && child != null) const SizedBox(height: 10.0),
            if(texto != null) Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(texto,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            if(child != null) child
          ],
        ),
        actions: [
          if(onCancel != null || onConfirm != null || onConfirmGrave != null) SizedBox(
            width: double.maxFinite,
            child: inColumn ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(onCancel != null)       Row(children: [ Expanded(child: botaoCancelar) ]),
                if(onCancel != null && (onConfirm != null || onConfirmGrave != null)) const SizedBox(height: 5.0),
                if(onConfirm != null)      Row(children: [ Expanded(child: botaoConfirmar) ]),
                if(onConfirm != null && onConfirmGrave != null) const SizedBox(height: 5.0),
                if(onConfirmGrave != null) Row(children: [ Expanded(child: botaoConfirmarGrave) ]),
              ],
            ) : Row(
              textDirection: actionsReverse ? TextDirection.rtl : TextDirection.ltr,
              children: [
                if(onCancel != null)        Expanded(child: botaoCancelar),
                if(onCancel != null && (onConfirm != null || onConfirmGrave != null)) const SizedBox(width: 10.0),
                if(onConfirm != null)       Expanded(child: botaoConfirmar),
                if(onConfirm != null && onConfirmGrave != null) const SizedBox(width: 10.0),
                if(onConfirmGrave != null)  Expanded(child: botaoConfirmarGrave),
              ],
            ),
          ),
        ]
    ),
  ), barrierDismissible: barrierDismissible);
}

