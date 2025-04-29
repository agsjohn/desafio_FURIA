class ResultadoEquipe {
  final String evento;
  final String jogo;
  final String organizacao;
  final String equipe;
  final String lugar;
  final int? ganhos;
  final String dataInicial;
  final String dataFinal;

  ResultadoEquipe({
    required this.evento,
    required this.jogo,
    required this.organizacao,
    required this.equipe,
    required this.lugar,
    this.ganhos,
    required this.dataInicial,
    required this.dataFinal,
  });

  factory ResultadoEquipe.fromJson(Map<String, dynamic> json) {
    return ResultadoEquipe(
      evento: json['Evento'],
      jogo: json['Jogo'],
      organizacao: json['Organização'],
      equipe: json['Equipe'],
      lugar: json['Lugar'],
      ganhos: json['Ganhos'],
      dataInicial: json['Data inicial'],
      dataFinal: json['Data final'],
    );
  }

  String getResultadoEquipe() {
    if (ganhos != null) {
      return "$evento\nPosição: $lugar lugar\nGanhos: \$$ganhos\nData do evento:\n$dataInicial - $dataFinal";
    } else {
      return "$evento\nPosição: $lugar lugar\nSem ganhos\nData do evento:\n$dataInicial - $dataFinal";
    }
  }
}
