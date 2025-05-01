import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/data/model/faq.dart';
import 'package:my_app/data/model/jogador.dart';
import 'package:my_app/data/model/quiz.dart';
import 'package:my_app/data/model/resultado_equipe.dart';
import 'package:my_app/data/model/ultimos_jogos.dart';

class FuriaData extends ChangeNotifier {
  List<Jogador> listJogadores = [];
  List<UltimosJogos> listUltimosJogos = [];
  List<ResultadoEquipe> listResultadoEquipe = [];
  List<Faq> listFaq = [];
  List<Quiz> listQuiz = [];

  Future<void> getData() async {
    String jsonString = await rootBundle.loadString('assets/furia.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> jogadoresData = data['jogadores'];
    for (var jogadorData in jogadoresData) {
      Jogador jogador = Jogador.fromJson(jogadorData);
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

    listFaq = (data['faq'] as List).map((item) => Faq.fromJson(item)).toList();

    List<dynamic> quizData = data['quiz'];
    for (var x in quizData) {
      Quiz quiz = Quiz.fromJson(x);
      listQuiz.add(quiz);
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

  String toStringFaqInicial() {
    return "O que gostaria de perguntar/saber? \n\n${listFaq[0].perguntas.join("\n")}\n8. Sair";
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
