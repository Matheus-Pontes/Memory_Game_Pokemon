enum NivelPokemon {
  pichu,
  pikachu,
  raichu,
}

extension NivelPokemonValue on NivelPokemon {
  int get value {
    switch (this) {
      case NivelPokemon.pichu:
        return 0;
      case NivelPokemon.pikachu:
        return 1;
      case NivelPokemon.raichu:
        return 2;
    }
  }
}