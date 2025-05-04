# FURIA ChatBot

**Chat interativo para fãs da FURIA Esports.**

Este projeto é um aplicativo mobile desenvolvido em Flutter que oferece uma experiência conversacional para fãs do time de Counter-Strike 2 da FURIA. Os torcedores podem acessar informações sobre jogadores, últimos resultados de eventos, últimos jogos, FAQ e um Quiz.

---

## Funcionalidades

* **Opções de Chat**
   É possível tanto escrever as mensagens programadas ou utilizar os botões pré-prontos. 
   * **Jogadores**: Lista de jogadores e staff com nome, função, país e data de entrada.
   * **Resultados da Equipe**: Desempenho da equipe em torneios recentes, colocação, ganhos e data.
   * **Últimos Jogos**: Histórico dos últimos jogos da FURIA com times, placar, evento, além de data e hora.
   * **FAQ**: Perguntas frequentes sobre a FURIA (com respostas rápidas).
   * **Quiz**: Modo quiz com perguntas de múltipla escolha e verificação de respostas.

* **Opções de interface**
   * **Trocar tema**: Botão de troca de tema do aplicativo.
   * **Fechar chat**: Ao fechar o chat é possível reabrir, o que limpa as mensagens enviadas.

* **Comportamento Inteligente de Scroll**
   * O scroll do chat se ajusta automaticamente para exibir a última mensagem.
   * Caso a nova mensagem seja maior que a altura da tela, o scroll para no início da nova mensagem, permitindo ao usuário ler desde o começo.
   * Quando o teclado é aberto e o usuário está no final do chat, a rolagem permanece no fim, evitando que a visualização se desloque incorretamente.

## Tecnologias Utilizadas

* Flutter & Dart
* JSON para armazenamento de dados locais
* GitHub Actions para CI/CD (build de APK)

## Interface
Utilizei dois temas de cores para a interface, um usando o preto e branco com o contraste da cor dourada, que tive a ideia pelo instagram da Furia (onde os destaques são na cor dourada, e em algumas camisas e outras postagens), e o outro tema somente com a cor preto e branco. 

## Tela inicial

| | Tema principal | Tema secundário |
| ----------- | ----------- | ----------- |
| Tela incial | <img src="https://github.com/user-attachments/assets/4f5bca42-7f8f-4c3f-a439-38bc568767ee" width="300"> | <img src="https://github.com/user-attachments/assets/e1879af5-0fab-49e7-b691-c31034ef3be0" width="300"> |
| Tela do chat | <img src="https://github.com/user-attachments/assets/0a7c8e8b-daba-4bcd-ba22-7b0e39bf047d" width="300"> | <img src="https://github.com/user-attachments/assets/c7ac3990-2514-4037-9830-e48cba173ddc" width="300"> |

### Ao iniciar o chat
Quando o chat é iniciado leva 1 segundo para o bot ficar online (simulando um sistema real)

<img src="https://github.com/user-attachments/assets/750bd1fa-0048-4e95-9ccd-eaacab7ecd64" width="300">
<img src="https://github.com/user-attachments/assets/3d17019e-3c02-4b91-b1bd-09789b774238" width="300">

---

## Download APK (Release)

Para baixar o APK do projeto acesse o link e baixe o arquivo "app-release.apk":  
![Screenshot_20250504_120446_One UI Home2](https://github.com/user-attachments/assets/a26ebdd3-fe45-464a-90e4-4e5fdf0346d9)


---

## Como Rodar Localmente

1. Clone o repositório:

   ```bash
   git clone https://github.com/agsjohn/vaga_desafio.git
   ```
2. Acesse o diretório do projeto:

   ```bash
   cd vaga_desafio
   ```
3. Instale as dependências:

   ```bash
   flutter pub get
   ```
4. Execute o aplicativo em modo debug:

   ```bash
   flutter run
   ```

---

## CI/CD com GitHub Actions

O pipeline está configurado em `.github/workflows/flutter_ci.yml` e realiza:

1. Checkout do código
2. Instalação do Flutter
3. `flutter pub get` para dependências
4. Build do APK de release
5. Upload do artefato (APK) na aba de Actions

Configuração no workflow:

```yaml
name: Flutter CI/CD
on:
  push:
    branches:
      - main
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.29.3'
      - name: Install dependencies
        run: flutter pub get
      - name: Build APK
        run: flutter build apk --release
      - name: Verificar APK gerado
        run: ls -lh build/app/outputs/flutter-apk/
      - name: Upload release APK
        uses: actions/upload-artifact@v4
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

---

## Estrutura do Projeto

```
/vaga_desafio
├─ .github/workflows/flutter_ci.yml   # Pipeline de CI/CD
├─ assets/furia.json                  # Dados do time em JSON
├─ lib/
│  ├─ data/                           # Lógica de leitura e formatação do JSON 
│  │  └─ model/                       # Classes de dados (Jogador, Jogo, etc.)
│  ├─ ui/                             # Lógica de interface
│  │  ├─ _core/                       # Layouts e configurações das telas
│  │  │  ├─ app_themes/               # Temas do aplicativo e configuração dos temas
│  │  │  ├─ widgets/                  # Componentes visuais (chat bubbles, botões, appbar)
│  │  ├─ screens/                     # Telas do aplicativo
│  │  │  ├─ home_screen.dart          # Tela inicial
│  │  │  └─ chat_screen.dart          # Tela de chat interativo
│  └─ main.dart                       # Ponto de entrada
└─ pubspec.yaml                       # Dependências e configuração
```

---

## Contribuição

Este projeto foi desenvolvido para fins de demonstração técnica em processo seletivo. Contribuições são bem-vindas via fork e pull request.

## Licença

Este projeto está sob uma licença de uso exclusivo para fins de avaliação técnica. Veja mais em [LICENSE](https://github.com/agsjohn/vaga_desafio/blob/main/LICENSE)
