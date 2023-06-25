import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Future<bool> checkConnectivity() async{
  try {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none) return false;
    return true;
  } on PlatformException catch (e) {
    print(e.toString());
    return false;
  }
}

String dataAtualBR() {
  DateTime dataAtual = DateTime.now();
  DateFormat formatoData = DateFormat('dd/MM/yyyy');
  String dataFormatada = formatoData.format(dataAtual);
  return dataFormatada;
}

Color corGrau(double grau){
  Map<double, Color> mapGrauCores = {
    0.0 : const Color(0xffAC0D0D),
    0.2 : Colors.red,
    0.4 : Colors.orangeAccent,
    0.6 : Colors.green,
  };
  return lerpGradient(mapGrauCores.values.toList(), mapGrauCores.keys.toList(), grau);
}



Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}