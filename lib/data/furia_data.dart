import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/data/model/jogador.dart';
import 'package:my_app/data/model/resultado_equipe.dart';
import 'package:my_app/data/model/ultimos_resultados.dart';

class FuriaData extends ChangeNotifier {
  List<Jogador> listJogadores = [];
  List<UltimosResultados> listUltimosResultados = [];
  List<ResultadoEquipe> listResultadoEquipe = [];

  Future<void> getData() async {
    String jsonString = await rootBundle.loadString('assets/furia.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> jogadoresData = data['jogadores'];
    for (var jogadoresData in jogadoresData) {
      Jogador jogador = Jogador.fromJson(jogadoresData);
      listJogadores.add(jogador);
    }

    List<dynamic> ultimosResultadosData = data['ultimos_resultados'];
    for (var ultimosResultadosData in ultimosResultadosData) {
      UltimosResultados ultimosResultados = UltimosResultados.fromJson(
        ultimosResultadosData,
      );
      listUltimosResultados.add(ultimosResultados);
    }

    List<dynamic> resultadosEquipeData = data['resultados_da_equipe'];
    for (var resultadosEquipeData in resultadosEquipeData) {
      ResultadoEquipe resultadoEquipe = ResultadoEquipe.fromJson(
        resultadosEquipeData,
      );
      listResultadoEquipe.add(resultadoEquipe);
    }
  }

  String toStringListJogadores() {
    return "Segue a lista da comp atual da FURIA!\n\n${listJogadores.map((listElement) => listElement.getJogador()).join("\n\n")}";
  }
}
