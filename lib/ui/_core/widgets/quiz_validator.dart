bool quizValidator(String entradaUsuario, String respostaCorreta) {
  final entradaNormalizada = entradaUsuario
      .trim()
      .toLowerCase()
      .replaceAll(')', '')
      .replaceAll(' ', '');
  final respostaNormalizada = respostaCorreta.trim().toLowerCase();

  return entradaNormalizada == respostaNormalizada;
}
