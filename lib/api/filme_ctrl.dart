import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_filme.dart';

import 'package:myapp/model/filme.dart';

class FilmeCtrl {
  static Future<List<Filme>?> suchenAlle() async {
    print('suchenAlle');
    print("URL da API: ${ApiFilme.url}/movies");

    try {
      var requestData = await http.get(Uri.parse("${ApiFilme.url}/movies"),
          headers: ApiFilme.headers);
      print('Resposta do servidor: ${requestData.body}');
      print(requestData.body);
      var jDecode = jsonDecode(requestData.body)["movies"];

      List<Filme> movies = [];

      for (var map in jDecode) {
        movies.add(Filme.fromMap(map));
      }
      return movies;
    } catch (satan) {
      print('Erro no suchen filmectrl: $satan');
      return null;
    }
  }
}
