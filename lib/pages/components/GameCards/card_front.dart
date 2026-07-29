import 'package:flutter/material.dart';
import 'package:memory_game_pokemon/models/game_card.dart';

Widget cardFront(GameCard card) {
  return Container(
    key: ValueKey(card.value),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Image.asset(card.urlImagem, width: 56)
    ),
  );
}
