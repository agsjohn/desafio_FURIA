import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/data/model/jogador.dart';
import 'package:my_app/data/model/resultado_equipe.dart';
import 'package:my_app/data/model/ultimos_jogos.dart';

class FuriaData extends ChangeNotifier {
  List<Jogador> listJogadores = [];
  List<UltimosJogos> listUltimosJogos = [];
  List<ResultadoEquipe> listResultadoEquipe = [];

  Future<void> getData() async {
    String jsonString = await rootBundle.loadString('assets/furia.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> jogadoresData = data['jogadores'];
    for (var jogadoresData in jogadoresData) {
      Jogador jogador = Jogador.fromJson(jogadoresData);
      listJogadores.add(jogador);
    }

    List<dynamic> ultimosResultadosData = data['ultimos_jogos'];
    for (var ultimosResultadosData in ultimosResultadosData) {
      UltimosJogos ultimosResultados = UltimosJogos.fromJson(
        ultimosResultadosData,
      );
      listUltimosJogos.add(ultimosResultados);
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

  String toStringUltimosJogos() {
    return "Segue a lista dos últimos ${listUltimosJogos.length} jogos da FURIA!\n\n${listUltimosJogos.map((listElement) => listElement.getUltimosJogos()).join("\n\n")}";
  }

  String toStringResultadosEquipe() {
    return "Segue a lista dos últimos ${listResultadoEquipe.length} resultados da equipe da FURIA!\n\n${listResultadoEquipe.map((listElement) => listElement.getResultadoEquipe()).join("\n\n")}";
  }

  List<String> getResultadosEquipeEventos() {
    return listResultadoEquipe.map((e) => e.evento).toList();
  }

  List<String> getUltimosJogosTimes() {
    List<String> lista1 = listUltimosJogos.map((e) => e.time1).toList();
    List<String> lista2 = listUltimosJogos.map((e) => e.time2).toList();
    return [...lista1, ...lista2];
  }

  List<String> getUltimosJogoEventos() {
    return listUltimosJogos.map((e) => e.evento).toList();
  }
}
