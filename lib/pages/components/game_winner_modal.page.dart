import 'package:flutter/material.dart';
import 'package:memory_game_pokemon/pages/game.page.dart';
import 'package:memory_game_pokemon/pages/login.page.dart';
import 'package:memory_game_pokemon/models/user_view_model.dart';
import 'package:memory_game_pokemon/services/songs_service.dart';

class GameWinnerModal extends StatelessWidget {
  final UserViewModel user;
  final int tempoRestante;

  const GameWinnerModal({
    super.key,
    required this.user,
    required this.tempoRestante
  });
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: const Color.fromARGB(255, 24, 20, 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.85,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// TÍTULO
            Text(
              'Parabéns, ${user.name}!!!',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// SUBTEXTO
            Text(
              'Você venceu em ${tempoRestante}s !!!',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white70,
                fontSize: size.width * 0.035,
              ),
            ),

            const SizedBox(height: 20),

            /// BOTÃO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Avançar de nível.
                    // Construir próximo nivel 
                    // Mesma página próximo nível
                    
                    if(user.level == 0)
                    {
                      user.level = 1;
                    }
                    else if(user.level == 1)
                    {
                      user.level = 2;
                    }
                    else
                    {
                      user.level = 0;
                    }

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
                child: Text('Próximo nível >>>', style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),),
              )
            ), 

            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                      pageBuilder: (_, __, ___) => LoginPage(),
                    ),
                  )
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107), 
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
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
        ),
      ),
    );
  }
}
