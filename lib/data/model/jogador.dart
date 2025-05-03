class Jogador {
  final String pais;
  final String nome;
  final String? funcao;
  final String nomeCompleto;
  final DateTime dataEntrada;

  Jogador({
    required this.pais,
    required this.nome,
    this.funcao,
    required this.nomeCompleto,
    required this.dataEntrada,
  });

  factory Jogador.fromJson(Map<String, dynamic> json) {
    return Jogador(
      pais: json['pais'],
      nome: json['nome'],
      funcao: json['funcao'],
      nomeCompleto: json['nome_completo'],
      dataEntrada: DateTime.parse(json['data_entrada']),
    );
  }

  String getJogador() {
    String day = "${dataEntrada.day}";
    String month = "${dataEntrada.month}";

    if (dataEntrada.day < 10) {
      day = "0${dataEntrada.day}";
    }
    if (dataEntrada.month < 10) {
      month = "0${dataEntrada.month}";
    }

    if (funcao == null) {
      return "🏷️ Nick: $nome\n🗺️ País: $pais\n📍 Função: Jogador\n🪪 Nome completo: $nomeCompleto\n📅 Data de entrada: $day/$month/${dataEntrada.year}";
    } else {
      return "🏷️ Nick: $nome\n🗺️ País: $pais\n📍 Função: $funcao\n🪪 Nome completo: $nomeCompleto\n📅 Data de entrada: $day/$month/${dataEntrada.year}";
    }
  }
}
