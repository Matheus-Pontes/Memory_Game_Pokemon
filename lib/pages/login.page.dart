import 'package:flutter/material.dart';
import 'package:memory_game_pokemon/pages/components/base_layout.page.dart';
import 'package:memory_game_pokemon/services/login_service.dart';
import 'package:memory_game_pokemon/services/songs_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _headerColor = Colors.redAccent;
  static const _primaryColor = Color(0xFFFF4B4B);
  static const _titleFontSize = 24.0;
  static const _borderRadius = 12.0;
  static const _padding = 24.0;
  static const _buttonHeight = 56.0;
  static const _spacing = 8.0;
  static const _largeSpacing = 12.0;
  
  final LoginService _loginService = LoginService();
  late final TextEditingController _nomeTreinadorController;
  
  @override
  void initState() {
    super.initState();
    SongsService.instance.playAudioLogin();
    _nomeTreinadorController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeTreinadorController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return BaseLayout(
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              _buildLoginCard(),
            ],
          ),
        )
      ),
    ),
  );
}

Widget _buildHeader() {
  return Container(
    padding: const EdgeInsets.all(_padding),
    decoration: const BoxDecoration(
      color: _headerColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(_borderRadius),
        topRight: Radius.circular(_borderRadius),
      ),
    ),
    child: const Column(
      children: [
        Text(
          'Pokémon',
          style: TextStyle(
            color: Colors.yellow,
            fontSize: _titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: _spacing),
        Text(
          'Memory Game',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: _largeSpacing),
        Text(
          'Prepare-se para testar sua memória',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_borderRadius),
          bottomRight: Radius.circular(_borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Seu nome treinador',
            style: TextStyle(color: Colors.black),
          ),
          TextField(
            controller: _nomeTreinadorController,
            cursorColor: _headerColor,
            decoration: const InputDecoration(
              hintText: 'Ex: Ash Ketchum',
              hintStyle: TextStyle(fontSize: 12, color: Colors.black26),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _headerColor),
              ),
            ),
          ),
          const SizedBox(height: _padding),
          _buildMainButton(),
          const SizedBox(height: 16),
          _buildRankingButton(),
        ],
      ),
    );
  }

  Widget _buildMainButton() {
    return SizedBox(
      height: _buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          _loginService.iniciarJogo(
            context,
            _nomeTreinadorController.text,
            0,
          );
          _nomeTreinadorController.clear();
        },
        child: const Text(
          'Iniciar jornada',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRankingButton() {
    return TextButton.icon(
      onPressed: () {
        _loginService.carregarRanking(context);
      },
      icon: const Icon(Icons.emoji_events, color: Colors.amber),
      label: const Text(
        'Ver Ranking',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}