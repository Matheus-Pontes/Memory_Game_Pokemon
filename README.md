# memory_game_pokemon

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 📱 Flutter Wireless Debugging (Android)

> **Objetivo**: Padronizar o processo de execução e depuração de aplicações Flutter em dispositivos Android físicos **sem uso de cabo USB**, utilizando ADB via Wi‑Fi.

---

## 📌 Escopo

Este procedimento aplica-se a todos os desenvolvedores que utilizam Flutter em ambiente Android (11+), visando:

* Aumentar produtividade (hot reload sem cabo)
* Reduzir dependência de conexão física
* Padronizar setup entre times

---

## 🧾 Pré-requisitos

* Android **11 ou superior**
* Dispositivo e computador na **mesma rede Wi‑Fi**
* ADB instalado (Android SDK / platform-tools)
* Projeto Flutter funcional

---

## 🔧 Configuração no Dispositivo

1. Acessar:

   ```
   Configurações → Opções do desenvolvedor
   ```

2. Ativar:

   * Depuração USB
   * Wireless debugging

3. Selecionar:

   ```
   Wireless debugging → Emparelhar dispositivo com código
   ```

---

## 🔗 Pareamento do Dispositivo (ADB Pair)

No dispositivo será exibido:

* Endereço IP + porta de pareamento
* Código de pareamento (6 dígitos)

No terminal do computador:

```bash
adb pair <IP>:<PORTA>
```

Exemplo:

```bash
adb pair 192.168.0.15:37123
```

Ao solicitar:

```
Enter pairing code:
```

Inserir o código exibido no dispositivo.

---

## 🔌 Conexão com o Dispositivo (ADB Connect)

⚠️ A porta de conexão **é diferente da porta de pareamento**.

No dispositivo, copiar:

```
IP address & Port
```

Executar:

```bash
adb connect <IP>:<PORTA>
```

Exemplo:

```bash
adb connect 192.168.0.15:45678
```

---

## 🧪 Validação da Conexão

```bash
adb devices
```

Saída esperada:

```
192.168.0.15:45678    device
```

---

## 🚀 Execução do Projeto Flutter

### Via terminal

```bash
flutter run
```

### Via VS Code

1. Selecionar dispositivo no canto inferior
2. Pressionar `F5`

---

## ⚡ Hot Reload

Durante execução:

* `r` → Hot Reload
* `R` → Hot Restart

---

## 🔄 Reconexão

Caso a conexão seja perdida:

```bash
adb connect <IP>:<PORTA>
```

> Não é necessário repetir o pareamento (`adb pair`), exceto em casos de perda de autorização.

---

## 🛠️ Troubleshooting

### Dispositivo não listado

```bash
adb kill-server
adb start-server
adb connect <IP>:<PORTA>
```

---

### Comando adb não reconhecido

Adicionar ao PATH do sistema:

```
C:\Users\<usuario>\AppData\Local\Android\Sdk\platform-tools
```

---

### Dispositivo aparece como "offline"

```bash
adb disconnect
adb connect <IP>:<PORTA>
```

---

## ⚙️ Automação (Opcional)

Criar script para agilizar execução.

### Windows (.bat)

```bat
adb connect 192.168.0.15:45678
flutter run
```

---

## 🧠 Resumo Técnico

| Comando     | Função               |
| ----------- | -------------------- |
| adb pair    | Autoriza dispositivo |
| adb connect | Conecta via Wi-Fi    |
| adb devices | Lista dispositivos   |
| flutter run | Executa aplicação    |

---

## 📎 Observações

* A conexão depende da rede local (Wi-Fi)
* IP do dispositivo pode mudar (DHCP)
* Para uso contínuo, recomenda-se IP fixo ou automação

---

## ✅ Resultado Esperado

Após configuração:

* Execução do app Flutter sem cabo USB
* Hot reload funcional
* Integração com ferramentas de debug (VS Code / CLI)

---

**Versão**: 1.0
**Responsável**: Matheus Francisco de Pontes
**Atualização**: 04/2026
