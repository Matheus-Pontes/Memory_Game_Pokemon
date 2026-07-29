import 'dart:async';

import 'package:flutter/material.dart';
import 'package:memory_game_pokemon/config/config.dart';
import 'package:memory_game_pokemon/models/game_card.dart';
import 'package:memory_game_pokemon/models/user.dart';
import 'package:memory_game_pokemon/models/user_record.dart';
import 'package:memory_game_pokemon/pages/components/GameCards/card_back.dart';
import 'package:memory_game_pokemon/pages/components/GameCards/card_front.dart';
import 'package:memory_game_pokemon/pages/components/GameCards/glass_container.dart';
import 'package:memory_game_pokemon/pages/components/base_layout.page.dart';
import 'package:memory_game_pokemon/pages/components/game_lose_modal.page.dart';
import 'package:memory_game_pokemon/pages/components/game_winner_modal.page.dart';
import 'package:memory_game_pokemon/pages/login.page.dart';
import 'dart:math';

import 'package:memory_game_pokemon/services/songs_service.dart';
import 'package:memory_game_pokemon/services/game_service.dart';
import 'package:memory_game_pokemon/models/user_view_model.dart';
import 'package:memory_game_pokemon/services/user_service.dart';


class GamePage extends StatefulWidget {
  final UserViewModel user;

  const GamePage({super.key, required this.user});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late List<GameCard> cards = [];
  GameCard? firstCard;
  bool lockBoard = false;
  int colunas = 0;
  final Config _configuracoes = Config();
  final GameService _gameService = GameService();
  final UserService _userService = UserService();
  Timer? _timer;
  int _timerGameSeconds = 60;
  String labelNivel = "";

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }


  void _initGame() async {
    int pares = _configuracoes.niveisConfiguracao[widget.user.level]?['Pares'] ?? 0;
    colunas = _configuracoes.niveisConfiguracao[widget.user.level]?['Colunas'] ?? 0;
    
    SongsService().playAudioGameBoard();
    
    labelNivel = _gameService.nivelGame(widget.user.level);

    loadCards(pares);
  }

  Future<void> loadCards(int pares) async {
    cards = _gameService.getPokemonData(pares);
    
    await Future.delayed(const Duration(seconds: 3));

    cards = _gameService.flippedCards(cards);

    iniciarContagem();
  }

  void iniciarContagem() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (_timerGameSeconds > 0) {
        setState(() {
          _timerGameSeconds--;
        });
      } else {
        timer.cancel();

        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.8),
          builder: (_) => GameLoseModal(user: widget.user)      
        );
      }
    });
  }

  void _onCardTap(GameCard card) {
    if (lockBoard || card.isFlipped || card.isMatched) return;

    setState(() {
      card.isFlipped = true;
    });

    if (firstCard == null) {
      firstCard = card;
      return;
    }

    lockBoard = true;

    if (firstCard!.value == card.value) {
      // ✅ MATCH
      setState(() {
        firstCard!.isMatched = true;
        card.isMatched = true;
      });
      _resetTurn();

      _verifyWinTheGame();
      
    } else {
      // ❌ NÃO MATCH
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          firstCard!.isFlipped = false;
          card.isFlipped = false;
        });
        _resetTurn();
      });
    }
  }

  Future<void> _verifyWinTheGame() async {

    if (cards.every((card) => card.isMatched)) {

      _timer?.cancel();

      var tempoRestante = 60 - _timerGameSeconds;
      
      // Atualizar dados do usuário
      User usuario = User(
        userId: widget.user.userId,
        name: widget.user.name,
        userRecord: UserRecord(
            userId: widget.user.userId,
            timeRecord: tempoRestante, 
            levelGame: widget.user.level
          )
      );
      
      bool success = await _userService.atualizarUsuario(usuario);

      if (success) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.8),
          builder: (_) => GameWinnerModal(
            user: widget.user, 
            tempoRestante: tempoRestante, 
          )
        );
      }
    }
  }

  void _resetTurn() {
    firstCard = null;
    lockBoard = false;
  }
 
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      child: SafeArea(
        child: 
        Padding(padding: EdgeInsetsGeometry.all(24),
          child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: .spaceBetween,
              spacing: 48,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                        pageBuilder: (_, __, ___) => LoginPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_rounded, size: 24),
                  label: const Text('Sair'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4B4B), // vermelho
                    foregroundColor: Colors.white, // texto e ícone brancos
                    elevation: 6, // sombra leve
                    shadowColor: const Color.fromRGBO(255, 75, 75, 0.3), // sombra avermelhada
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Text('Tempo: ${_timerGameSeconds}s', 
                  style: TextStyle(
                    color: Colors.white, 
                    shadows: [
                      Shadow(
                        offset: Offset(0, 2), // deslocamento (x, y)
                        blurRadius: 4,        // desfoque
                        color: Colors.black38,
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 48),
            
            Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Image.asset("assets/images/game_level/${labelNivel}.png", width: 64),
                Text("${labelNivel}", style: TextStyle(color: Colors.yellow),)
              ],
            ),
            
            const SizedBox(height: 32),
              
            Center(
              child: GlassContainer(
                child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colunas,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final card = cards[index];            

                  return GestureDetector(
                    onTap: () => _onCardTap(card),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        final rotate = Tween(begin: pi, end: 0.0).animate(animation);
                        return AnimatedBuilder(
                          animation: rotate,
                          child: child,
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.rotationY(rotate.value),
                              alignment: Alignment.center,
                              child: child,
                            );
                          },
                        );
                      },
                      child: card.isFlipped || card.isMatched
                          ? cardFront(card)
                          : cardBack(),
                    ),
                  );
                },
              ),
            )
          )]
        ),
      ) 
      )
    );
  }
}