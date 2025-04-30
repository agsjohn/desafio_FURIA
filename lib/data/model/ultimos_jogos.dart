class UltimosJogos {
  String time1;
  int placarTime1;
  String time2;
  int placarTime2;
  String evento;
  DateTime dataHora;

  UltimosJogos({
    required this.time1,
    required this.placarTime1,
    required this.time2,
    required this.placarTime2,
    required this.evento,
    required this.dataHora,
  });

  factory UltimosJogos.fromJson(Map<String, dynamic> json) {
    return UltimosJogos(
      time1: json['time1'],
      placarTime1: json['placar_time1'],
      time2: json['time2'],
      placarTime2: json['placar_time2'],
      evento: json['evento'],
      dataHora: DateTime.parse(json['data_hora']),
    );
  }

  String getUltimosJogos() {
    String day = "${dataHora.day}";
    String month = "${dataHora.month}";
    String hour = "${dataHora.hour}";
    String minute = "${dataHora.minute}";

    if (dataHora.day < 10) {
      day = "0${dataHora.day}";
    }
    if (dataHora.month < 10) {
      month = "0${dataHora.month}";
    }
    if (dataHora.hour < 10) {
      hour = "0${dataHora.hour}";
    }
    if (dataHora.minute < 10) {
      minute = "0${dataHora.minute}";
    }

    return "$time1 $placarTime1 x $placarTime2 $time2\n$evento \n$day/$month/${dataHora.year} $hour:$minute";
  }
}
