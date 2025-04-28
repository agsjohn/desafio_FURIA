class UltimosResultados {
  // String jogo;
  String time1;
  // String pais_time1;
  // String apelido_time1;
  int placar_time1;
  String time2;
  // String pais_time2;
  // String apelido_time2;
  int placar_time2;
  String evento;
  DateTime data_hora;

  UltimosResultados({
    // required this.jogo,
    required this.time1,
    // required this.pais_time1,
    // required this.apelido_time1,
    required this.placar_time1,
    required this.time2,
    // required this.pais_time2,
    // required this.apelido_time2,
    required this.placar_time2,
    required this.evento,
    required this.data_hora,
  });

  factory UltimosResultados.fromJson(Map<String, dynamic> json) {
    return UltimosResultados(
      // jogo: json['jogo'],
      time1: json['time1'],
      // pais_time1: json['pais_time1'],
      // apelido_time1: json['apelido_time1'],
      placar_time1: json['placar_time1'],
      time2: json['time2'],
      // pais_time2: json['pais_time2'],
      // apelido_time2: json['apelido_time2'],
      placar_time2: json['placar_time2'],
      evento: json['evento'],
      data_hora: DateTime.parse(json['data_hora']),
    );
  }
}
