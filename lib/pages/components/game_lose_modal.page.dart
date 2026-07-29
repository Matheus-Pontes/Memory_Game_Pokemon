import 'package:flutter/material.dart';
import 'package:memory_game_pokemon/models/user_view_model.dart';
import 'package:memory_game_pokemon/pages/game.page.dart';
import 'package:memory_game_pokemon/pages/login.page.dart';
import 'package:memory_game_pokemon/services/songs_service.dart';

class GameLoseModal extends StatelessWidget {

  final UserViewModel user;

  const GameLoseModal({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.85,
        ),
        child: Column(
          spacing: 16,
          children: [
            Image.asset('assets/images/equiperoquete.png', width: 300),

            Text('A Equipe Rocket venceu dessa vez !', textAlign: .center, style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  )),
            /// BOTÃO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                    Navigator.push(context, 
                      PageRouteBuilder(
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                        pageBuilder: (_, _, _) => GamePage(user: user),)).then((_) {
                            SongsService().playAudioLogin();
                        });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
                child: Text('Tentar novamente', style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),),
              )
            ), 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Recomeçar sua jornada treinador',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        )
        
      ),
    );
  }
}
