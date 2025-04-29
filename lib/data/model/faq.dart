class Faq {
  List<String> perguntas = [];
  List<String> respostas = [];

  Faq({required this.perguntas, required this.respostas});

  factory Faq.fromJson(Map<String, dynamic> json) {
    List<String> perguntas = [];
    List<String> respostas = [];

    json.forEach((key, value) {
      perguntas.add(key);
      respostas.add(value);
    });

    return Faq(perguntas: perguntas, respostas: respostas);
  }
}
