import 'package:memory_game_pokemon/enums/nivel_pokemon.dart';
import 'package:memory_game_pokemon/models/game_card.dart';

class GameService {

  List<GameCard> getPokemonData(int pares) {
    List<GameCard> listaPokemons = [];

    for (int i=1; i <= pares; i++) {
      listaPokemons.add(
        GameCard(
          value: i, 
          name:  i.toString(), 
          urlImagem: 'assets/images/$i.png', 
          isFlipped: true
        )
      );
    }

    var listaPokemons1 = shuffleCards(listaPokemons);
    var listaPokemons2 = shuffleCards(listaPokemons);

    return [...listaPokemons1, ...listaPokemons2];    
  }

  List<GameCard> shuffleCards(List<GameCard> cards) {

    var cardsShuflled = cards..shuffle();
    
    return cardsShuflled.map((v) => GameCard(value: v.value, urlImagem: v.urlImagem, name: v.name, isFlipped: v.isFlipped)).toList();

  }

  List<GameCard> flippedCards(List<GameCard> cards) {
    return cards.map((v) => GameCard(value: v.value, urlImagem: v.urlImagem, name: v.name, isFlipped: false)).toList();
  }

  String nivelGame(int nivel) {
    var labelNivelGame = "";

    if (nivel == NivelPokemon.pichu.value) {
      labelNivelGame = "pichu";
    }

    if (nivel == NivelPokemon.pikachu.value) {
      labelNivelGame = "pikachu";
    }

    if (nivel == NivelPokemon.raichu.value) {
      labelNivelGame = "raichu";
    }

    return labelNivelGame;
  }
}

