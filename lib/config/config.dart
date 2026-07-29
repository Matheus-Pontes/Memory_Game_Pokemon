class Config {
  //   // No emulador Android, "localhost" é 10.0.2.2
  //   // Se for no celular real, use o IP da sua máquina (ex: 192.168.1.XX)
  //   static const String baseUrlBackend = 'http://10.0.2.2:3000'; 
  final String baseUrlPokemon = 'https://pokeapi.co/api/v2';

  final Map<int, Map<String,int>> niveisConfiguracao = {
    0: {
      'Colunas': 3,
      'Pares': 6
    },
    1: {
      'Colunas': 4,
      'Pares': 10
    },
    2: {
      'Colunas': 4,
      'Pares': 12
    }
  }; 

}