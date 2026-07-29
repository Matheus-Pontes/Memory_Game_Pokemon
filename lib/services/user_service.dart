import 'package:memory_game_pokemon/models/user.dart';
import 'package:memory_game_pokemon/models/user_view_model.dart';
import 'package:memory_game_pokemon/repository/user_repository.dart';

class UserService {
  final UsuarioRepository _repository = UsuarioRepository();

  Future<UserViewModel> inserirUsuario(User usuario) async {
    try {
      final id = await _repository.inserir(usuario);
      return UserViewModel(
        userId: id,
        name: usuario.name,
        level: usuario.userRecord?.levelGame ?? 0
      );
    } catch (e) {
      // Aqui podemos logar o erro se desejado
      print(e);
      throw Exception('Não foi possível salvar o usuário. Por favor, verifique sua conexão e tente novamente.');
    }
  }

  Future<bool> atualizarUsuario(User usuario) async {
    try {
      final usuarioId = await _repository.inserirUserRecord(usuario.userRecord);
      return usuarioId > 0;
    } catch (e) {
      // Aqui podemos logar o erro se desejado
      throw Exception('Não foi possível atualizar o usuário. Por favor, verifique sua conexão e tente novamente.');
    }
  }

  Future<Map<int, List<UserViewModel>>> obterRanking() async {
    try {
      return await _repository.obterRanking();
    } catch (e) {
      // Aqui podemos logar o erro se desejado
      print(e);
      throw Exception('Não foi possível obter o ranking. Por favor, verifique sua conexão e tente novamente.');
    }
  }
}