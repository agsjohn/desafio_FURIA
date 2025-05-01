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
  'Jogador',
  'Função',
  'Posição',
  'Sem ganhos',
  'Ganhos',
  'Data do evento',
];

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
