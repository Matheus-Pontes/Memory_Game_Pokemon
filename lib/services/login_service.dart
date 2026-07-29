import 'package:flutter/material.dart';
import 'package:memory_game_pokemon/models/user.dart';
import 'package:memory_game_pokemon/models/user_record.dart';
import 'package:memory_game_pokemon/models/user_view_model.dart';
import 'package:memory_game_pokemon/pages/game.page.dart';
import 'package:memory_game_pokemon/services/songs_service.dart';
import 'package:memory_game_pokemon/services/user_service.dart';

class LoginService {

  final UserService _usuarioService = UserService();

  Future<void> iniciarJogo(BuildContext context, String nomeTreinador, int? nivel)  async {

    if (nomeTreinador.isEmpty) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alerta !!!', style: TextStyle(color: Colors.redAccent)),
            content: const Text('Digite seu nome treinador !!!') ,
            actions: [
              TextButton(
                style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                child: const Text('Ok', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
      });

      

      return ;
    }

    // Criar Usuario
    User usuario = User(
      name: nomeTreinador, 
      userRecord: UserRecord(levelGame: nivel, timeRecord: 0)
    );

    UserViewModel usuarioCriado = await _usuarioService.inserirUsuario(usuario);

    Navigator.push(context, 
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (_, _, _) => GamePage(user: usuarioCriado),)).then((_) {
            SongsService().playAudioLogin();
        });
  }


  Future<void> carregarRanking(BuildContext context) async {
    
    // Vai carregar os dados 
    Map<int, List<UserViewModel>> records = await _usuarioService.obterRanking();
    

    // Abrir modal.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultTabController(
          length: 3,
          child: AlertDialog(
            title: const Text(
              'Sua evolução',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 300, // altura obrigatória
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.red,
                    tabs: [
                      Tab(text: '', icon: Image.asset('assets/images/game_level/pichu.png', width: 38,),),
                      Tab(text: '', icon: Image.asset('assets/images/game_level/pikachu.png', width: 38,)),
                      Tab(text: '', icon: Image.asset('assets/images/game_level/raichu.png', width: 38,)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildRankingList(records[0] ?? []),
                        _buildRankingList(records[1] ?? []),
                        _buildRankingList(records[2] ?? []),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }

  Widget _buildRankingList(List<UserViewModel> ranking) {
    if (ranking.isEmpty) {
      return const Center(child: Text('Nenhum recorde ainda.'));
    }
    return ListView.builder(
      itemCount: ranking.length,
      itemBuilder: (context, index) {
        final user = ranking[index];
        return ListTile(
          leading: Text('${index + 1}.', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          title: Text(user.name, style: const TextStyle(fontSize: 15),),
          trailing: Text('${user.timeRecord} s'),
        );
      },
    );
  }

}