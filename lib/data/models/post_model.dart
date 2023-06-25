class PostModel {
  String id;
  String data;
  //String nome;
  String texto;
  int totalComentarios;
  double grau;
  String explicacao;

  PostModel({
    required this.id,
    required this.data,
    //required this.nome,
    required this.texto,
    required this.totalComentarios,
    required this.grau,
    required this.explicacao
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] ?? "",
      data: json['data'] ?? "",
      //nome: json['nome'] ?? "",
      texto: json['texto'] ?? "",
      totalComentarios: json['totalComentarios'] ?? "",
      grau: json['grau'] ?? "",
      explicacao: json['explicacao'] ?? ""
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    //'nome': nome,
    'texto': texto,
    'totalComentarios': totalComentarios,
    'grau': grau,
    'explicacao': explicacao
  };
}

class PostouModel{
  bool status;
  String msg;
  PostModel? post;

  PostouModel({
    required this.status,
    this.msg = "",
    this.post
  });
}
