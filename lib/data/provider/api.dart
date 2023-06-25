import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token.dart';

final ChatApi chatApi = ChatApi._private();

class ChatApi {
  ChatApi._private();

  Future<Map<String, dynamic>> _request(String mensagem) async {
    try{

      Map<String, dynamic> body = {
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "system", "content": mensagem}],
        "temperature": 1.0,
        "max_tokens": 3000,
      };

      var response = await http.post(Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          'Authorization': 'Bearer $apiKeyToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body)
      );

      if (response.statusCode == 200){
        Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return jsonDecode(data["choices"][0]["message"]["content"])[0];
      }

    }catch(e){
      throw Exception('Erro ao enviar a mensagem para o Chat GPT. $e');
    }

    throw Exception('Erro ao enviar a mensagem para o Chat GPT.');
  }

  Future<Map<String, dynamic>> validarPost(String post) async{
    String mensagem = 'O texto é: "$post"'
    'Me responda com [{"permitido":false, "grau-argumentativo": 0.0, "explicacao": "detalhes"}]'
    'Onde "permitido" é true caso o  texto seja dissertativo.'
    'E "grau-argumentativo" é um indicativo entre 0.0 e 1.0'
    'Para calcular o grau argumentativo deve considerar todos os itens abaixo:'
    '- o contexto'
    '- conteúdo e objetivo do texto'
    '- lógica interna'
    '- suporte factual'
    '- estrutura de argumentação do texto.'
    'E "explicacao" é um texto curto onde justifica a nota que aplicou';
    return await _request(mensagem);
  }

  Future<Map<String, dynamic>> validarComentario({required String post, required String comentario}) async{
    String mensagem = 'O contexto é: "$post"'
    'O comentário é: "$comentario"'
    'Me responda com [{"permitido":false, "grau-argumentativo": 0.0, "explicacao": "detalhes"}]'
    'Onde "permitido" é true caso o comentário seja dissertativo e relacionado ao contexto.'
    'E "grau-argumentativo" é um indicativo entre 0.0 e 1.0'
    'Para calcular o grau argumentativo deve considerar todos os itens abaixo:'
    '- o contexto'
    '- conteúdo e objetivo do comentário'
    '- lógica interna'
    '- suporte factual'
    '- estrutura de argumentação do comentário.'
    'E "explicacao" é um texto curto onde justifica a nota que aplicou';
    return await _request(mensagem);
  }

}