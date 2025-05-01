class Quiz {
  String pergunta;
  List<dynamic>? alternativas;
  String? resposta;

  Quiz({required this.pergunta, this.alternativas, this.resposta});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      pergunta: json['pergunta'],
      alternativas: json['alternativas'],
      resposta: json['resposta'],
    );
  }

  String getPergunta() {
    return "$pergunta\n${alternativas?.map((e) => e).join('\n')}\n\nS - Sair do quiz";
  }
}
