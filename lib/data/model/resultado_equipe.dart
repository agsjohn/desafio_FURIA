class ResultadoEquipe {
  final String evento;
  final String jogo;
  final String organizacao;
  final String equipe;
  final String lugar;
  final int? ganhos;
  final String data;

  ResultadoEquipe({
    required this.evento,
    required this.jogo,
    required this.organizacao,
    required this.equipe,
    required this.lugar,
    this.ganhos,
    required this.data,
  });

  factory ResultadoEquipe.fromJson(Map<String, dynamic> json) {
    return ResultadoEquipe(
      evento: json['Evento'],
      jogo: json['Jogo'],
      organizacao: json['Organização'],
      equipe: json['Equipe'],
      lugar: json['Lugar'],
      ganhos: json['Ganhos'],
      data: json['Data'],
    );
  }
}
