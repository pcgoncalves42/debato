class ComentarioModel {
  String id;
  String data;
  //String nome;
  String texto;
  int totalVoz;
  double grau;
  String explicacao;
  bool deuVoz;

  ComentarioModel({
    required this.id,
    required this.data,
    //required this.nome,
    required this.texto,
    required this.totalVoz,
    required this.grau,
    required this.explicacao,
    required this.deuVoz
  });

  factory ComentarioModel.fromJson(Map<String, dynamic> json) => ComentarioModel(
      id: json['id'] ?? "",
      data: json['data'] ?? "",
      //nome: json['nome'] ?? "",
      texto: json['texto'] ?? "",
      totalVoz: json['totalVoz'] ?? "",
      grau: json['grau'] ?? "",
      explicacao: json['explicacao'] ?? "",
      deuVoz: json['deuVoz'] ?? ""
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    //'nome': nome,
    'texto': texto,
    'totalVoz': totalVoz,
    'grau': grau,
    'explicacao': explicacao,
    'deuVoz': deuVoz
  };
}

class ComentouModel{
  bool status;
  String msg;
  ComentarioModel? comentario;

  ComentouModel({
    required this.status,
    this.msg = "",
    this.comentario
  });
}