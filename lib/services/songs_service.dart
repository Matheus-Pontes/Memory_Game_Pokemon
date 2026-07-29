import 'package:audioplayers/audioplayers.dart';

// Padrão Singleton para não ficar instanciando
class SongsService {

  // Instância única
  static final SongsService _instance = SongsService._internal();
  
  // Getter estático para acesso rápido (mais performático que factory)
  static SongsService get instance => _instance;
  
  factory SongsService() => _instance;
  SongsService._internal();

  final AudioPlayer audioLogin = AudioPlayer();
  final AudioPlayer audioGame = AudioPlayer();
  final AudioPlayer audioEndingGame = AudioPlayer();

  /// Para tudo antes de tocar outro som
  Future<void> stopAll() async {
    await audioLogin.stop();
    await audioGame.stop();
    await audioEndingGame.stop();
  }

  // Música da tela de login
  Future<void> playAudioLogin() async {
    await stopAll();
    await audioLogin.setReleaseMode(ReleaseMode.loop);
    await audioLogin.play(
      AssetSource('songs/opening.mp3'),
      volume: 0.5,
    );
  }

  // Música da tela de jogo
  Future<void> playAudioGameBoard() async {
    await stopAll();
    await audioGame.setReleaseMode(ReleaseMode.loop);
    await audioGame.play(
      AssetSource('songs/sound_game.mp3'),
      volume: 0.6,
    );
  }

  // Música de fim de jogo
  Future<void> playAudioGameEnding() async {
    await stopAll();
    await audioEndingGame.setReleaseMode(ReleaseMode.loop);
    await audioEndingGame.play(
      AssetSource('songs/ending.mp3'),
      volume: 0.5,
    );
  }

}