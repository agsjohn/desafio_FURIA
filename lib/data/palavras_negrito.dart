class PalavrasNegrito {
  List<String> maisPalavras;

  PalavrasNegrito({required List<String>? maisPalavras})
    : maisPalavras = [...palavrasNegrito, ...(maisPalavras ?? [])];

  void addPalavras(List<String> lista) {
    maisPalavras = [...maisPalavras, ...lista];
  }
}

List<String> palavrasNegrito = [
  'FURIA!',
  'Data de entrada',
  'Nome completo',
  'Nick',
  'País',
  'Função',
  'Posição',
  'Sem ganhos',
  'Ganhos',
  'Data do evento',
];

List<String> placarNegrito = ["0 x 2", "1 x 2", "2 x 0", "2 x 1"];

List<String> numerosNegrito = [
  "1. ",
  "2. ",
  "3. ",
  "4. ",
  "5. ",
  "6. ",
  "7. ",
  "8. ",
  "9. ",
  "10. ",
  "BONUS. ",
];
