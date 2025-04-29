class UltimosJogos {
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

  UltimosJogos({
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

  factory UltimosJogos.fromJson(Map<String, dynamic> json) {
    return UltimosJogos(
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

  String getUltimosJogos() {
    String day = "${data_hora.day}";
    String month = "${data_hora.month}";
    String hour = "${data_hora.hour}";
    String minute = "${data_hora.minute}";

    if (data_hora.day < 10) {
      day = "0${data_hora.day}";
    }
    if (data_hora.month < 10) {
      month = "0${data_hora.month}";
    }
    if (data_hora.hour < 10) {
      hour = "0${data_hora.hour}";
    }
    if (data_hora.minute < 10) {
      minute = "0${data_hora.minute}";
    }

    return "$time1 $placar_time1 x $placar_time2 $time2\n$evento \n$day/$month/${data_hora.year} $hour:$minute";
  }
}
