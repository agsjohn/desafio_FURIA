class Jogador {
  final String pais;
  final String nome;
  final String? funcao;
  final String nome_completo;
  final DateTime data_entrada;

  Jogador({
    required this.pais,
    required this.nome,
    this.funcao,
    required this.nome_completo,
    required this.data_entrada,
  });

  factory Jogador.fromJson(Map<String, dynamic> json) {
    return Jogador(
      pais: json['pais'],
      nome: json['nome'],
      funcao: json['funcao'],
      nome_completo: json['nome_completo'],
      data_entrada: DateTime.parse(json['data_entrada']),
    );
  }

  String getJogador() {
    String day = "${data_entrada.day}";
    String month = "${data_entrada.month}";

    if (data_entrada.day < 10) {
      day = "0${data_entrada.day}";
    }
    if (data_entrada.month < 10) {
      month = "0${data_entrada.month}";
    }

    if (funcao == null) {
      return "Nick: $nome\nPaís: $pais\nFunção: Jogador\nNome completo: $nome_completo\nData de entrada: $day/$month/${data_entrada.year}";
    } else {
      return "Nick: $nome\nPaís: $pais\nFunção: $funcao\nNome completo: $nome_completo\nData de entrada: $day/$month/${data_entrada.year}";
    }
  }
}
