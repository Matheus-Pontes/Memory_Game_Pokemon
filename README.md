# ⚡ Memory Game Pokémon

Um jogo da memória inspirado no universo Pokémon, desenvolvido em **Flutter**, com sistema de progressão de níveis, ranking de treinadores, persistência de dados e efeitos sonoros.

---

## 🎮 Sobre o projeto

O **Memory Game Pokémon** é um jogo da memória onde o jogador assume o papel de um **Treinador Pokémon**. Na tela inicial, o usuário informa seu nome e pode acompanhar o **ranking dos melhores treinadores em cada nível** antes de iniciar uma nova partida.

Ao longo do jogo, o treinador evolui conforme supera os desafios:

* 🐣 **Pichu** — Nível Fácil
* ⚡ **Pikachu** — Nível Médio
* 🌩️ **Raichu** — Nível Difícil

Cada evolução aumenta a quantidade de cartas e o nível de dificuldade, exigindo mais memória, concentração e agilidade para completar a partida.

---

## ✨ Funcionalidades

* 🧑 Cadastro do nome do treinador
* 🏆 Ranking individual para cada nível
* 🎴 Embaralhamento aleatório das cartas
* ⚡ Sistema de comparação de pares
* 📈 Progressão automática entre os níveis
* 🐣 Evolução Pichu → Pikachu → Raichu
* 💾 Persistência de dados utilizando **SQLite**
* 🔊 Efeitos sonoros durante a partida
* 🔄 Reinício da partida
* 📱 Interface responsiva para Android e iOS
* 🎨 Visual inspirado no universo Pokémon

---

## 🕹️ Níveis do jogo

| Nível      | Pokémon | Dificuldade             |
| ---------- | ------- | ----------------------- |
| 🐣 Pichu   | Fácil   | Ideal para iniciantes   |
| ⚡ Pikachu  | Médio   | Desafio intermediário   |
| 🌩️ Raichu | Difícil | Teste máximo de memória |

Ao concluir um nível, o próximo é desbloqueado automaticamente, representando a evolução do seu Pokémon.

---

## 🏆 Sistema de Ranking

Cada nível possui seu próprio ranking de treinadores.

Após concluir uma partida, o resultado é armazenado localmente utilizando **SQLite**, permitindo acompanhar os melhores desempenhos em cada dificuldade.

---

## 💾 Persistência de Dados

O aplicativo utiliza **SQLite** para armazenar informações localmente, como:

* Nome do treinador
* Ranking por nível
* Pontuação ou tempo da partida

Dessa forma, os dados permanecem disponíveis mesmo após o fechamento do aplicativo.

---

## 🔊 Experiência do Jogo

Para tornar a experiência mais imersiva, o jogo conta com efeitos sonoros durante as principais ações, como:

* Virar uma carta
* Encontrar um par correto
* Finalizar uma partida
* Evoluir para um novo nível

---

## 📸 Demonstração

Adicione aqui capturas de tela do aplicativo.

### Tela Inicial

* Cadastro do treinador
* Ranking por nível
* Início da partida

### Tela do Jogo

* Cartas do jogo
* Evolução atual
* Contador da partida

```md
![Tela Inicial](assets/readme/home.png)

![Jogo](assets/readme/game.png)

![Ranking](assets/readme/ranking.png)
```

---

## 🚀 Tecnologias Utilizadas

* Flutter
* Dart
* SQLite
* Material Design
* Audio Players (efeitos sonoros)

---

## ▶️ Como executar

```bash
git clone https://github.com/Matheus-Pontes/Memory_Game_Pokemon.git

cd Memory_Game_Pokemon

flutter pub get

flutter run
```

---

## 🎯 Como Jogar

1. Informe o nome do treinador.
2. Consulte o ranking do nível desejado.
3. Inicie a partida.
4. Encontre todos os pares de cartas.
5. Complete o desafio para desbloquear o próximo nível.
6. Alcance o topo do ranking em todas as evoluções.

---

## 🧠 Conceitos Aplicados

Este projeto foi desenvolvido para praticar diversos conceitos do Flutter, entre eles:

* Gerenciamento de estado
* Navegação entre telas
* Widgets personalizados
* Organização em camadas
* Persistência de dados com SQLite
* Manipulação de listas
* Algoritmo de embaralhamento
* Reprodução de áudio
* Responsividade
* Boas práticas de desenvolvimento

---

## 🚀 Melhorias Futuras

* 🌐 Ranking online
* ☁️ Sincronização em nuvem
* 🎵 Música de fundo configurável
* ✨ Novas animações
* 🏅 Sistema de conquistas
* 👥 Multiplayer local
* 🎮 Novos níveis inspirados em outras gerações Pokémon

---

## 👨‍💻 Autor

**Matheus Pontes**

Desenvolvedor Full Stack apaixonado por desenvolvimento mobile, interfaces modernas e criação de aplicações utilizando Flutter.

* GitHub: https://github.com/Matheus-Pontes
* Portfólio: https://matheuspontes.vercel.app/

---

## ⭐ Apoie o Projeto

Se este projeto foi útil ou serviu como inspiração, deixe uma ⭐ no repositório.

Esse pequeno gesto ajuda bastante na divulgação do projeto.

---

## 📄 Licença

Este projeto está licenciado sob a licença **MIT**.
