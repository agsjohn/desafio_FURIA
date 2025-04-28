import 'package:flutter/material.dart';

List<TextSpan> buildTextSpans(String texto, List<String> palavrasNegrito) {
  List<TextSpan> spans = [];
  int start = 0;

  while (start < texto.length) {
    int? matchIndex;
    String? matchPalavra;

    for (var palavra in palavrasNegrito) {
      int index = texto.indexOf(palavra, start);
      if (index != -1 && (matchIndex == null || index < matchIndex)) {
        matchIndex = index;
        matchPalavra = palavra;
      }
    }

    if (matchIndex != null && matchPalavra != null) {
      if (matchIndex > start) {
        spans.add(
          TextSpan(
            text: texto.substring(start, matchIndex),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: matchPalavra,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      );

      start = matchIndex + matchPalavra.length;
    } else {
      spans.add(
        TextSpan(
          text: texto.substring(start),
          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        ),
      );
      break;
    }
  }

  return spans;
}
