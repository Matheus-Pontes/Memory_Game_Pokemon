class GameCard {
  final int value;
  bool isFlipped;
  bool isMatched;
  String name;
  String urlImagem;

  GameCard({
    required this.value,
    this.isFlipped = false,
    this.isMatched = false,
    this.name = '',
    this.urlImagem = ''
  });
}
