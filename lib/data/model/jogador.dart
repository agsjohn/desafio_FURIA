class Jogador {
  final String pais;
  final String nome;
  final String? funcao;
  final String nome_completo;
  final String data_entrada;

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
      data_entrada: json['data_entrada'],
    );
  }

  String getJogador() {
    if (funcao == null) {
      return "Nick: $nome\nPaís: $pais\nNome completo: $nome_completo\nData de entrada: $data_entrada";
    } else {
      return "Nick: $nome\nPaís: $pais\nFunção: $funcao\nNome completo: $nome_completo\nData de entrada: $data_entrada";
    }
  }
}
